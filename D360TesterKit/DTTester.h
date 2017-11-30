//
//  This file is part of 360dialog SDK.
//  See the file LICENSE.txt for copying permission.
//

#import <Foundation/Foundation.h>
#import "DTCampaign.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * The DTTester is a utility class that allows to test local 360dialog campaigns during development time.
 * It emulates the campaigns as if were sent by the backend to facilitate the 360dialog SDK integration
 *
 * @warning This kit is not meant to be used in production but rather only during development!! Using this class
 * in a app build other that development will cause the app crash. This is done on purpose to assert that none of this
 * code is used in production.
 */
@interface DTTester : NSObject

+(void) sendCampaign:(id<DTCampaign>) campaign;

@end
NS_ASSUME_NONNULL_END
