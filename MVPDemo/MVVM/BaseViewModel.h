//
//  MVVMBaseViewModel.h
//  MVPDemo
//
//  Created by 陈诚 on 2019/2/17.
//  Copyright © 2019 陈诚. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id  data);
typedef void(^FailBlock)(id  data);

@interface BaseViewModel : NSObject {
    @public
    NSString *name;
}

@property (nonatomic, copy) SuccessBlock successBlock;
@property (nonatomic, copy) FailBlock failBlock;

- (void)initWithBlock:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock;

@end

