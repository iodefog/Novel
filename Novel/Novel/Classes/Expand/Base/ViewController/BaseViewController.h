//
//  BaseViewController.h
//  Novel
//
//  Created by xth on 2017/7/15.
//  Copyright © 2017年 th. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  根视图控制器类，一切普通视图控制器都继承此类。
 */
@interface BaseViewController : UIViewController

/**
 创建UI
 */
- (void)setupViews;

/**
 UI布局
 */
- (void)setupLayout;


/**
 开始网络请求
 */
- (void)onLoadDataByRequest;

/**
 请求成功后的处理
 
 @param responseObject responseObject
 @param clas model class
 @param alertStr 后备提示
 @param isAlert 是否提示
 @param complete obj
 */
- (void)requestSuccessWithResponeObj:(id)responseObject modelClass:(id)clas alertStr:(NSString *)alertStr isAlert:(BOOL)isAlert complete:(void (^)(id obj))complete;

@end
