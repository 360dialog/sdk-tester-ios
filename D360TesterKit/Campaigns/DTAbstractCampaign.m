//
//  This file is part of 360dialog SDK.
//  See the file LICENSE.txt for copying permission.
//

#import "DTAbstractCampaign.h"

@interface DTAbstractCampaign ()

@end


@implementation DTAbstractCampaign

@synthesize action = _action;

- (instancetype)initWithUserInfo:(NSMutableDictionary *)userInfo
{
    self = [super init];
    if (self) {
        self.self.userInfo = userInfo;
    }

    return self;
}

- (void)setAction:(id <DTAction>)action
{
    [self.userInfo setValue:[[action JSON] mutableCopy] forKeyPath:@"d360.a"];
}

- (NSDictionary *)JSON
{
    return [self.userInfo copy];
}

@end
