#include <myfunc.h>

void recursion(char* path){
    struct dirent * pdirent;
    char str[1024] = {0};
    DIR* dirp = opendir(path);
    ERROR_CHECK(dirp,NULL,"opendir");

    while((pdirent = readdir(dirp)) != NULL){
        if((strcmp(pdirent->d_name,".") == 0) || (strcmp(pdirent->d_name,"..") == 0)){
            continue;
        }
        printf("%s\n",pdirent->d_name);
        // sprintf(str,"%s%s",path,"/");
        // sprintf(str + strlen(str),"%s",pdirent->d_name);
        sprintf(str,"%s/%s",path,pdirent->d_name);
        // d_type为4的时候，代表其是一个目录，进入递归
        if(pdirent->d_type == DT_DIR){
            recursion(str);
        }
    }
    closedir(dirp);
    return;
}

int main(int argc, char* argv[])
{
    ARGS_CHECK(argc,2);

    recursion(argv[1]);

    return 0;
}
