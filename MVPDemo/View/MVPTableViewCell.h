//
//  MVPTableViewCell.h
//  MVPDemo
//
//  Created by melo on 2018/12/25.
//  Copyright © 2018 陈诚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PresentDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface MVPTableViewCell : UITableViewCell

/** 如果是MVC模式，为了给Controller减压，常常View这里就会传Model进来造成耦合，让View丧失重用能力! */

@property (nonatomic, strong) UIButton *subBtn;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, strong) NSIndexPath *indexPath;


@property (nonatomic, weak) id <PresentDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
