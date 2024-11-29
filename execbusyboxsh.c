#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>

int
main()
{
    char *args[] = { "/bin/busybox", "sh", NULL };

    printf("The real user ID is %d\n", getuid());
    printf("The effective user ID is %d\n", geteuid());

    setuid(0);

    execvp(args[0], args);
     
    return 0;
}
