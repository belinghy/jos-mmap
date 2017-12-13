#include <inc/lib.h>

typedef struct mmap_entry
{
    struct Stat file_stat;
    int fdnum;
    void *addr;
    size_t length;
    int permission;
    off_t offset;
    struct mmap_entry *next;
    int ref_count;
} mmap_entry;

typedef struct mmap_entry_bucket
{
    int n_entries;
    mmap_entry *mmap_entrys;
    struct mmap_entry_bucket *next;
} mmap_entry_bucket;

static mmap_entry *mmap_entry_root = NULL;
static mmap_entry_bucket *mmap_entry_bucket_root = NULL;

mmap_entry_bucket *mmap_entry_bucket_alloc() {
    mmap_entry_bucket *bucket = (mmap_entry_bucket *)sys_alloc_continuous_pages(0, (void *)0xC0000000, 1, PTE_U | PTE_W | PTE_P);
    if (bucket == 0) {
        panic("no memory left for mmap");
    }
    bucket->n_entries = (PGSIZE - sizeof(mmap_entry_bucket)) / sizeof(mmap_entry);
    bucket->mmap_entrys = (mmap_entry *)((int)bucket + sizeof(mmap_entry_bucket));
    for (int i = 0; i < bucket->n_entries; ++i)
    {
        mmap_entry *entry = bucket->mmap_entrys + i;
        entry->ref_count = 0;
    }
    bucket->next = mmap_entry_bucket_root;
    mmap_entry_bucket_root = bucket;
    return bucket;
}

mmap_entry *find_empty_mmap_entry() {
    mmap_entry_bucket *bucket = mmap_entry_bucket_root;
    while (bucket != NULL) {
        for (int i = 0; i < bucket->n_entries; ++i)
        {
            mmap_entry *entry = bucket->mmap_entrys + i;
            if (!entry->ref_count) return entry;
        }
        bucket = bucket->next;
    }
    return NULL;
}

mmap_entry *mmap_lookup(int fdnum, size_t length, int permission, off_t offset) {
    mmap_entry *current_entry = mmap_entry_root;

    while (current_entry != NULL) {
        if (current_entry->fdnum == fdnum
                && (current_entry->length = length) // once covered, we can use it
                && current_entry->permission == permission
                && current_entry->offset == offset
                && current_entry->ref_count > 0) {
            return current_entry;
        }
        current_entry = current_entry->next;
    }

    return NULL;
}

mmap_entry *mmap_lookup_by_addr(void *addr, size_t length) {
    mmap_entry *current_entry = mmap_entry_root;

    while (current_entry != NULL) {
        if (current_entry->addr == addr
                && current_entry->length == length) {
            return current_entry;
        }
        current_entry = current_entry->next;
    }

    return NULL;
}

mmap_entry *mmap_entry_alloc() {
    mmap_entry *entry = find_empty_mmap_entry();
    if (entry == NULL) {
        mmap_entry_bucket *bucket = mmap_entry_bucket_alloc();
        entry = find_empty_mmap_entry();
    }
    entry->next = mmap_entry_root;
    mmap_entry_root = entry;
    return entry;
}

void *
mmap(void *addr, size_t length, int permission, int flags,
           int fdnum, off_t offset) {
    mmap_entry *entry = mmap_lookup(fdnum, length, permission, offset);
    if (entry != NULL) {
        entry->ref_count++;
        return entry->addr + offset - entry->offset;
    }

    int r;
    struct Dev *dev;
    struct Fd *fd;
    if ((r = fd_lookup(fdnum, &fd)) < 0
        || (r = dev_lookup(fd->fd_dev_id, &dev)) < 0)
        return NULL; // something wrong!!!
    if ((fd->fd_omode & O_ACCMODE) == O_WRONLY) {
        cprintf("[%08x] mmap %d -- bad mode\n", thisenv->env_id, fdnum);
        return NULL; // something wrong!!!
    }
    if (!dev->dev_read)
        return NULL; // something wrong!!!

    int any_integer = 9;
    addr = (void *)sys_alloc_continuous_pages(0, addr, length, PTE_U | PTE_W | PTE_P);
    if (addr == 0) {
        panic("mmap: failed to find continous pages"); // error
    }

    read(fdnum, addr, length);

    entry = mmap_entry_alloc();
    entry->ref_count = 1;
    entry->fdnum = fdnum;
    entry->length = length;
    entry->permission = permission;
    entry->offset = offset;
    entry->addr = addr;
    fstat(fdnum, &entry->file_stat);

    return addr;

    // return (*dev->dev_mmap)(addr, length, prot, flags,
                            // fd, offset);
}

int
munmap(void *addr, size_t length) {
    mmap_entry *entry = mmap_lookup_by_addr(addr, length);
    if (entry == NULL) {
        panic("try to ummap an addr that has not been mapped yet.");
    }
    if (--entry->ref_count == 0 && (entry->permission == PROT_WRITE)) {
        int fdnum = entry->fdnum;
        // check if the file is close or not
        bool reopened = false;
        struct Fd *fd;
        int r;
        if ((r = fd_lookup(entry->fdnum, &fd)) < 0) {
            reopened = true;
            // open the file
            fdnum = open(entry->file_stat.st_name, O_WRONLY);
        }
        write(fdnum, addr, length);
        if (reopened) {
            close(fdnum);
        }
    }
    return 0;
}
