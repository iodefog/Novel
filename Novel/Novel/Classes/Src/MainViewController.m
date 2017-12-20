//
//  MainViewController.m
//  小说
//
//  Created by xth on 16/8/16.
//  Copyright © 2016年 xth. All rights reserved.
//

#import "MainViewController.h"
#import "BookshelfVC.h"
#import "RankingVC.h"
#import "SearchVC.h"
#import "GpsManager.h"
#import "BaseScrollView.h"

static CGFloat const maxTitleScale = 1.2;

@interface MainViewController()<UIScrollViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, weak) UIScrollView *titleScrollView;
@property (nonatomic, weak) BaseScrollView *containerScrollView;

/** 背景图片  */
@property (nonatomic, strong) YYAnimatedImageView *bgView;

// 选中按钮
@property (nonatomic, weak) UIButton *selTitleButton;

@property (nonatomic, strong) NSMutableArray *buttons;

@end

@implementation MainViewController

- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;  //默认的值是黑色的
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;  //导航栏的背景色是黑色
    
    [self setupTitleScrollView];
    [self setupContainerScrollView];
    [self addChildViewController];
    [self setupTitle];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.containerScrollView.contentSize = CGSizeMake(self.childViewControllers.count * kScreenWidth, 0);
    self.containerScrollView.pagingEnabled = YES;
    self.containerScrollView.showsHorizontalScrollIndicator = NO;
    self.containerScrollView.delegate = self;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToRankingVC:) name:@"goToRankingVC" object:nil];
}

- (YYLabel *)weatherLabel {
    YYLabel *label = [YYLabel new];
    [label setTextVerticalAlignment:YYTextVerticalAlignmentCenter];
    label.textAlignment = NSTextAlignmentCenter;
    label.displaysAsynchronously = YES;
    label.ignoreCommonProperties = YES;
    return label;
}

- (void)goToRankingVC:(NSNotification *)sender {
    
    for (UIButton *btn in self.buttons) {
        if (btn.tag == 1) {
            [self click:btn];
        }
    }
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//}

#pragma mark - 设置头部标题栏
- (void)setupTitleScrollView {
    
    // 判断是否存在导航控制器来判断y值
    CGFloat y = self.navigationController ? 0 : STATUS_BAR_HEIGHT;
    
    CGRect rect = CGRectMake(0, y, kScreenWidth, kNavigationHeight);
    
    UIScrollView *titleScrollView = [[UIScrollView alloc] initWithFrame:rect];
    
    titleScrollView.backgroundColor = kclearColor;
    
    [self.view addSubview:titleScrollView];
    
    self.titleScrollView = titleScrollView;
    
    //添加背景
    _bgView = [[YYAnimatedImageView alloc] initWithImage:[UIImage imageNamed:@"weather_background_2"]];
    _bgView.size = CGSizeMake(kScreenWidth, kNavigationHeight);
    
    [self.titleScrollView addSubview:_bgView];
}

#pragma mark - 设置ScrollView容器
- (void)setupContainerScrollView {
    
    CGFloat y = _titleScrollView.bottom;
    
    CGRect rect = CGRectMake(0, y, kScreenWidth, kScreenHeight - y);
    
    BaseScrollView *containerScrollView = [[BaseScrollView alloc] initWithFrame:rect];
    
    [self.view addSubview:containerScrollView];
    
    self.containerScrollView = containerScrollView;
}

#pragma mark - 添加子控制器
- (void)addChildViewController {
    
    BookshelfVC *vc = [[BookshelfVC alloc] init];
    vc.title = @"书架";
    [self addChildViewController:vc];
    
    RankingVC *vc1 = [[RankingVC alloc] init];
    vc1.title = @"排行";
    [self addChildViewController:vc1];
    
    SearchVC *vc2 = [[SearchVC alloc] init];
    vc2.title = @"搜索";
    [self addChildViewController:vc2];
}

#pragma mark - 设置标题
- (void)setupTitle {
    
    NSUInteger count = self.childViewControllers.count;
    
    CGFloat x = 0;
    CGFloat w = kScreenWidth / count;
    
    for (int i = 0; i < count; i++) {
        
        UIViewController *vc = self.childViewControllers[i];
        
        x = i * w;
        
        CGRect rect = CGRectMake(x, kNavigationHeight - kTitleH, w, kTitleH);
        
        UIButton *btn = [[UIButton alloc] initWithFrame:rect];
        
        btn.imageView.contentMode = UIViewContentModeScaleToFill;
        
        btn.tag = i;
        
        [btn setTitle:vc.title forState:UIControlStateNormal];
        
        [btn setTitleColor:kwhiteColor forState:UIControlStateNormal];
        
        btn.titleLabel.font = fontSize(17);
        
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
        
        [self.buttons addObject:btn];
        
        [self.titleScrollView addSubview:btn];
        
        if (i == 0) {
            [self click:btn];
        }
        
    }
    self.titleScrollView.contentSize = CGSizeMake(count * w, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
}

// 按钮点击
- (void)click:(UIButton *)btn {
    
    [self.view endEditing:YES];
    
    [self selTitleBtn:btn];
    
    NSUInteger i = btn.tag;
    CGFloat x = i * kScreenWidth;
    
    [self setUpOneChildViewController:i];
    
    self.containerScrollView.contentOffset = CGPointMake(x, 0);
    
}
// 选中按钮
- (void)selTitleBtn:(UIButton *)btn {
    
    self.selTitleButton.transform = CGAffineTransformIdentity;
    
    btn.transform = CGAffineTransformMakeScale(maxTitleScale, maxTitleScale);
    
    self.selTitleButton = btn;
    
    [self setupTitleCenter:btn];
}

- (void)setUpOneChildViewController:(NSUInteger)i {
    
    CGFloat x = i * kScreenWidth;
    
    UIViewController *vc = self.childViewControllers[i];
    
    if (vc.view.superview) {
        return;
    }
    vc.view.frame = CGRectMake(x, 0, kScreenWidth,  self.containerScrollView.height);
    
    [self.containerScrollView addSubview:vc.view];
    
}

- (void)setupTitleCenter:(UIButton *)btn {
    
    CGFloat offset = btn.centerX - kScreenWidth * 0.5;
    
    if (offset < 0) {
        offset = 0;
    }
    
    CGFloat maxOffset = self.titleScrollView.contentSize.width - kScreenWidth;
    
    if (offset > maxOffset) {
        offset = maxOffset;
    }
    
    [self.titleScrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger i = self.containerScrollView.contentOffset.x / kScreenWidth;
    [self selTitleBtn:self.buttons[i]];
    [self setUpOneChildViewController:i];
}

// 只要滚动UIScrollView就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger leftIndex = offsetX / kScreenWidth;
    NSInteger rightIndex = leftIndex + 1;
    
    if (offsetX <= 0) {
        scrollView.bounces = (scrollView.contentOffset.y <= 0) ? NO : YES;
    }
    
    UIButton *leftButton = self.buttons[leftIndex];
    
    UIButton *rightButton = nil;
    
    if (rightIndex < self.buttons.count) {
        rightButton = self.buttons[rightIndex];
    }
    
    CGFloat scaleR = offsetX / kScreenWidth - leftIndex;
    
    CGFloat scaleL = 1 - scaleR;
    
    
    CGFloat transScale = maxTitleScale - 1;
    leftButton.transform = CGAffineTransformMakeScale(scaleL * transScale + 1, scaleL * transScale + 1);
    
    rightButton.transform = CGAffineTransformMakeScale(scaleR * transScale + 1, scaleR * transScale + 1);
}

@end
