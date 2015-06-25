//
//  FilterViewController.h
//  Yelp
//
//  Created by Chary Tu on 6/21/15.
//  Copyright (c) 2015 chary tu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FilterViewController;
@protocol FilterViewControllerDelegate <NSObject>

-(void)filterViewController:(FilterViewController *)viewController didUpdateFilters:(NSDictionary *)filters;

@end

@interface FilterViewController : UIViewController

@property(weak, nonatomic) id<FilterViewControllerDelegate> delegate;
@end
