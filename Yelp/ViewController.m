//
//  ViewController.m
//  Yelp
//
//  Created by Chary Tu on 6/20/15.
//  Copyright (c) 2015 chary tu. All rights reserved.
//

#import "ViewController.h"
#import "YelpCell.h"
#import "FilterViewController.h"
#import "YelpClient.h"
#import <UIImageView+AFNetworking.h>

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";



@interface ViewController ()<UITableViewDataSource, UITableViewDelegate,UISearchResultsUpdating,UISearchBarDelegate, FilterViewControllerDelegate>
@property(weak, nonatomic) IBOutlet UITableView *YelpTableView;
@property(nonatomic, strong) YelpClient *client;
@property(strong, nonatomic)NSArray * businessDictionary;
@property(strong, nonatomic)NSArray * searchList;
@property(strong, nonatomic) UISearchController *mySearchController;
@property (weak, nonatomic) IBOutlet UINavigationItem *nav;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.YelpTableView.delegate = self;
    self.YelpTableView.dataSource = self;
    
    //self.searchList = [[NSArray alloc]initWithObjects:@"hello", @"bye", nil];
   // UINavigationController *searchResultsController = [[self storyboard] instantiateViewControllerWithIdentifier:@"TableSearchResultsNavController"];
    
    self.mySearchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.mySearchController.dimsBackgroundDuringPresentation = NO;
   self.mySearchController.searchResultsUpdater = self;
   self.mySearchController.searchBar.delegate = self;
     self.mySearchController.hidesNavigationBarDuringPresentation = NO;
    [self.mySearchController.searchBar sizeToFit];
    self.nav.titleView = self.mySearchController.searchBar;
    self.definesPresentationContext = YES;
    [self updateTable:@"Thai" params:nil];


   
}


- (void) updateTable :(NSString *)searchTerm params:(NSDictionary *)params {
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    
    [self.client searchWithTerm:searchTerm params:params success:^(AFHTTPRequestOperation *operation, id response) {
        //  NSLog(@"response: %@", response);
        self.businessDictionary = response[@"businesses"];
        [self.YelpTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
    [self.YelpTableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"search TEXT:%@",searchBar.text);
    [self updateTable:searchBar.text params:nil];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   // NSLog(@"total: %d", self.businessDictionary.count);

    return self.businessDictionary.count;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YelpCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YelpCellID" forIndexPath:indexPath];
    NSDictionary *business =self.businessDictionary[indexPath.row];
    NSArray *categories = business[@"categories"];
    NSMutableArray *categoryNames = [NSMutableArray array];
    [categories enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        
        [categoryNames addObject:obj[0]];
    }];
    NSString *street = [business valueForKeyPath:@"location.address"][0];
    
    NSString *nebor  = [business valueForKeyPath:@"location.neighborhoods"][0];
    cell.addressLable.text = [NSString stringWithFormat:@"%@, %@", street, nebor];
    cell.categoryLabel.text = [categoryNames componentsJoinedByString:@", "];
    float distance = [business[@"distance"] integerValue] * 0.000621371;
    cell.distanceLabel.text = [NSString stringWithFormat:@"%0.2f", distance];
    cell.storeLable.text = business[@"name"];
    cell.reviewLabel.text = [NSString stringWithFormat:@"%ld", [business[@"review_count"] integerValue]];
    NSString *posterURLString = business[@"image_url"];
    [cell.posterView setImageWithURL:[NSURL URLWithString:posterURLString]];
   
    NSString *ratingUrl = business[@"rating_img_url"];
    [cell.ratingView setImageWithURL:[NSURL URLWithString:ratingUrl]];


    return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UINavigationController *navVC = segue.destinationViewController;
    FilterViewController *filterVC=(FilterViewController *) navVC.topViewController;
    filterVC.delegate = self;
}



-(void)filterViewController:(FilterViewController *)viewController didUpdateFilters:(NSDictionary *)filters {
    int count = (int)filters.count;
   
    [self updateTable:@"Restaurants" params:filters];
    NSLog(@"total Filter %d %@",count, filters);
}

@end
