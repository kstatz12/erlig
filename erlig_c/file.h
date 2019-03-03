#ifndef __FILE_H
#define __FILE_H

/*-----------------------------------------------------------------------------
 * Erlig File Operations
 *----------------------------------------------------------------------------*/

#include <stdio.h>
#include <stdlib.h>

/* static file name for the erlig data file */
#define FILENAME "erlig.dat"
/* we know we store sha256 keys, so their size is fixed */
#define KEYSIZE 64
#define KEYBUFFERSIZE 6400

/* returns a file pointer opened with the "ab+" flags */
FILE * open_append(const char * path);

FILE * open_read(const char * path);

/* sets the file position to the buffer offset */
int next_buffer_pos(FILE * fp);

/* sets the file position to the key offset */
int next_key_pos(FILE * fp);

/* when we are done with a file, reset it's position */
void reset_pos(FILE *fp);
#endif
