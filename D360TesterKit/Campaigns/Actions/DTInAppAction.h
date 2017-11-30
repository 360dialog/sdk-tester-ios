//
//  This file is part of 360dialog SDK.
//  See the file LICENSE.txt for copying permission.
//

#import <Foundation/Foundation.h>
#import "DTAction.h"


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DTButtonType) {
    /// A clear/light style
    DTButtonTypeLight,

    // A dark native button
    DTButtonTypeDark,

    // No native button at all. In this case, your inapp is expected to have a html close button with a d360://close link
    DTButtonTypeNone,
};

@interface DTInAppAction : NSObject <DTAction>

@property (nonatomic, strong) NSURL *url;

/// Whether the InApp should be preloaded before being displayed. Default is `YES`
@property (nonatomic, assign) BOOL preload;

/// The style of the native close button. Default is  DTButtonTypeDark
@property (nonatomic, assign) DTButtonType buttonType;

- (instancetype)initWithUrl:(NSURL *)url buttonType:(DTButtonType)buttonType;


@end

NS_ASSUME_NONNULL_END
