//
//  This file is part of 360dialog SDK.
//  See the file LICENSE.txt for copying permission.
//

#import "DTURLAction.h"

@interface DTURLAction ()

@end

@implementation DTURLAction

- (instancetype)initWithUrl:(NSURL *)url
{
    self = [super init];
    if (self) {
        self.url = url;
    }

    return self;
}


- (NSDictionary *)JSON
{
    return @{
            @"n": @"openURL",
            @"p": [@{ @"u": self.url.absoluteString } mutableCopy]
    };
}


@end
