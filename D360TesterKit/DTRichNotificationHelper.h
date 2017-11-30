//
//  This file is part of Dialog 360 SDK.
//  See the file LICENSE.txt for copying permission.
//

#import <Foundation/Foundation.h>

@import UserNotifications;


NS_ASSUME_NONNULL_BEGIN

@interface DTRichNotificationHelper : NSObject

/**
 * Handles the 360dialog notification payload in order to process the rich notification.
 * @param request The request received in a `UNNotificationServiceExtension`
 * @param contentHandler The completion handler that will be called when the notification is ready
 * @return `YES` if the notification has been handled. `NO` if the notification does not comes from a 360dialog platform.
 * @warning If this method return `NO`, it is up to the caller to handle the request and call the contentHandler
 */
+(BOOL) handleNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler NS_AVAILABLE_IOS(10.0);


@end

NS_ASSUME_NONNULL_END
