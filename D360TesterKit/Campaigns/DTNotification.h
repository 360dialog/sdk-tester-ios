//
//  This file is part of 360dialog SDK.
//  See the file LICENSE.txt for copying permission.
//

#import <Foundation/Foundation.h>
#import "DTCampaign.h"
#import "DTAbstractCampaign.h"

NS_ASSUME_NONNULL_BEGIN

@interface DTNotification: DTAbstractCampaign

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, assign, getter=isForeground) BOOL foreground;
@property (nonatomic, strong) NSURL *richURL;

- (instancetype)initWithTitle:(NSString *)title body:(NSString *)body;

@end

NS_ASSUME_NONNULL_END
