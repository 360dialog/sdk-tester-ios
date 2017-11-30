//
//  This file is part of 360dialog SDK.
//  See the file LICENSE.txt for copying permission.
//

#import "DTInbox.h"

@interface DTInbox ()


@end

@implementation DTInbox


- (instancetype)init
{

    static dispatch_once_t token;
    static NSDictionary *inAppTemplate;

    dispatch_once(&token, ^{
        NSURL *url = [[NSBundle bundleForClass:[self class]] URLForResource:@"inbox-template" withExtension:@"json"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        inAppTemplate = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
    });


    self = [super initWithUserInfo:[inAppTemplate mutableCopy]];
    if (self) {

    }

    return self;
}

- (instancetype)initWithTitle:(NSString *)title body:(NSString *)body
{
    self = [self init];
    if (self) {
        self.title = title;
        self.body = body;
    }

    return self;
}

- (void)setAction:(id <DTAction>)action
{
    [self.userInfo setValue:[[action JSON] mutableCopy] forKeyPath:@"d360.a.p.a"];
}


#pragma mark - Overrides

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self.userInfo setValue:title forKeyPath:@"d360.a.p.t"];
}

- (void)setBody:(NSString *)body
{
    _body = body;
    [self.userInfo setValue:body forKeyPath:@"d360.a.p.b"];
}

- (void)setAttachmentURL:(NSURL *)attachmentURL
{
    _attachmentURL = attachmentURL;
    [self.userInfo setValue:attachmentURL.absoluteString forKeyPath:@"d360.a.p.att.u"];
}


@end
