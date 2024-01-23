#include <myfunc.h>

void get_file_permission(struct stat buffer,char str[]){
    mode_t perm_val = (buffer.st_mode & S_IFMT);
    str[0] = (buffer.st_mode & S_IRUSR) ? 'r' : '-';
    str[1] = (buffer.st_mode & S_IWUSR) ? 'w' : '-';
    str[2] = (buffer.st_mode & S_IXUSR) ? 'x' : '-';
    str[3] = (buffer.st_mode & S_IRGRP) ? 'r' : '-';
    str[4] = (buffer.st_mode & S_IWGRP) ? 'w' : '-';
    str[5] = (buffer.st_mode & S_IXGRP) ? 'x' : '-';
    str[6] = (buffer.st_mode & S_IROTH) ? 'r' : '-';
    str[7] = (buffer.st_mode & S_IWOTH) ? 'w' : '-';
    str[8] = (buffer.st_mode & S_IXOTH) ? 'x' : '-';
    str[9] = '\0';
}

char get_file_type(struct stat buffer){
    switch(buffer.st_mode & S_IFMT){
    case S_IFBLK: 
        return 'b';
    case S_IFCHR:
        return 'c';
    case S_IFDIR:
        return 'd';
    case S_IFIFO:
        return 'p';
    case S_IFLNK:
        return 'l';
    case S_IFREG:
        return '-';
    case S_IFSOCK:
        return 's';
    default:
        return '?';
    }
} 

struct tm* get_current_time(const time_t* c_time){
    return localtime(c_time);
} 

void get_split_date(struct tm* get_current_time,int *month,int *day,int *hour,int *minute){
    *month = get_current_time->tm_mon + 1;
    *day = get_current_time->tm_mday;
    *hour = get_current_time->tm_hour;
    *minute = get_current_time->tm_min;
    
}

char* get_user_name(uid_t uid){
    return getpwuid(uid)->pw_name;
}

char* get_group_name(gid_t gid){
    return getgrgid(gid)->gr_name;
}

int main(int argc,char* argv[]){
    // 检查传入参数
    ARGS_CHECK(argc,2);
    DIR* dirp = opendir(argv[1]);
    ERROR_CHECK(dirp,NULL,"opendir");
    struct dirent* pdirent;

    while((pdirent = readdir(dirp)) != NULL){
       if(pdirent->d_name[0] == '.'){
            continue;
        }
        char path[1024] = {0};
        struct stat s_buf;
        sprintf(path,"%s/%s",argv[1],pdirent->d_name);
        int ret = stat(path,&s_buf);
        ERROR_CHECK(ret,-1,"stat");
        
        int c_month,c_day,c_hour,c_minute;
        
        char file_type = get_file_type(s_buf);
        
        char file_permission[1024] = {0};

        get_file_permission(s_buf,file_permission);

        const time_t* ptr_to_current_time = &s_buf.st_mtime;
        struct tm* get_time = get_current_time(ptr_to_current_time);
        get_split_date(get_time,&c_month,&c_day,&c_hour,&c_minute);
        printf("%ld %c %s %ld %s %s %ld %d月 %d %02d:%02d %s\n",
                                    s_buf.st_ino,
                                    file_type,
                                    file_permission,
                                    s_buf.st_nlink,
                                    get_user_name(s_buf.st_uid),
                                    get_group_name(s_buf.st_gid),
                                    s_buf.st_size,
                                    c_month,
                                    c_day,
                                    c_hour,
                                    c_minute,
                                    pdirent->d_name
                                    );
    }
    closedir(dirp);
    return 0;
}

