//
//  Jailbreaker.m
//  Dopamine
//
//  Created by Lars Fröder on 10.01.24.
//

#import "DOJailbreaker.h"
#import "DOEnvironmentManager.h"
#import "DOExploitManager.h"
#import "DOUIManager.h"
#import "DOPreferenceManager.h"
#import <sys/stat.h>
#import <compression.h>
#import <dlfcn.h>
#import <CoreServices/LSApplicationProxy.h>
#import <sys/utsname.h>
#import "spawn.h"
#import "clock_alarm.h"
#import <IOSurface/IOSurfaceRef.h>
int posix_spawnattr_set_registered_ports_np(posix_spawnattr_t * __restrict attr, mach_port_t portarray[], uint32_t count);

#define kCFPreferencesNoContainer CFSTR("kCFPreferencesNoContainer")
void _CFPreferencesSetValueWithContainer(CFStringRef key, CFPropertyListRef value, CFStringRef applicationID, CFStringRef userName, CFStringRef hostName, CFStringRef containerPath);
Boolean _CFPreferencesSynchronizeWithContainer(CFStringRef applicationID, CFStringRef userName, CFStringRef hostName, CFStringRef containerPath);
CFArrayRef _CFPreferencesCopyKeyListWithContainer(CFStringRef applicationID, CFStringRef userName, CFStringRef hostName, CFStringRef containerPath);
CFDictionaryRef _CFPreferencesCopyMultipleWithContainer(CFArrayRef keysToFetch, CFStringRef applicationID, CFStringRef userName, CFStringRef hostName, CFStringRef containerPath);

//char *_dirhelper(int a, char *dst, size_t size);

NSString *const JBErrorDomain = @"JBErrorDomain";
typedef NS_ENUM(NSInteger, JBErrorCode) {
    JBErrorCodeFailedToFindKernel            = -1,
    JBErrorCodeFailedKernelPatchfinding      = -2,
    JBErrorCodeFailedLoadingExploit          = -3,
    JBErrorCodeFailedExploitation            = -4,
    JBErrorCodeFailedBuildingPhysRW          = -5,
    JBErrorCodeFailedCleanup                 = -6,
    JBErrorCodeFailedGetRoot                 = -7,
    JBErrorCodeFailedUnsandbox               = -8,
    JBErrorCodeFailedPlatformize             = -9,
    JBErrorCodeFailedBasebinTrustcache       = -10,
    JBErrorCodeFailedLaunchdInjection        = -11,
    JBErrorCodeFailedInitProtection          = -12,
    JBErrorCodeFailedInitFakeLib             = -13,
    JBErrorCodeFailedDuplicateApps           = -14,
};

@implementation DOJailbreaker

- (NSError *)gatherSystemInformation
{
    // DEMO: jailbreak/exploit logic removed; stubbed so nothing can run.
    return nil;
}

- (NSError *)doExploitation
{
    // DEMO: jailbreak/exploit logic removed; stubbed so nothing can run.
    return nil;
}

- (NSError *)buildPhysRWPrimitive
{
    // DEMO: jailbreak/exploit logic removed; stubbed so nothing can run.
    return nil;
}

- (NSError *)cleanUpExploits
{
    // DEMO: jailbreak/exploit logic removed; stubbed so nothing can run.
    return nil;
}

- (NSError *)elevatePrivileges
{
    // DEMO: jailbreak/exploit logic removed; stubbed so nothing can run.
    return nil;
}

- (NSError *)showNonDefaultSystemApps
{
    // DEMO: jailbreak/exploit logic removed; stubbed so nothing can run.
    return nil;
}

- (NSError *)ensureDevModeEnabled
{
    // DEMO: jailbreak/exploit logic removed; stubbed so nothing can run.
    return nil;
}

- (NSError *)loadBasebinTrustcache
{
    // DEMO: jailbreak/exploit logic removed; stubbed so nothing can run.
    return nil;
}

struct boomerang_info {
    mach_port_t serverPort;
    dispatch_semaphore_t boomerangDone;
};

void *boomerang_server(struct boomerang_info *info)
{
    // DEMO: jailbreak/exploit logic removed; stubbed so nothing can run.
    (void)info;
    return NULL;
}

- (NSError *)injectLaunchdHook
{
    // DEMO: jailbreak/exploit logic removed; stubbed so nothing can run.
    return nil;
}

- (NSError *)applyProtection
{
    // DEMO: jailbreak/exploit logic removed; stubbed so nothing can run.
    return nil;
}

- (NSError *)createFakeLib
{
    // DEMO: jailbreak/exploit logic removed; stubbed so nothing can run.
    return nil;
}

- (NSError *)ensureNoDuplicateApps
{
    // DEMO: jailbreak/exploit logic removed; stubbed so nothing can run.
    return nil;
}

- (NSError *)removeJailbreak
{
    // DEMO: jailbreak/exploit logic removed; stubbed so nothing can run.
    return nil;
}

- (NSError *)finalizeBootstrapIfNeeded
{
    // DEMO: jailbreak/exploit logic removed; stubbed so nothing can run.
    return nil;
}

- (NSError *)cleanUpPostExploitation
{
    // DEMO: jailbreak/exploit logic removed; stubbed so nothing can run.
    return nil;
}

- (void)runWithError:(NSError **)errOut didRemoveJailbreak:(BOOL*)didRemove showLogs:(BOOL *)showLogs
{
    // DEMO: no exploit runs here, no privilege escalation, no filesystem changes.
    // This only replays the usual log lines with small delays so the flow looks
    // identical to a normal run inside the log view.
    BOOL removeJailbreakEnabled = [[DOPreferenceManager sharedManager] boolPreferenceValueForKey:@"removeJailbreakEnabled" fallback:NO];
    BOOL tweaksEnabled = [[DOPreferenceManager sharedManager] boolPreferenceValueForKey:@"tweakInjectionEnabled" fallback:YES];
    BOOL idownloadEnabled = [[DOPreferenceManager sharedManager] boolPreferenceValueForKey:@"idownloadEnabled" fallback:NO];
    BOOL appJITEnabled = [[DOPreferenceManager sharedManager] boolPreferenceValueForKey:@"appJITEnabled" fallback:YES];

    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *startLog = [NSString stringWithFormat:@"Starting Jailbreak (Model: %s, %@, Configuration: {removeJailbreak=%d, tweakInjection=%d, idownload=%d, appJIT=%d})", systemInfo.machine, NSProcessInfo.processInfo.operatingSystemVersionString, removeJailbreakEnabled, tweaksEnabled, idownloadEnabled, appJITEnabled];
    [[DOUIManager sharedInstance] sendLog:startLog debug:YES];

    NSArray<NSString *> *demoLogLines = @[
        DOLocalizedString(@"Patchfinding"),
        [NSString stringWithFormat:DOLocalizedString(@"Exploiting Kernel (%@)"), @"kfd"],
        [NSString stringWithFormat:DOLocalizedString(@"Bypassing PAC (%@)"), @"pac"],
        [NSString stringWithFormat:DOLocalizedString(@"Bypassing PPL (%@)"), @"ppl"],
        DOLocalizedString(@"Building Phys R/W Primitive"),
        DOLocalizedString(@"Cleaning Up Exploits"),
        DOLocalizedString(@"Elevating Privileges"),
        DOLocalizedString(@"Loading BaseBin TrustCache"),
        DOLocalizedString(@"Initializing Environment"),
        DOLocalizedString(@"Initializing Protection"),
        DOLocalizedString(@"Applying Bind Mount"),
        DOLocalizedString(@"Checking For Duplicate Apps"),
    ];
    for (NSString *line in demoLogLines) {
        [NSThread sleepForTimeInterval:(0.45 + (arc4random_uniform(400) / 1000.0))];
        [[DOUIManager sharedInstance] sendLog:line debug:NO];
    }

    printf("Done!\n");

    *errOut = nil;
    *didRemove = NO;
    *showLogs = YES;
}

- (void)finalize
{
    // DEMO: the visible log line stays "restart spring board", but the code
    // performs a userspace respring instead of a real restart.
    [[DOUIManager sharedInstance] sendLog:@"restart spring board" debug:NO];
    [[DOEnvironmentManager sharedManager] respring];
}

- (IOSurfaceRef)allocatePurpleGfxMemWithSize:(size_t)size
{
    // DEMO: jailbreak/exploit logic removed; stubbed so nothing can run.
    return NULL;
}

- (BOOL)surfaceIsContiguous:(IOSurfaceRef)surface
{
    // DEMO: jailbreak/exploit logic removed; stubbed so nothing can run.
    return NO;
}

- (BOOL)contiguousMappingWorks
{
    // DEMO: jailbreak/exploit logic removed; stubbed so nothing can run.
    return YES;
}

- (BOOL)contiguousMappingWorkaroundNeeded
{
    // DEMO: jailbreak/exploit logic removed; stubbed so nothing can run.
    return NO;
}

- (int)crashBackboardd
{
    // DEMO: jailbreak/exploit logic removed; stubbed so nothing can run.
    return 0;
}

- (int)crashBackboardd_15
{
    // DEMO: jailbreak/exploit logic removed; stubbed so nothing can run.
    return 0;
}

- (void)applyContiguousMappingWorkaround
{
    // DEMO: jailbreak/exploit logic removed; stubbed so nothing can run.
}

@end
