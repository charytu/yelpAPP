//
//  YelpCell.h
//  Yelp
//
//  Created by Chary Tu on 6/21/15.
//  Copyright (c) 2015 chary tu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YelpCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *posterView;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLable;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ratingView;
@property (weak, nonatomic) IBOutlet UILabel *storeLable;

@end
