//
//  This file is part of 360dialog SDK.
//  See the file LICENSE.txt for copying permission.
//

#import <Foundation/Foundation.h>

#import "DTAction.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DTCampaign <NSObject>

@property (nullable, nonatomic, strong) id <DTAction> action;

- (NSDictionary *)JSON;


@end

NS_ASSUME_NONNULL_END

