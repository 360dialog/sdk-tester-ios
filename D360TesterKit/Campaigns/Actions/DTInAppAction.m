//
//  This file is part of 360dialog SDK.
//  See the file LICENSE.txt for copying permission.
//

#import "DTInAppAction.h"

@interface DTInAppAction ()

@end


@implementation DTInAppAction

- (instancetype)init
{
    self = [super init];
    if (self) {
        _preload = YES;
        _url = [NSURL URLWithString:@"https://inapp-samples.s3-eu-west-1.amazonaws.com/inapp-pagination.html"];
    }

    return self;
}


- (instancetype)initWithUrl:(NSURL *)url buttonType:(DTButtonType)buttonType
{
    self = [self init];
    if (self) {
        self.url = url;
        self.buttonType = buttonType;
    }

    return self;
}

- (NSDictionary *)JSON
{
    return @{
            @"n": @"overlay",
            @"p": @{
                    @"t": @"html",
                    @"d": @{
                            @"u": self.url.absoluteString,
                            @"preload": self.preload ? @"true" : @"false",
                            @"b": @{
                                    @"s": self.buttonType == DTButtonTypeLight ? @"light" : @"dark",
                                    @"display": self.buttonType == DTButtonTypeNone ? @"never" : @"always"
                            }
                    }
            }
    };
}

@end
