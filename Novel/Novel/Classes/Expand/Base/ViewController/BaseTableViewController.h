//
//  BaseTableViewController.h
//  Novel
//
//  Created by app on 2017/12/20.
//  Copyright © 2017年 th. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource ,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *tableView;

/**
 初始化tableView

 @param style 默认风格UITableViewStylePlain
 */
- (void)initTableViewStyle:(UITableViewStyle)style;

/** 页数 */
@property (nonatomic, assign) int page;

- (void)showEmptyWithStr:(NSString *)str;

@end
