//
//  CPBottomPromitCell.h
//  BottomPromitView
//
//  Created by lk06 on 17/2/15.
//  Copyright © 2017年 lk06. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPBottomPromit.h"

@class CPBottomPromitManager;

@interface CPBottomPromitCell : UITableViewCell

-(void)setManager:(CPBottomPromitManager *)manager;

+(NSString *)identifier;
@end
