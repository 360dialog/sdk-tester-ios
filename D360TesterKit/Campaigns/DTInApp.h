//
//  This file is part of 360dialog SDK.
//  See the file LICENSE.txt for copying permission.
//

#import <Foundation/Foundation.h>
#import "DTCampaign.h"
#import "DTAbstractCampaign.h"

NS_ASSUME_NONNULL_BEGIN

@interface DTInApp : DTAbstractCampaign

@property (nonatomic, strong) NSURL *url;

+(instancetype) requestPermissionInApp;

@end

NS_ASSUME_NONNULL_END
