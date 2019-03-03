/*
Copyright (C) [2019] by [Karl Statz <<karl dot statz at gmail dot com:wa]

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without l> imitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/

#include "mngr.h"

struct KeyList * get_keys(const char * path){
  FILE * fp = open_read(path);
  if(fseek(fp, 0L, SEEK_END) > KEYBUFFERSIZE){
    rewind(fp);

  }

}

void save_key(const char * path, const char * key){
  FILE * fp = open_append(path);
  if(fp != NULL){
    fprintf(fp, "%s", key);
    fclose(fp);
    return;
  }
  fprintf(stderr, "%s", "Could Not Save To File");
}

int fill_node(FILE *fp, struct Node * new_node){
  char * buffer = (char *)malloc(sizeof(char) * KEYBUFFERSIZE);
  if(fread(buffer, sizeof(char), KEYBUFFERSIZE, fp) == KEYBUFFERSIZE){
    new_node->buffer_length = KEYBUFFERSIZE;
    new_node->buffer = buffer;
    new_node->next = NULL;
    return FILLNODE_OK
  }
  else{
    if(feof(fp) == 1){
      return FILLNODE_EOF
    }
    return FILLNODE_ERR;
  }
}

