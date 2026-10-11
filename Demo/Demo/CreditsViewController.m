#import "CreditsViewController.h"

@interface CreditsViewController () <UITableViewDataSource>

@property (strong, nonatomic) NSArray<NSDictionary *> *sections;

@end

@implementation CreditsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Credits";
    self.view.backgroundColor = [UIColor colorWithRed:0.04 green:0.04 blue:0.06 alpha:1.0];

    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{ NSForegroundColorAttributeName: [UIColor whiteColor] };

    self.sections = @[
        @{ @"title": @"Developers", @"names": @[
            @"opa334", @"kok3shidoll", @"Alfie", @"Clarity", @"staturnz", @"wh1te4ever",
        ]},
        @{ @"title": @"UI and Design", @"names": @[
            @"tomt000", @"sourcelocation", @"xerus",
        ]},
        @{ @"title": @"Credits", @"names": @[
            @"Fugu15", @"Fugu15_Rootful", @"Pinauten GmbH", @"tihmstar", @"oct0xor",
            @"kucher1n", @"bzvr_", @"Op. Triangulation", @"GTIG/Coruna", @"htimesnine",
            @"felix-pb", @"John Aakerblom", @"potmdehex", @"_simo36", @"0x7ff",
            @"évelyne", @"sk8ingDuck", @"Dhinak G", @"Capt Inc", @"Nick Chan",
            @"Sam Bingner", @"Procursus", @"roothideDev", @"Amy While",
            @"Adam Demasi", @"Trenchant /s",
        ]},
    ];

    UITableView *table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleInsetGrouped];
    table.backgroundColor = [UIColor clearColor];
    table.dataSource = self;
    table.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:table];

    [NSLayoutConstraint activateConstraints:@[
        [table.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [table.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [table.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [table.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
    ]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sections[section][@"names"] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sections[section][@"title"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseId = @"creditCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
        cell.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.06];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.sections[indexPath.section][@"names"][indexPath.row];
    return cell;
}

@end
