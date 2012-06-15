//
//  AZConnect.h
//  Azumio Connnect - V1.0
//
//  Created by Peter Kuhar on 5/21/12.
//  Copyright (c) 2012 Azumio Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^AZConnectHeartRateBlock)(double heartRate);

@interface AZConnect : NSObject<UIAlertViewDelegate>{
    AZConnectHeartRateBlock lastSuccessHandler;
    NSString *schema;
}

+(AZConnect*)instance;
-(void)openURL:(NSURL*)url;
-(void)measureHeartRate;
-(void)setHeartRateCallback:(AZConnectHeartRateBlock)listener andSchema:(NSString*)_schema;

@end
