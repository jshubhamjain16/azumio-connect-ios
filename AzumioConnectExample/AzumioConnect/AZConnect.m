//
//  AZConnect.m
//  Azumio Connnect - V1.0
//
//  Created by Peter Kuhar on 5/21/12.
//  Copyright (c) 2012 Azumio Inc. All rights reserved.
//

#import "AZConnect.h"

@implementation AZConnect

@synthesize partnerKey;

static AZConnect *_instance = 0;
+(AZConnect*)instance{
    if(_instance)
        return _instance;
    
    _instance = [[AZConnect alloc] init];
    
    return _instance;
}



-(void)measureHeartRate{

    NSURL *urlPro = [NSURL URLWithString:[NSString stringWithFormat:@"instantheartrate.pro:?callback=%@:?heartrate=!HR!",schema]];
                     
    NSURL *urlFree = [NSURL URLWithString:[NSString stringWithFormat:@"si.modula.instantheartrate.free:?callback=%@:?heartrate=!HR!",schema]];
    
    if( [[UIApplication sharedApplication] canOpenURL:urlPro] ){
        [[UIApplication sharedApplication] openURL:urlPro];
    } else if( [[UIApplication sharedApplication] canOpenURL:urlFree] ){
        [[UIApplication sharedApplication] openURL:urlFree];
    }else{
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Measuring heart rate" message:@"The latest version of Instant Heart Rate from Azumio needs to be installed to measure your heart rate." delegate:self cancelButtonTitle:@"Later" otherButtonTitles:@"Install NOW", nil];
        [av show];
        [av release];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *installURL = [NSString stringWithFormat: @"http://azumio-com.appspot.com/partner/install/si.modula.instantheartrate?key=%@",self.partnerKey];
    
    if(buttonIndex != 0 ){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:installURL]];
    }
}


-(void)setHeartRateCallback:(AZConnectHeartRateBlock)listener andSchema:(NSString*)_schema{
    [schema release];
    [(schema = _schema) retain];
    
    if( lastSuccessHandler ){
        Block_release(lastSuccessHandler);
    }
    lastSuccessHandler = Block_copy(listener);
}

-(void)openURL:(NSURL*)url{
    NSString *query = [url absoluteString];
    NSRange r = [query rangeOfString:@"heartrate="];
    
    if( r.location != NSNotFound ){
        r.location = r.location + 10;
        r.length = 0;
        while( r.location + r.length < query.length && isnumber( [query characterAtIndex:r.location + r.length]) ){
            r.length++;
        }
                
        NSString *hr = [query substringWithRange:r];
        double hrd = [hr doubleValue];
        if( lastSuccessHandler ){
            lastSuccessHandler(hrd);
        }
    }
}

@end
