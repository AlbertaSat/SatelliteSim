
#ifndef SSP_TASKS_H
#define SSP_TASKS_H

#include "types.h"

void ssp_cleanup_client(Client *client);
void ssp_cleanup_req(void *request);
void ssp_cleanup_p_state(Protocol_state *p_state);
void *ssp_connectionless_server_task(void *params);
void *ssp_connectionless_client_task(void* params);

void *ssp_connection_client_task(void *params);
void *ssp_connection_server_task(void *params);

#endif