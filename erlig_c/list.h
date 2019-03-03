#ifndef __KEYLIST_H
#define __KEYLIST_H

#include <stdlib.h>
#include "node.h"


struct KeyList{
  size_t buffer_count;
  struct Node * head;
};

void add_buffer(struct KeyList * list, struct Node * node);

#endif








