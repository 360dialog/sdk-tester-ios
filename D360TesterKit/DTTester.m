//
//  This file is part of 360dialog SDK.
//  See the file LICENSE.txt for copying permission.
//

#import "DTTester.h"
#import "DTPusher.h"

@interface DTTester ()

@property (nonatomic, strong) DTPusher *pusher;

@end

@implementation DTTester

+ (DTTester *)instance
{
    static DTTester *_instance = nil;
    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }

    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pusher = [[DTPusher alloc] init];
    }

    return self;
}


+ (void)sendCampaign:(id <DTCampaign>)campaign
{
    [[self instance] sendCampaign:campaign];
}

#pragma mark - Private

- (void)sendCampaign:(id <DTCampaign>)campaign
{
    [self.pusher localPush:[campaign JSON]];
}
@end
