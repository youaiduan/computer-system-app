#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

#define DEF_MODE S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH

int main(int argc, char const *argv[])
{
    int fd = open("./c.txt", O_RDWR, DEF_MODE);

    int size = 1024;
    char buf[size];
    // buf[size-2] = '\0';

// 读取文件
    int read_size = 0;
    // while(read_size = read(fd, buf, size-1)) {
    //     if(read_size == -1) {
    //         printf("read error...\n");
    //         return 1;
    //     }

    //     buf[read_size] = '\0';
    //     printf("%s", buf);
    // }

    // 写入文件
    char *txt = "你好，世界";
    write(1, txt, strlen(txt));

    close(fd);

    return 0;
}
