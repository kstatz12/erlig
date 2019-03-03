/*


Copyright (C) [2019] by [Karl Statz <<karl dot statz at gmail dot com:wa]

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without l> imitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/

#include "file.h"
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <errno.h>

int dir_exists(const char *path);

FILE * open_append(const char * path){
  if(!dir_exists(path)){
    mkdir(path, 0777);
  }
  chdir(path);
  return fopen(FILENAME, "ab+");
}

FILE * open_read(const char * path){
  if(!dir_exists(path)){
    fprintf(stderr, "File Directory Doesn't Exist");
    exit(-1);
  }
  chdir(path);
  FILE * fp =  fopen(FILENAME, "r");
  if(fp == NULL){
    if(errno == EINVAL){
      fprintf(stderr, "Invalid Mode Provided to fopen");
      exit(errno);
    }
  }
  return fp;
}


int next_buffer_pos(FILE * fp){
  long current_pos = ftell(fp);
  return fseek(fp, current_pos+KEYBUFFERSIZE, SEEK_SET);
}

int next_key_pos(FILE * fp){
  long current_pos = ftell(fp); 
  return fseek(fp, current_pos+KEYSIZE, SEEK_SET);
}

void reset_pos(FILE * fp){
  rewind(fp);
}

int dir_exists(const char *path){
  struct stat buffer = {0};
  return stat(path, &buffer) == -1 ? 0 : 1;
}


