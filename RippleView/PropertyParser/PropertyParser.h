//
//  PropertyParser.h
//  RippleView
//
//  Created by eag ers on 25/04/16.
//  Copyright © 2016 eag ers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PropertyParser : NSObject
+(instancetype)sharedInstance;
-(NSString *)getAircraftSSID;
-(NSString *)getIDC_Version;
-(NSString *)getOfflineReportRetryCount;
-(NSString *)getOfflineReportRetryDelay;
-(NSString *)getPeriodicRunInterval;

//
-(NSArray *)getBlackListSites;
-(NSArray *)getWhiteListSites;
-(NSArray *)getNonWhiteListSites;
-(NSArray *)getEndPointListSites;
@end
