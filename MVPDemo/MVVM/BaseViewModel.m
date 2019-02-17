//
//  MVVMBaseViewModel.m
//  MVPDemo
//
//  Created by 陈诚 on 2019/2/17.
//  Copyright © 2019 陈诚. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

- (void)initWithBlock:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock {
    _successBlock = successBlock;
    _failBlock = failBlock;
}

@end
