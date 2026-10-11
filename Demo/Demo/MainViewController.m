#import "MainViewController.h"
#import "CreditsViewController.h"
#import "Respring.h"

@interface MainViewController ()

@property (strong, nonatomic) UIButton *jailbreakButton;
@property (strong, nonatomic) UITextView *logView;
@property (strong, nonatomic) UILabel *statusLabel;
@property (assign, nonatomic) BOOL running;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.04 green:0.04 blue:0.06 alpha:1.0];

    // Logo
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DopamineLogo"]];
    logoView.contentMode = UIViewContentModeScaleAspectFit;
    logoView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:logoView];

    // Title
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"Dopamine";
    titleLabel.font = [UIFont systemFontOfSize:34 weight:UIFontWeightBold];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:titleLabel];

    // Status
    self.statusLabel = [[UILabel alloc] init];
    self.statusLabel.text = @"Supported iOS 26.6.1 RC! (userland)";
    self.statusLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    self.statusLabel.textColor = [UIColor colorWithRed:0.19 green:0.82 blue:0.35 alpha:1.0];
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    self.statusLabel.numberOfLines = 0;
    self.statusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.statusLabel];

    // Big Jailbreak button
    self.jailbreakButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.jailbreakButton setTitle:@"Jailbreak" forState:UIControlStateNormal];
    self.jailbreakButton.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
    [self.jailbreakButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.jailbreakButton.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.12];
    self.jailbreakButton.layer.cornerRadius = 18;
    self.jailbreakButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.jailbreakButton addTarget:self action:@selector(jailbreakPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.jailbreakButton];

    // Log view
    self.logView = [[UITextView alloc] init];
    self.logView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.45];
    self.logView.layer.cornerRadius = 12;
    self.logView.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
    self.logView.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.12].CGColor;
    self.logView.font = [UIFont monospacedSystemFontOfSize:12 weight:UIFontWeightRegular];
    self.logView.textColor = [UIColor colorWithWhite:0.85 alpha:1.0];
    self.logView.editable = NO;
    self.logView.selectable = NO;
    self.logView.text = @"";
    self.logView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.logView];

    // Credits button
    UIButton *creditsButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [creditsButton setTitle:@"Credits" forState:UIControlStateNormal];
    creditsButton.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    [creditsButton setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateNormal];
    creditsButton.translatesAutoresizingMaskIntoConstraints = NO;
    [creditsButton addTarget:self action:@selector(creditsPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:creditsButton];

    UILayoutGuide *guide = self.view.safeAreaLayoutGuide;
    [NSLayoutConstraint activateConstraints:@[
        [logoView.topAnchor constraintEqualToAnchor:guide.topAnchor constant:36],
        [logoView.centerXAnchor constraintEqualToAnchor:guide.centerXAnchor],
        [logoView.widthAnchor constraintEqualToConstant:110],
        [logoView.heightAnchor constraintEqualToConstant:110],

        [titleLabel.topAnchor constraintEqualToAnchor:logoView.bottomAnchor constant:12],
        [titleLabel.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor constant:20],
        [titleLabel.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor constant:-20],

        [self.statusLabel.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor constant:8],
        [self.statusLabel.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor constant:20],
        [self.statusLabel.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor constant:-20],

        [self.jailbreakButton.topAnchor constraintEqualToAnchor:self.statusLabel.bottomAnchor constant:28],
        [self.jailbreakButton.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor constant:40],
        [self.jailbreakButton.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor constant:-40],
        [self.jailbreakButton.heightAnchor constraintEqualToConstant:64],

        [self.logView.topAnchor constraintEqualToAnchor:self.jailbreakButton.bottomAnchor constant:20],
        [self.logView.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor constant:20],
        [self.logView.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor constant:-20],

        [creditsButton.topAnchor constraintEqualToAnchor:self.logView.bottomAnchor constant:12],
        [creditsButton.centerXAnchor constraintEqualToAnchor:guide.centerXAnchor],
        [creditsButton.bottomAnchor constraintLessThanOrEqualToAnchor:guide.bottomAnchor constant:-8],
    ]];
}

- (void)creditsPressed {
    CreditsViewController *vc = [[CreditsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)appendLog:(NSString *)line {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *existing = self.logView.text;
        NSString *updated = existing.length > 0
            ? [existing stringByAppendingFormat:@"\n%@", line]
            : line;
        self.logView.text = updated;
        NSRange bottom = NSMakeRange(updated.length > 0 ? updated.length - 1 : 0, 0);
        [self.logView scrollRangeToVisible:bottom];
    });
}

- (void)jailbreakPressed {
    if (self.running) return;
    self.running = YES;
    self.jailbreakButton.enabled = NO;
    self.jailbreakButton.alpha = 0.5;
    [self appendLog:@"Starting Jailbreak…"];

    NSArray<NSString *> *steps = @[
        @"Gathering system information…",
        @"Patchfinding…",
        @"Exploiting kernel…",
        @"Bypassing PAC…",
        @"Bypassing PPL…",
        @"Initializing jailbreak…",
        @"Bootstrapping…",
        @"Installing package managers…",
        @"Finalizing…",
        @"Done!",
    ];

    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        for (NSString *step in steps) {
            [NSThread sleepForTimeInterval:0.45 + (arc4random_uniform(400) / 1000.0)];
            [self appendLog:step];
        }
        // The visible text stays exactly "restart spring board",
        // the code behind it performs a real respring.
        [self appendLog:@"restart spring board"];
        [NSThread sleepForTimeInterval:0.6];
        dispatch_async(dispatch_get_main_queue(), ^{
            [Respring performRespring];
        });
    });
}

@end
