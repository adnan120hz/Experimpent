//
//  DOJBClientStubs.h
//  Dopamine
//
//  DEMO: local stand-ins for libjailbreak symbols.
//
//  The demo never jailbreaks, so everything here reports "not jailbroken"
//  or does nothing. This lets the app compile and link without the BaseBin
//  libraries (no Procursus/basebin build needed).
//

#import <stdbool.h>
#import <stdint.h>

// Minimal stand-in for libjailbreak's `struct system_info` + `gSystemInfo`.
// The app only ever touches `jailbreakInfo.rootPath`.
struct system_info {
    struct {
        char *rootPath;
    } jailbreakInfo;
};
extern struct system_info gSystemInfo;
#define jbinfo(name) (gSystemInfo.jailbreakInfo.name)

// jbclient stand-ins (signatures match libjailbreak's jbclient_xpc.h)
char *jbclient_get_jbroot(void);
bool jbclient_dopamine_is_jailbroken(char **version);
int jbclient_dopamine_get_root(void);
int jbclient_dopamine_drop_root(void);
int jbclient_root_set_mac_label(uint64_t slot, uint64_t label, uint64_t *orgLabel);
bool jbclient_jbsettings_get_bool(const char *key);
double jbclient_jbsettings_get_double(const char *key);
int jbclient_platform_jbsettings_set_bool(const char *key, bool boolValue);
int jbclient_platform_jbsettings_set_double(const char *key, double doubleValue);
int jbclient_platform_set_systemwide_domain_enabled(bool enabled);
int jbclient_platform_stage_jailbreak_update(const char *updateTar);

// exec_cmd stand-ins (signatures match libjailbreak's util.h)
int exec_cmd(const char *binary, ...);
int exec_cmd_root(const char *binary, ...);

// JBROOT_PATH is only meaningful on a jailbroken device; in the demo the
// paths are never actually used, so it is the identity macro.
#define JBROOT_PATH(path) (path)
// exec_cmd_trusted never runs in the demo.
#define exec_cmd_trusted(x, ...) (-1)
