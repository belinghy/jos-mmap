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
umain(int argc, char **argv)
{
    cprintf("Test: test_mmap\n");

    int fdnum = open("lorem", O_RDONLY);
    struct Stat stat;
    fstat(fdnum, &stat);
    cprintf("file size = %lld\n", stat.st_size);
    void *address = mmap(NULL, stat.st_size, 0, 0,
                         fdnum, 0);

    // FIXME: Shouldn't need to do this.
    // Permission is wrong
    
    seek(fdnum, 0);
    cprintf("========OUTPUT from cat\n");
    cat(fdnum, "<stdin>");

    cprintf("========OUTPUT from mmap\n");
    char *mmap_context = (char *)address;
    for (int i = 0; i < stat.st_size / sizeof(char); ++i) {
        cprintf("%c", mmap_context[i]);
    }
    close(fdnum);
}
