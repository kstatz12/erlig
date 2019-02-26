#include <stdio.h>

#define FILENAMELEN 24

typedef struct {
  char * key;
} Key;

typedef struct {
  Key * keys;
  int count;
} Keys;




void init();


Keys * get_keys(const char* filename);
