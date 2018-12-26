//
//  PresentDelegate.h
//  MVPDemo
//
//  Created by 陈诚 on 2018/12/26.
//  Copyright © 2018 陈诚. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PresentDelegate <NSObject>

@optional

/** 刷新UI -------> TableViewVC */
- (void)reloadDataForUI;

/**
 
 这里协议方法定义最好不要写在view里面，专门提一个文件出来可以起到解耦的作用,维护快,理解"需求驱动代码",要学会思考如何去定义这个参数/返回值,多学多写多练！

 */
- (void)didClickAddBtnWithNum:(NSString *)num indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
