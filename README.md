# JOS/mmap

## Brief introduction of main files

[`inc/lib.h`](https://github.com/belinghy/jos-mmap/blob/master/inc/lib.h) contains the declarations and some data stuctures
```c
#define PROT_NONE   0
#define PROT_READ   1
#define PROT_WRITE  2
#define PROT_EXEC   3

#define MAP_PRIVATE 0
#define MAP_SHARED  1

typedef struct mmap_entry
{
    ...
} mmap_entry;

typedef struct mmap_entry_bucket
{
    ...
} mmap_entry_bucket;
```

[`lib/mmap.c`](https://github.com/belinghy/jos-mmap/blob/master/lib/mmap.c) contains the implementation of `mmap`

```c
// for mmap
void * mmap(void *addr, size_t length, int permission, int flags,
            int fdnum, off_t offset);

// for unmapping
int munmap(void *addr, size_t length);

// for handling page fault, which the user first access the mapped pages
void pgfault_upcall(struct UTrapframe *tf);

// other helper functions
...
```

[`user/test_mmap.c`](https://github.com/belinghy/jos-mmap/blob/master/user/test_mmap.c) contains the testing files. You can configure which test to run in the `umain(...)`.

`make qemu-nox` to start the OS, then type `test_mmap` to run the test.