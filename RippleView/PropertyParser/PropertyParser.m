//
//  PropertyParser.m
//  RippleView
//
//  Created by eag ers on 25/04/16.
//  Copyright © 2016 eag ers. All rights reserved.
//

#import "PropertyParser.h"

@interface PropertyParser ()
@property (strong, nonatomic) NSDictionary *propertiesCollection;
@end

@implementation PropertyParser
+(instancetype)sharedInstance {
    static PropertyParser* sharedPropertyparser;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPropertyparser = [[PropertyParser alloc] init];
    });
    return sharedPropertyparser;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        NSError *error = nil;
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"properties"];
        NSString *propertyFileContent = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        if (error) return nil;
        
        NSArray *properties = [propertyFileContent componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        if (properties.count == 0) return nil;
        
        NSMutableDictionary *result = [[NSMutableDictionary alloc] initWithCapacity:properties.count];
        for (NSString *propertySting in properties) {
            NSArray *property = [propertySting componentsSeparatedByString:@"="];
            
            if (property.count != 2) continue;
            
            [result setObject:property[1] forKey:property[0]];
        }
        self.propertiesCollection = result.allKeys.count > 0 ? result : nil;
    }
    return self;
}

-(NSString *)getAircraftSSID {
    return [self.propertiesCollection objectForKey:@"Aircraft_SSID"] ? [self.propertiesCollection objectForKey:@"Aircraft_SSID"]:@"";
}
-(NSString *)getIDC_Version {
    return [self.propertiesCollection objectForKey:@"ICD_Version"] ? [self.propertiesCollection objectForKey:@"ICD_Version"]:@"";
}
-(NSString *)getOfflineReportRetryCount {
    return [self.propertiesCollection objectForKey:@"Offline_report_retry_count"] ? [self.propertiesCollection objectForKey:@"Offline_report_retry_count"]:@"";
}
-(NSString *)getOfflineReportRetryDelay {
    return [self.propertiesCollection objectForKey:@"Offline_report_retry_delay"] ? [self.propertiesCollection objectForKey:@"Offline_report_retry_delay"]:@"";
}
-(NSString *)getPeriodicRunInterval {
    return [self.propertiesCollection objectForKey:@"Periodic_run_interval"] ? [self.propertiesCollection objectForKey:@"Periodic_run_interval"]:@"";
}
-(NSArray *)getBlackListSites {
    NSPredicate *pridicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",@"BLSite"];
    NSArray *filteredKeys = [[self.propertiesCollection allKeys] filteredArrayUsingPredicate:pridicate];
    NSMutableArray *filteredObjects = [NSMutableArray arrayWithCapacity:[filteredKeys count]];
    for (NSString *key in filteredKeys) {
        NSString *urlString = [self.propertiesCollection[key] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        urlString  = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [filteredObjects addObject:urlString];
    }
    return  [NSArray arrayWithArray:filteredObjects];
}
-(NSArray *)getWhiteListSites {
    NSPredicate *pridicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",@"NWSite"];
    NSArray *filteredKeys = [[self.propertiesCollection allKeys] filteredArrayUsingPredicate:pridicate];
    NSMutableArray *filteredObjects = [NSMutableArray arrayWithCapacity:[filteredKeys count]];
    for (NSString *key in filteredKeys) {
        NSString *urlString = [self.propertiesCollection[key] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        urlString  = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [filteredObjects addObject:urlString];
    }
    return  [NSArray arrayWithArray:filteredObjects];
}
-(NSArray *)getNonWhiteListSites {
    NSPredicate *pridicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",@"Site"];
    NSArray *filteredKeys = [[self.propertiesCollection allKeys] filteredArrayUsingPredicate:pridicate];
    NSMutableArray *filteredObjects = [NSMutableArray arrayWithCapacity:[filteredKeys count]];
    for (NSString *key in filteredKeys) {
        NSString *urlString = [self.propertiesCollection[key] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        urlString  = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [filteredObjects addObject:urlString];
    }
    return  [NSArray arrayWithArray:filteredObjects];
}
-(NSArray *)getEndPointListSites {
    NSPredicate *pridicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",@"portal-platform.unitedwifi.com"];
    NSArray *filteredKeys = [[self.propertiesCollection allKeys] filteredArrayUsingPredicate:pridicate];
    NSMutableArray *filteredObjects = [NSMutableArray arrayWithCapacity:[filteredKeys count]];
    for (NSString *key in filteredKeys) {
        NSString *urlString = [key stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        urlString  = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [filteredObjects addObject:urlString];
    }
    return  [NSArray arrayWithArray:filteredObjects];
}
-(NSString *)description {
    return [NSString stringWithFormat:@"\nAircraft SSID:%@\nIDC Version:%@\nReport Retry Count:%@\nReport Retry Delay:%@\nPeriodic Run Interval:%@\nBlack List Sites:%@\nWhite List Sites:%@\nNon White List Sites:%@\nEnd Point Sites:%@",[self getAircraftSSID],[self getIDC_Version],[self getOfflineReportRetryCount],[self getOfflineReportRetryDelay],[self getPeriodicRunInterval],[self getBlackListSites],[self getWhiteListSites],[self getNonWhiteListSites],[self getEndPointListSites]];
}

@end
