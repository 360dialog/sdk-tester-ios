//
//  This file is part of 360dialog SDK.
//  See the file LICENSE.txt for copying permission.
//

#import <Foundation/Foundation.h>
#import "DTAction.h"


NS_ASSUME_NONNULL_BEGIN

@interface DTURLAction : NSObject <DTAction>

@property (nonatomic, strong) NSURL *url;

- (instancetype)initWithUrl:(NSURL *)url;


@end

NS_ASSUME_NONNULL_END