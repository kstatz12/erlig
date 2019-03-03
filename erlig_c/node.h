#ifndef __NODE_H
#define __NODE_H

#include <stdlib.h>
#define MAXBUFFER 6400

struct Node{
  size_t buffer_length;
  char * buffer;
  struct Node * next;
};

void add(struct Node ** head, const size_t size, char * buffer);

#endif
