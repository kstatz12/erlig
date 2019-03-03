#ifndef __MNGER_H
#define __MNGER_H

/*-----------------------------------------------------------------------------
 * Erlig Manager, Grabs Keys From File
 *----------------------------------------------------------------------------*/

#include "file.h"
#include "list.h"

#define FILLNODE_OK = 0
#define FILLNODE_ERR = 1
#define FILLNODE_EOF = 2

/* gets all of the keys from the file */
struct KeyList * get_keys(const char * path);

/* saves key to the end of the file */
void save_key(const char * path, const char * key)

#endif

