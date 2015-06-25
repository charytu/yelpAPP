//
//  SwitchCell.m
//  Yelp
//
//  Created by Chary Tu on 6/21/15.
//  Copyright (c) 2015 chary tu. All rights reserved.
//

#import "SwitchCell.h"

@implementation SwitchCell

- (void)awakeFromNib {
   // self.filterSwitch.on = NO;
    // Initialization code
}

- (IBAction)OnSwitchValueChange:(id)sender {
    [self.delegate SwitchCell:self didChangeValue:self.filterSwitch.on];
    NSLog(@"Switch Change");
}

- (void) setOn:(BOOL)on {
    [self setOn:on animated:NO];
}

-(void) setOn:(BOOL)on animated:(BOOL)animated {
    _on = on;
    [self.filterSwitch setOn:on animated:animated];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
