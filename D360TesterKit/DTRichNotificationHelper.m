//
//  This file is part of Dialog 360 SDK.
//  See the file LICENSE.txt for copying permission.
//

#import "DTRichNotificationHelper.h"

@import MobileCoreServices;

NSString *const DTExtensionRichAttachmentKeyPath = @"d360.notification.attachment_url";
NSString *const DTExtensionRichBodyKeyPath = @"d360.notification.rich_text";


@implementation DTRichNotificationHelper


+ (BOOL)handleNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent *_Nonnull))contentHandler
{

    UNMutableNotificationContent *content = (UNMutableNotificationContent *) [request.content mutableCopy];

    if (content.userInfo[@"d360"] == nil) {
        return NO;
    }

    NSString *urlString = [content.userInfo valueForKeyPath:DTExtensionRichAttachmentKeyPath];


    if (![urlString isKindOfClass:[NSString class]]) {
        NSLog(@"Expected a NSString for key attachment_url got %@", NSStringFromClass([urlString class]));
        contentHandler(content);
        return YES;
    }

    NSURL *url = [NSURL URLWithString:urlString];
    if (!url) {
        contentHandler(content);
        return YES;
    }

    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {

        NSLog(@"Downloading notification attachment completed with %@", error == nil ? @"success" : [NSString stringWithFormat:@"error: %@", error]);
        if (error) {
            contentHandler(content);
            return;
        }

        NSString *fileExtension = url.lastPathComponent.pathExtension;

        // if the filetype cannot be determined from its extension,
        // parse the Content-Type and add it to the file name
        if (![[self class] MIMETypeFromFileName:fileExtension] && [response isKindOfClass:[NSHTTPURLResponse class]]) {

            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            NSString *contentType = httpResponse.allHeaderFields[@"Content-Type"];
            NSLog(@"Content-Type: %@", contentType);
            fileExtension = [[contentType componentsSeparatedByString:@"/"] lastObject];
            if (fileExtension) {
                NSLog(@"Using Content-Type as extension: %@", fileExtension);
            }
        }

        NSError *fileError;


        NSURL *urlWithExtension = [NSURL fileURLWithPath:[location.path stringByAppendingFormat:@".%@", fileExtension]];


        if (![[NSFileManager defaultManager] moveItemAtURL:location toURL:urlWithExtension error:&fileError]) {
            contentHandler(content);
            return;
        }

        UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:url.absoluteString URL:urlWithExtension options:nil error:&fileError];

        if (!attachment) {
            NSLog(@"Could not create local attachment file: %@", fileError);
            contentHandler(content);
            return;
        }

        NSLog(@"Adding attachment: %@", attachment);

        NSMutableArray *attachments = content.attachments ? [content.attachments mutableCopy] : [NSMutableArray array];

        [attachments addObject:attachment];

        content.attachments = attachments;

        NSString *richBody = [content.userInfo valueForKeyPath:DTExtensionRichBodyKeyPath];

        if (richBody.length > 0) {
            NSLog(@"Setting rich body: %@", richBody);
            content.body = richBody;
        }

        contentHandler(content);

    }];

    [task resume];


    return YES;
}


+ (NSString *)MIMETypeFromFileName:(NSString *)extension
{
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef) extension, NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass(UTI, kUTTagClassMIMEType);
    CFRelease(UTI);

    if (!MIMEType) {
        return nil;
    }
    return (__bridge_transfer NSString *) (MIMEType);
}
@end


