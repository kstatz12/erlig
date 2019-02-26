#include <time.h>
#include <stdlib.h>
#include <string.h>
#include "file_system.h"

void init(){
  FILE * f_ptr = NULL;
  char * filename = NULL;

}

char * generate(){
  char * filename_buffer = (char*)malloc(FILENAMELEN * sizeof(char));
  char * file_type = ".dat\0";
  unsigned long timestamp = time(NULL);
  char * timestamp_str = NULL;
  sprintf(timestamp_str, "%ld", timestamp);
  strncpy(strcat(timestamp_str, file_type), filename_buffer, FILENAMELEN);
  return filename_buffer;
}

void create_file(char * filename){
  char error_flag = 0;
  char read_mode_flag = 1;
  FILE * f_ptr = NULL;
  f_ptr = fopen(filename, "rb+");
  if(f_ptr == NULL){
    read_mode_flag = 0;
    f_ptr = fopen(filename, "wb");
    if(f_ptr == NULL){
      error_flag = 1;
    }
  }
  if(!error_flag){
    exit(EXIT_FAILURE);
  }
  if(read_mode_flag){
    
  }


}

void cleanup(void * ptr){
  free(ptr);
}

