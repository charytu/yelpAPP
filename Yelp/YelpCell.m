//
//  YelpCell.m
//  Yelp
//
//  Created by Chary Tu on 6/21/15.
//  Copyright (c) 2015 chary tu. All rights reserved.
//

#import "YelpCell.h"

@implementation YelpCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)prepareForReuse{
    [super prepareForReuse];
    self.posterView.image = nil;
    self.ratingView.image = nil;
}


@end
