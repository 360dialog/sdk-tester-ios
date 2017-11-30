//
//  This file is part of 360dialog SDK.
//  See the file LICENSE.txt for copying permission.
//

#import "DTNotification.h"

@implementation DTNotification

- (instancetype)init
{
    static dispatch_once_t token;
    static NSDictionary *template;

    dispatch_once(&token, ^{

        NSURL *url = [[NSBundle bundleForClass:[self class]] URLForResource:@"notification-template" withExtension:@"json"];
        NSData *data = [NSData dataWithContentsOfURL:url];

        template = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
    });

    self = [super initWithUserInfo:[template mutableCopy]];
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


#pragma mark - Overrides

- (void)setTitle:(NSString *)title
{
    _title = [title mutableCopy];
    [self.userInfo setValue:title forKeyPath:@"aps.alert.title"];
}

- (void)setBody:(NSString *)body
{
    _body = [body mutableCopy];
    [self.userInfo setValue:body forKeyPath:@"aps.alert.body"];
}

- (void)setRichURL:(NSURL *)richURL
{
    _richURL = richURL;
    [self.userInfo setValue:richURL.absoluteString forKeyPath:@"d360.notification.attachment_url"];
}


- (void)setForeground:(BOOL)foreground
{
    _foreground = foreground;
    [self.userInfo setValue:foreground ? @(7) : @(0) forKeyPath:@"d360.notification.foreground_notification_types"];
}


@end
