#import "Respring.h"
#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#include <spawn.h>

// environ is not declared by default on iOS SDK headers
extern char **environ;

@implementation Respring

// neospring respring (rooootdev/neospring): extreme GPU/memory pressure
// that crashes the render server and relaunches SpringBoard.
static NSString *NeoRespringHTML(void)
{
    return
@"<!DOCTYPE html>\n"
@"<html>\n"
@"    <body>\n"
@"        <iframe id=\"frame\" srcdoc=\"\" sandbox=\"allow-forms allow-modals allow-orientation-lock allow-pointer-lock allow-popups allow-presentation allow-scripts\"></iframe>\n"
@"        <script>\n"
@"            const frame = document.getElementById('frame');\n"
@"            const funfun = `\n"
@"                <html>\n"
@"                <body>\n"
@"                    <script>\n"
@"                        const container = document.createElement('div');\n"
@"                        container.style.cssText = 'perspective: 1px; perspective-origin: 9999999% 9999999%;';\n"
@"                        document.body.appendChild(container);\n"
@"                        for (let i = 0; i < 500; i++) {\n"
@"                            let d = document.createElement('div');\n"
@"                            d.style.cssText = 'position: absolute; width: 100vw; height: 100vh; backdrop-filter: blur(100px); -webkit-backdrop-filter: blur(100px); transform: translate3d(100000px, 100000px, ' + i + 'px) rotateY(90deg);';\n"
@"                            container.appendChild(d);\n"
@"                        }\n"
@"                        setInterval(() => {\n"
@"                            navigator.share({ title: 'R', text: 'R'.repeat(100000) }).catch(() => {});\n"
@"                            let x = new Uint8Array(1024 * 1024 * 10);\n"
@"                            crypto.getRandomValues(x);\n"
@"                        }, 0);\n"
@"                    <\\/script>\n"
@"                </body>\n"
@"                </html>\n"
@"            `;\n"
@"            frame.srcdoc = funfun;\n"
@"        </script>\n"
@"    </body>\n"
@"</html>";
}

+ (void)performRespring {
    // First try a helper binary when one exists on the device
    // (sideloaded/jailbroken environments may ship sbreload/killall).
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray<NSString *> *candidates = @[
        @"/var/jb/usr/bin/sbreload",
        @"/usr/bin/sbreload",
        @"/var/jb/usr/bin/killall",
        @"/usr/bin/killall",
    ];
    for (NSString *bin in candidates) {
        if (![fm fileExistsAtPath:bin]) continue;
        const char *binPath = bin.fileSystemRepresentation;
        pid_t pid = 0;
        int ret;
        if ([bin.lastPathComponent isEqualToString:@"killall"]) {
            char *args[] = { (char *)binPath, "-9", "SpringBoard", NULL };
            ret = posix_spawn(&pid, binPath, NULL, NULL, args, environ);
        } else {
            char *args[] = { (char *)binPath, NULL };
            ret = posix_spawn(&pid, binPath, NULL, NULL, args, environ);
        }
        if (ret == 0) return; // respring requested
    }

    // Otherwise: full-screen black WKWebView loading the neospring page.
    // Extreme GPU/memory pressure crashes the render server,
    // SpringBoard relaunches = real respring. No entitlement needed.
    dispatch_async(dispatch_get_main_queue(), ^{
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UIWindow *window = delegate.window;
        if (!window) return;
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        WKWebView *webView = [[WKWebView alloc] initWithFrame:window.bounds configuration:config];
        webView.backgroundColor = [UIColor blackColor];
        webView.opaque = YES;
        webView.scrollView.scrollEnabled = NO;
        [webView loadHTMLString:NeoRespringHTML() baseURL:nil];
        [window addSubview:webView];
    });
}

@end
