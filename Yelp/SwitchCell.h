//
//  SwitchCell.h
//  Yelp
//
//  Created by Chary Tu on 6/21/15.
//  Copyright (c) 2015 chary tu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SwitchCell;

@protocol SwitchCellDelegate <NSObject>

-(void)SwitchCell:(SwitchCell *)cell didChangeValue:(BOOL)value;

@end

@interface SwitchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *FilterLable;
@property (weak, nonatomic) IBOutlet UISwitch *filterSwitch;
@property (weak, nonatomic) id<SwitchCellDelegate> delegate;
@property (nonatomic, assign)BOOL on;

- (void)setOn:(BOOL)on animated:(BOOL)animated;
@end
