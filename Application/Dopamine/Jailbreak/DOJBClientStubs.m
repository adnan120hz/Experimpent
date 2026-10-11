//
//  DOJBClientStubs.m
//  Dopamine
//
//  DEMO: no-op implementations of the jbclient/exec stubs declared in
//  DOJBClientStubs.h. Nothing here touches the kernel or the filesystem;
//  every function reports "not jailbroken" or fails gracefully.
//

#import "DOJBClientStubs.h"
#import <stdlib.h>
#import <string.h>

struct system_info gSystemInfo;

char *jbclient_get_jbroot(void) { return strdup(""); }

bool jbclient_dopamine_is_jailbroken(char **version)
{
    if (version) *version = NULL;
    return false;
}

int jbclient_dopamine_get_root(void) { return -1; }

int jbclient_dopamine_drop_root(void) { return -1; }

int jbclient_root_set_mac_label(uint64_t slot, uint64_t label, uint64_t *orgLabel)
{
    (void)slot; (void)label; (void)orgLabel;
    return -1;
}

bool jbclient_jbsettings_get_bool(const char *key) { (void)key; return false; }

double jbclient_jbsettings_get_double(const char *key) { (void)key; return 0; }

int jbclient_platform_jbsettings_set_bool(const char *key, bool boolValue)
{
    (void)key; (void)boolValue;
    return -1;
}

int jbclient_platform_jbsettings_set_double(const char *key, double doubleValue)
{
    (void)key; (void)doubleValue;
    return -1;
}

int exec_cmd(const char *binary, ...) { (void)binary; return -1; }

int exec_cmd_root(const char *binary, ...) { (void)binary; return -1; }
