
#ifndef FILESYSTEM_FUNCS_H
#define FILESYSTEM_FUNCS_H
#include <stdint.h>
#include "list.h"
#include "types.h"

#define TEMP_FILESIZE 1000


uint32_t get_file_size(char *source_file_name);

//allocates space for a file pointer
File *create_file(char *source_file_name, int clear_file_contents);
void free_file(void *file);
int does_file_exist(char *source_file_name);
int get_offset(File *file, void *buff, uint32_t buf_size, int offset);
int write_offset(File *file, void *buff, uint32_t size, uint32_t offset);
uint32_t calc_check_sum(char *data, uint32_t length);
uint32_t check_sum_file(File *file, uint16_t stack_buffer);
int receive_offset(File *file, uint8_t ack, uint32_t offset_start, uint32_t offset_end);
File *create_temp_file(char *file_name);
int change_tempfile_to_actual(char *temp, char *destination_file_name, uint32_t file_size, File *file);
#endif 
