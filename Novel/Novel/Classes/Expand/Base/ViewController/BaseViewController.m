//
//  BaseViewController.m
//  Novel
//
//  Created by xth on 2017/7/15.
//  Copyright © 2017年 th. All rights reserved.
//

#pragma mark - UIViewController

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

/*
 在info.plist文件中 View controller-based status bar appearance
 -> YES，则控制器对状态栏设置的优先级高于application
 -> NO，则以application为准，控制器设置状态栏-(UIStatusBarStyle)preferredStatusBarStyle是无效的的根本不会被调用
 */

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%@ 释放了",NSStringFromClass([self class]));
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //更新视图信息。
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //执行行为，比如运行动画效果。
}


- (BOOL)shouldAutorotate{
    return YES;
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
- (NSUInteger)supportedInterfaceOrientations
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#endif
{
    return UIInterfaceOrientationMaskAll;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  [self.navigationController fullScreenInteractiveTransitionEnable:YES];
    
    //开启ios右滑返回
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = knavigationBarColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17]
                                                                      }];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = KbackgroundColor;
    
    [self addBackItem];
    
    [self setupViews];
    
    [self setupLayout];
    
    [self onLoadDataByRequest];
}

/** < 创建UI > */
-(void)setupViews {
    
}

/** < UI布局 > */
-(void)setupLayout{
    
}

- (void)onLoadDataByRequest {
    
}

- (void)requestSuccessWithResponeObj:(id)responseObject modelClass:(id)clas alertStr:(NSString *)alertStr isAlert:(BOOL)isAlert complete:(void (^)(id obj))complete {
    
    [HUD hide];
    [SVProgressHUD dismiss];
    
    if ([responseObject[@"code"] integerValue] == 100) {
        
        id responseObj = nil;
        
        if ([responseObject[@"data"] isKindOfClass:[NSDictionary class]]) {
            responseObj =[clas modelWithDictionary:responseObject[@"data"]];
        } else if ([responseObject[@"data"] isKindOfClass:[NSArray class]]) {
            responseObj = [NSArray modelArrayWithClass:clas json:responseObject[@"data"]];
        }
        
        if (responseObj) {
            
            complete(responseObj);
            
        } else {
            if (isAlert) {
                NSString *msg = [responseObject[@"message"] length] > 0 ? responseObject[@"message"] : alertStr;
                [HUD showMessage:msg inView:self.view];
            }
        }
        
    } else {
        if (isAlert) {
            NSString *msg = [responseObject[@"message"] length] > 0 ? responseObject[@"message"] : alertStr;
            [HUD showMessage:msg inView:self.view];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
