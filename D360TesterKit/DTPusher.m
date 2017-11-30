//
//  This file is part of 360dialog SDK.
//  See the file LICENSE.txt for copying permission.
//

#import "DTPusher.h"
#import "DTRichNotificationHelper.h"

@import UIKit;
@import UserNotifications;

@interface DTPusher ()

@end

@implementation DTPusher

- (void)localPush:(NSDictionary *)payload
{
    NSDictionary *sample = payload;

    BOOL isSilent = [[payload valueForKeyPath:@"aps.content-available"] boolValue];
    BOOL isForeground = [[payload valueForKeyPath:@"d360.notification.foreground_notification_types"] integerValue] != 0;
    if (isSilent) {
        [self scheduleSilentPush:sample];
        return;
    }

    NSTimeInterval delay = isForeground ? 0 : 3;

    if (@available(iOS 10, *)) {
        [self scheduleLocalPushSampleUN:sample delay:delay];
    } else {
        [self scheduleLocalPushSampleUI:sample delay:delay];
    }

    if(!isForeground ) {
        [[UIApplication sharedApplication] performSelector:@selector(suspend) withObject:nil afterDelay:1];
    }
}

- (void)scheduleLocalPushSampleUN:(NSDictionary *)sample delay:(NSTimeInterval)pushDelay NS_AVAILABLE_IOS(10_0)
{
    NSDictionary *payload = sample;
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = [payload valueForKeyPath:@"aps.alert.title"];
    content.body = [payload valueForKeyPath:@"aps.alert.body"];

    if (payload[@"d360"]) {
        content.userInfo = @{ @"d360": payload[@"d360"] };
    }

    UNTimeIntervalNotificationTrigger *trigger;
    if (pushDelay > 0) {
        trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:pushDelay repeats:NO];
    }


    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:[[NSUUID UUID] UUIDString] content:content trigger:trigger];
    

    // create a rich content if needed
    BOOL rich = [DTRichNotificationHelper handleNotificationRequest:request withContentHandler:^(UNNotificationContent *richContent) {
        UNNotificationRequest *richRequest = [UNNotificationRequest requestWithIdentifier:[[NSUUID UUID] UUIDString] content:richContent trigger:trigger];
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:richRequest withCompletionHandler:^(NSError *error) {
            NSLog(@"Local notification scheduled with %@", error ? error : @"success");
        }];
    }];

    // not a rich push, add the original request
    if (!rich) {
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError *error) {
            NSLog(@"Local notification scheduled with %@", error ? error : @"success");
        }];
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)scheduleLocalPushSampleUI:(NSDictionary *)sample delay:(NSTimeInterval)pushDelay
{

    NSDictionary *payload = sample;

    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:pushDelay];
    localNotification.alertBody = [payload valueForKeyPath:@"aps.alert.body"];
    localNotification.alertTitle = [payload valueForKeyPath:@"aps.alert.title"];
    localNotification.applicationIconBadgeNumber = [[payload valueForKeyPath:@"aps.badge"] integerValue];
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    if (payload[@"d360"]) {
        localNotification.userInfo = @{ @"d360": payload[@"d360"] };
    }

    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];

}
#pragma clang diagnostic pop

- (void)scheduleSilentPush:(NSDictionary *)sample
{

    NSDictionary *payload = sample;

    [[UIApplication sharedApplication].delegate application:[UIApplication sharedApplication] didReceiveRemoteNotification:payload fetchCompletionHandler:^(UIBackgroundFetchResult result) {

    }];

}
@end
