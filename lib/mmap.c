#include <inc/lib.h>

typedef struct mmap_entry
{
    int fdnum;
    void *addr;
    size_t length;
    int permission;
    off_t offset;
    struct mmap_entry *next;
    bool occupied;
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
    cprintf("allocating mmap entry bucket\n");
    mmap_entry_bucket *bucket = (mmap_entry_bucket *)sys_alloc_continuous_pages(0, (void *)0xC0000000, 1, PTE_U | PTE_W | PTE_P);
    if (bucket == 0) {
        panic("no memory left for mmap");
    }
    cprintf("\tbucket allocated at %p\n", bucket);
    cprintf("\tsizeof(mmap_entry) = %d\n", sizeof(mmap_entry));
    bucket->n_entries = (PGSIZE - sizeof(mmap_entry_bucket)) / sizeof(mmap_entry);
    cprintf("\tbucket n_entries %d\n", bucket->n_entries);
    bucket->mmap_entrys = (mmap_entry *)((int)bucket + sizeof(mmap_entry_bucket));
    cprintf("\tbucket mmap_entrys start at %p\n", bucket->mmap_entrys);
    for (int i = 0; i < bucket->n_entries; ++i)
    {
        mmap_entry *entry = bucket->mmap_entrys + i;
        entry->occupied = false;
    }
    bucket->next = mmap_entry_bucket_root;
    mmap_entry_bucket_root = bucket;
    return bucket;
}

mmap_entry *find_empty_mmap_entry() {
    cprintf("looking for empty mmap_entry\n");
    mmap_entry_bucket *bucket = mmap_entry_bucket_root;
    while (bucket != NULL) {
        for (int i = 0; i < bucket->n_entries; ++i)
        {
            mmap_entry *entry = bucket->mmap_entrys + i;
            if (!entry->occupied) return entry;
        }
        bucket = bucket->next;
    }
    return NULL;
}

mmap_entry *mmap_lookup(int fdnum, size_t length, int permission, off_t offset) {
    cprintf("looking for mmap_entry, mmap_entry_root = %p\n", mmap_entry_root);
    mmap_entry *current_entry = mmap_entry_root;

    while (current_entry != NULL) {
        if (current_entry->fdnum == fdnum
                && (current_entry->offset + current_entry->length >= offset + length) // once covered, we can use it
                && current_entry->permission == permission
                && current_entry->offset <= offset) {
            cprintf("found mmap_entry\n");
            return current_entry;
        }
        current_entry = current_entry->next;
    }

    cprintf("did not find mmap_entry\n");
    return NULL;
}

mmap_entry *mmap_entry_alloc() {
    cprintf("allocating mmap entry\n");
    mmap_entry *entry = find_empty_mmap_entry();
    if (entry == NULL) {
        cprintf("all mmap bucket are full\n");
        mmap_entry_bucket *bucket = mmap_entry_bucket_alloc();
        entry = find_empty_mmap_entry();
    }
    cprintf("\tcurrent mmap_entry_root = %p\n", mmap_entry_root);
    entry->next = mmap_entry_root;
    mmap_entry_root = entry;
    cprintf("\t entry (%p)'s next = %p\n", entry, entry->next);
    return entry;
}

void *
mmap(void *addr, size_t length, int permission, int flags,
           int fdnum, off_t offset) {
    permission = PTE_U | PTE_W | PTE_P;

    mmap_entry *entry = mmap_lookup(fdnum, length, permission, offset);
    if (entry != NULL) {
        return entry->addr + offset - entry->offset;
    }

    cprintf("THIS IS OUR MMAP\n");
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
        cprintf("mmap: failed to find continous pages"); // error
    }

    cprintf("mmap: addr = %p\n", addr);
    cprintf("read(%d, %p, %x)\n", fdnum, addr, length);
    read(fdnum, addr, length);

    entry = mmap_entry_alloc();
    entry->occupied = true;
    entry->fdnum = fdnum;
    entry->length = length;
    entry->permission = permission;
    entry->offset = offset;
    entry->addr = addr;

    return addr;

    // return (*dev->dev_mmap)(addr, length, prot, flags,
                            // fd, offset);
}

