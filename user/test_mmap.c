// hello, world
#include <inc/lib.h>

char buf[8192];

void
cat(int f, char *s)
{
    long n;
    int r;

    while ((n = read(f, buf, (long)sizeof(buf))) > 0)
        if ((r = write(1, buf, n)) != n)
            panic("write error copying %s: %e", s, r);
    if (n < 0)
        panic("error reading %s: %e", s, n);
}

void 
test_read_integrity() {
    cprintf("Test: test_mmap\n");

    int fdnum = open("lorem", O_RDONLY);
    struct Stat stat;
    fstat(fdnum, &stat);
    cprintf("file size = %lld\n", stat.st_size);
    void *address = mmap(NULL, stat.st_size, PROT_READ, MAP_PRIVATE,
                         fdnum, 0);

    seek(fdnum, 0);
    cprintf("========OUTPUT from cat\n");
    cat(fdnum, "<stdin>");

    cprintf("========OUTPUT from mmap\n");
    char *mmap_context = (char *)address;
    for (int i = 0; i < stat.st_size / sizeof(char); ++i) {
        cprintf("%c", mmap_context[i]);
    }
    close(fdnum);
    munmap(address, stat.st_size);
}

void 
test_multiple_mmap(int n) {
    int fdnum = open("lorem", O_RDONLY);
    struct Stat stat;
    fstat(fdnum, &stat);
    cprintf("%3d/100\r\n", 0);
    // close(fdnum);
    for (int i = 0; i < n; ++i)
    {
        // int fdnum = open("lorem", O_RDONLY);

        void *address = mmap(NULL, stat.st_size, PROT_READ, MAP_SHARED,
                             fdnum, 0);
        // cprintf("mmap address of %d try = %p\n", i + 1, address);
        // cprintf("%s", (char *)address);
        
        // close(fdnum);
        
        // if ((i + 1) % (n / 100) == 0) {
        //     cprintf("%3d/100\n", (i + 1) / (n / 100));
        // }
    }
    close(fdnum);
    cprintf("%3d/100\r\n", 100);
}

void 
test_multiple_cat(int n) {
    cprintf("%3d/100\r\n", 0);
    int fdnum = open("lorem", O_RDONLY);
    for (int i = 0; i < n; ++i)
    {
        // int fdnum = open("lorem", O_RDONLY);
        
        int _n;
        while ((_n = read(fdnum, buf, (long)sizeof(buf))) > 0);
        // if ((i + 1) % (n / 100) == 0) {
        //     cprintf("%3d/100\n", (i + 1) / (n / 100));
        // }
        // close(fdnum);
    }
    close(fdnum);
    cprintf("%3d/100\r\n", 100);
}

void
test_munmap() {
    int fdnum = open("lorem", O_RDWR);
    struct Stat stat;
    fstat(fdnum, &stat);
    cat(fdnum, "<stdin>");
    
    seek(fdnum, 0);
    void *address = mmap(NULL, stat.st_size, PROT_WRITE, MAP_SHARED,
                         fdnum, 0);
    cprintf("%s", (char *)address);

    close(fdnum);
    ((char *)address)[0] = '-';
    munmap(address, stat.st_size);

    fdnum = open("lorem", O_RDONLY);
    cat(fdnum, "<stdin>");
    close(fdnum);
}

void
test_mmap_shared_private() {
    int fdnum = open("lorem", O_RDONLY);
    struct Stat stat;
    fstat(fdnum, &stat);
    
    void *address1 = mmap(NULL, stat.st_size, PROT_READ, MAP_SHARED,
                         fdnum, 0);
    void *address2 = mmap(NULL, stat.st_size, PROT_READ, MAP_SHARED,
                         fdnum, 0);
    void *address3 = mmap(NULL, stat.st_size, PROT_READ, MAP_PRIVATE,
                         fdnum, 0);

    // first two should be the same
    cprintf("%p %p %p\r\n", address1, address2, address3);
    munmap(address1, stat.st_size);
    munmap(address2, stat.st_size);
    munmap(address3, stat.st_size);
    close(fdnum);
}

void
umain(int argc, char **argv)
{
    // test_read_integrity();
    // cprintf("[!!!] 1000\r\n"); test_multiple_cat(1000);    test_multiple_cat(1000);    test_multiple_cat(1000);
    // cprintf("[!!!] 10000\r\n"); test_multiple_cat(10000);    test_multiple_cat(10000);    test_multiple_cat(10000);
    // cprintf("[!!!] 30000\r\n"); test_multiple_cat(30000);    test_multiple_cat(30000);    test_multiple_cat(30000);
    // cprintf("[!!!] 60000\r\n"); test_multiple_cat(60000);    test_multiple_cat(60000);    test_multiple_cat(60000);
    // cprintf("[!!!] 100000\r\n"); test_multiple_cat(100000);    test_multiple_cat(100000);    test_multiple_cat(100000);
    // cprintf("[!!!] 1000\r\n"); test_multiple_mmap(1000);    test_multiple_mmap(1000);    test_multiple_mmap(1000);
    // cprintf("[!!!] 10000\r\n"); test_multiple_mmap(10000);    test_multiple_mmap(10000);    test_multiple_mmap(10000);
    // cprintf("[!!!] 30000\r\n"); test_multiple_mmap(30000);    test_multiple_mmap(30000);    test_multiple_mmap(30000);
    // cprintf("[!!!] 60000\r\n"); test_multiple_mmap(60000);    test_multiple_mmap(60000);    test_multiple_mmap(60000);
    // cprintf("[!!!] 100000\r\n"); test_multiple_mmap(100000);    test_multiple_mmap(100000);    test_multiple_mmap(100000);
    test_munmap();
    test_mmap_shared_private();
}
