#include "node.h"

void add(struct Node ** head, const size_t size, char * buffer){
  struct Node * new_node = (struct Node *)malloc(sizeof(struct Node));
  struct Node * prev = *head;
  new_node->buffer_length = size;
  new_node->buffer = buffer;

  if(*head == NULL){
    *head = new_node;
    return;
  }

  while(prev->next != NULL){
    prev = prev->next;
  }
  prev->next = new_node;
}

