//
//  ViewController.m
//  YogaKitDemo
//
//  Created by lizhao on 2017/7/17.
//  Copyright © 2017年 lizhao. All rights reserved.
//

#import "ViewController.h"
#import <YogaKit/UIView+Yoga.h>
#import "Show.h"
#import "ShowTableViewCell.h"

static NSString *showCellIdentifier = @"ShowCell";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign)YGValue paddingHorizontal;
@property (nonatomic, assign)YGValue padding;
@property (nonatomic, strong)UIColor *backgroundColor;
@property (nonatomic, strong)NSArray *shows;
@property (nonatomic, strong)UIScrollView *contentView;
@property (nonatomic, assign)NSInteger showSelectedIndex;
@property (nonatomic, assign)NSInteger showPopularity;
@property (nonatomic, strong)NSString *showYear;
@property (nonatomic, strong)NSString *showRating;
@property (nonatomic, strong)NSString *showLength;
@property (nonatomic, strong)NSString *showCast;
@property (nonatomic, strong)NSString *showCreators;
@property (nonatomic, strong)NSString *selectedShowSeriesLabel;
@end

@implementation ViewController {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shows = [Show loadShows];
    
    self.showSelectedIndex = 2;
    self.selectedShowSeriesLabel = @"S3:E3";

    self.padding = YGPointValue(8.0);
    self.paddingHorizontal = YGPointValue(8.0);
    self.backgroundColor = [UIColor blackColor];
    
    self.showPopularity = 5;
    self.showYear = @"2010";
    self.showRating = @"TV-14";
    self.showLength = @"3 Series";
    self.showCast = @"Benedict Cumberbatch, Martin Freeman, Una Stubbs";
    self.showCreators = @"Mark Gatiss, Steven Moffat";
    
    [self addContentView];
    [self.contentView.yoga applyLayoutPreservingOrigin:NO];
}

- (void)addContentView {
    self.contentView.backgroundColor = self.backgroundColor;
    [self.contentView configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.height = YGPointValue(self.view.bounds.size.height);
        layout.width = YGPointValue(self.view.bounds.size.width);
        layout.justifyContent = YGJustifyFlexStart;
    }];
    [self.view addSubview:self.contentView];
    
    [self addEpisodeImageView];
    [self addSummaryView];
}

- (void)addSummaryView {
    Show *show = self.shows[self.showSelectedIndex];

    UIView *summaryView = [[UIView alloc] initWithFrame:CGRectZero];
    [summaryView configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionRow;
        layout.padding = self.padding;
    }];
    
    UILabel *summaryPopularityLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    summaryPopularityLabel.text = @"★★★★★";
    summaryPopularityLabel.textColor = [UIColor redColor];
    [summaryPopularityLabel configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1.0;
    }];
    [summaryView addSubview:summaryPopularityLabel];
    [self.contentView addSubview:summaryView];
    
    UIView *summaryInfoView = [[UIView alloc] initWithFrame:CGRectZero];
    [summaryInfoView configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 2.0;
        layout.flexDirection = YGFlexDirectionRow;
        layout.justifyContent = YGJustifySpaceBetween;
    }];
    
    for (NSString *text in @[_showYear, _showRating, _showLength]) {
        UILabel *summaryInfoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        summaryInfoLabel.text = text;
        summaryInfoLabel.font = [UIFont systemFontOfSize:14.0];
        summaryInfoLabel.textColor = [UIColor lightGrayColor];
        [summaryInfoLabel configureLayoutWithBlock:^(YGLayout * layout) {
            layout.isEnabled = YES;
        }];
        [summaryInfoView addSubview:summaryInfoLabel];
    }
    [summaryView addSubview:summaryInfoView];
    
    UIView *summaryInfoSpaceView = [[UIView alloc] initWithFrame:CGRectZero];
    [summaryInfoSpaceView configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(100.0);
        layout.flexGrow = 1.0;
    }];
    [summaryView addSubview:summaryInfoSpaceView];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectZero];
    [titleView configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionRow;
        layout.padding = self.padding;
    }];
    
    UILabel *titleEpisodeLabel = [self showLabelFor:self.selectedShowSeriesLabel font:[UIFont boldSystemFontOfSize:16.0]];
    titleEpisodeLabel.textColor = [UIColor lightGrayColor];
    [titleView addSubview:titleEpisodeLabel];
    
    UILabel *titleFullLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleFullLabel.text = show.title;
    titleFullLabel.font = [UIFont boldSystemFontOfSize:16.0];
    titleFullLabel.textColor = [UIColor lightGrayColor];
    [titleFullLabel configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.marginLeft = YGPointValue(20.0);
        layout.marginBottom = YGPointValue(5.0);
    }];
    [titleView addSubview:titleFullLabel];
    [self.contentView addSubview:titleView];
    
    UIView *descriptionView = [[UIView alloc] initWithFrame:CGRectZero];
    [descriptionView configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.paddingHorizontal = self.paddingHorizontal;
    }];
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    descriptionLabel.font = [UIFont systemFontOfSize:14.0];
    descriptionLabel.numberOfLines = 3;
    descriptionLabel.textColor = [UIColor lightGrayColor];
    descriptionLabel.text = show.detail;
    [descriptionLabel configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.marginBottom = YGPointValue(5.0);
    }];
    [descriptionView addSubview:descriptionLabel];
    
    NSString *castText = [NSString stringWithFormat:@"Cast: %@",self.showCast];
    UILabel *castLabel = [self showLabelFor:castText font:[UIFont boldSystemFontOfSize:14.0]];
    [descriptionView addSubview:castLabel];
    
    NSString *creatorText = [NSString stringWithFormat:@"Creator: %@",self.showCreators];
    UILabel *creatorLabel = [self showLabelFor:creatorText font:[UIFont boldSystemFontOfSize:14.0]];
    [descriptionView addSubview:creatorLabel];

    [self.contentView addSubview:descriptionView];
    
    UIView *actionsView = [[UIView alloc] initWithFrame:CGRectZero];
    [actionsView configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionRow;
        layout.padding = self.padding;
    }];
    
    UIView *addActionView = [self showActionViewFor:@"add" text:@"My List"];
    [actionsView addSubview:addActionView];
    
    UIView *shareActionView = [self showActionViewFor:@"share" text:@"Share"];
    [actionsView addSubview:shareActionView];
    
    [self.contentView addSubview:actionsView];
    
    UIView *tabsView = [[UIView alloc] initWithFrame:CGRectZero];
    [tabsView configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionRow;
        layout.padding = self.padding;
    }];
    
    UIView *episodesTabView = [self showTabBarFor:@"EPISODES" selected:YES];
    [tabsView addSubview:episodesTabView];
    
    UIView *moreTabView = [self showTabBarFor:@"MORE LIKE THIS" selected:NO];
    [tabsView addSubview:moreTabView];
    
    [self.contentView addSubview:tabsView];
    
    UITableView *showsTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    showsTableView.delegate = self;
    showsTableView.dataSource = self;
    showsTableView.backgroundColor = self.backgroundColor;
    [showsTableView registerClass:[ShowTableViewCell class] forCellReuseIdentifier:showCellIdentifier];
    [showsTableView configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1.0;
    }];
    [self.contentView addSubview:showsTableView];
}

- (void)addEpisodeImageView {
    Show *show = self.shows[self.showSelectedIndex];
    UIImageView *espisodeImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    espisodeImageView.backgroundColor = [UIColor grayColor];
    
    UIImage *image = [UIImage imageNamed:show.image];
    espisodeImageView.image = image;
    
    CGFloat imageWidth = image ? image.size.width : 1.0;
    CGFloat imageHeight = image ? image.size.height : 1.0;
    
    [espisodeImageView configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1.0;
        layout.aspectRatio = imageWidth / imageHeight;
    }];
    [self.contentView addSubview:espisodeImageView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect contentViewRect = CGRectZero;
    for (UIView *view in self.contentView.subviews) {
        contentViewRect = CGRectUnion(contentViewRect, view.frame);
    }
    self.contentView.contentSize = contentViewRect.size;
}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self.view configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.width = YGPointValue(size.width);
        layout.height = YGPointValue(size.height);
    }];
    [self.view.yoga applyLayoutPreservingOrigin:NO];

}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.shows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:showCellIdentifier forIndexPath:indexPath];
    cell.show = self.shows[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected row %zd", indexPath.row);
}

#pragma mark - getters & setters
- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    }
    return _contentView;
}

- (UILabel *)showLabelFor:(NSString *)text
                     font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.font = font;
    label.text = text;
    label.textColor = [UIColor lightGrayColor];
    [label configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.marginBottom = YGPointValue(5.0);
    }];
    return label;
}

- (UIView *)showActionViewFor:(NSString *)imageName text:(NSString *)text {
    UIView *actionView = [[UIView alloc] initWithFrame:CGRectZero];
    [actionView configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.alignItems = YGAlignCenter;
        layout.marginRight = YGPointValue(20.0);
    }];
    
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [actionButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [actionButton configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.padding = YGPointValue(10.0);
    }];
    
    [actionView addSubview:actionButton];
    
    UILabel *actionLabel = [self showLabelFor:text font:[UIFont systemFontOfSize:14.0]];
    actionLabel.textColor = [UIColor lightGrayColor];
    [actionView addSubview:actionLabel];
    return actionView;
}

- (UIView *)showTabBarFor:(NSString *)text selected:(BOOL)selected {
    // 1
    UIView *tabView = [[UIView alloc] initWithFrame:CGRectZero];
    [tabView configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.alignItems = YGAlignCenter;
        layout.marginRight = YGPointValue(20.0);
    }];
    
    // 2
    UIFont *tabLabelFont = selected ?
    [UIFont boldSystemFontOfSize:14.0]
    : [UIFont systemFontOfSize:14];
    CGSize fontSize = [text sizeWithAttributes:@{NSFontAttributeName: tabLabelFont}];
    
    // 3
    UIView *tabSelectedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fontSize.width, 3)];
    if (selected) {
        tabSelectedView.backgroundColor = [UIColor redColor];
    }
    [tabSelectedView configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.marginBottom = YGPointValue(5.0);
    }];
    [tabView addSubview:tabSelectedView];
    
    // 4
    UILabel *tabLabel = [self showLabelFor:text font:tabLabelFont];
    [tabView addSubview:tabLabel];
    
    return tabView;
}


- (void)test {
    [self.view configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(self.view.bounds.size.width);
        layout.height = YGPointValue(self.view.bounds.size.height);
        layout.alignItems = YGAlignCenter;
        layout.justifyContent = YGJustifyCenter;
    }];
    
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor lightGrayColor];
    [contentView configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionRow;
        layout.width = YGPointValue(320);
        layout.height = YGPointValue(80);
        layout.padding = YGPointValue(10);
    }];
    
    [self.view addSubview:contentView];
    
    UIView *child1 = [UIView new];
    child1.backgroundColor = [UIColor redColor];
    [child1 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(80);
        layout.marginRight = YGPointValue(10);
    }];
    [contentView addSubview:child1];
    
    UIView *child2 = [UIView new];
    child2.backgroundColor = [UIColor blueColor];
    [child2 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(80);
        layout.flexGrow = 1;
        layout.height = YGPointValue(20);
        layout.alignSelf = YGAlignCenter;
    }];
    [contentView addSubview:child2];
    
    [self.view.yoga applyLayoutPreservingOrigin:YES];
}

@end
