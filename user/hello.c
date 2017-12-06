// hello, world
#include <inc/lib.h>

char buf[8192];
char buf_mmap[8192];

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
	cprintf("hello, world\n");
	cprintf("i am environment %08x\n", thisenv->env_id);
    int fdnum = open("lorem", O_RDONLY);
    struct Stat stat;
    fstat(fdnum, &stat);
    cprintf("file size = %lld\n", stat.st_size);
    void *address = mmap(NULL, stat.st_size, 0, 0,
                         fdnum, 0);
    memcpy(buf_mmap, address, stat.st_size);
    close(fdnum);
    fdnum = open("lorem", O_RDONLY);
    cprintf("========OUTPUT from cat\n");
    cat(fdnum, "<stdin>");
    cprintf("========OUTPUT from mmap\n");
    for (int i = 0; i < stat.st_size / sizeof(char); ++i) {
        cprintf("%c", buf_mmap[i]);
    }
}
