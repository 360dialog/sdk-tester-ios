//
//  This file is part of 360dialog SDK.
//  See the file LICENSE.txt for copying permission.
//

#import <Foundation/Foundation.h>
#import "DTCampaign.h"

@interface DTAbstractCampaign : NSObject <DTCampaign>

@property (nonatomic, strong) NSMutableDictionary *userInfo;

- (instancetype)initWithUserInfo:(NSMutableDictionary *)userInfo;


@end