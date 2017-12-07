#include <inc/lib.h>

void *
mmap(void *addr, size_t length, int prot, int flags,
           int fdnum, off_t offset) {
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
	addr = (void *)sys_reserve_continuous_pages(0, addr, length, PTE_U | PTE_W | PTE_P);
	if (addr == 0) {
		cprintf("mmap: failed to find continous pages"); // error
	}

	cprintf("mmap: addr = %x\n", addr);

	read(fdnum, addr, length);

	return addr;

	// return (*dev->dev_mmap)(addr, length, prot, flags,
					        // fd, offset);
}