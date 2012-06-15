//
//  HRTViewController.h
//  AzumioConnnectExample
//
//  Created by Peter Kuhar on 5/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRTViewController : UIViewController
@property (retain, nonatomic) IBOutlet UILabel *heartrateLabel;
@property (retain, nonatomic) IBOutlet UIButton *hearrateButton;
- (IBAction)onMeasureHeartRate:(id)sender;

@end
