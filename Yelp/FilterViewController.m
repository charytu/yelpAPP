//
//  FilterViewController.m
//  Yelp
//
//  Created by Chary Tu on 6/21/15.
//  Copyright (c) 2015 chary tu. All rights reserved.
//

#import "FilterViewController.h"
#import "SwitchCell.h"

@interface FilterViewController ()<UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *switchDictionary;
@property(strong, nonatomic)NSArray *SectionTitles;
@property (strong, nonatomic) NSDictionary *yelpDatas;

@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if(self){
        self.switchDictionary = [[NSMutableDictionary alloc]init];
        self.yelpDatas = [[NSDictionary alloc]init];
     
        self.yelpDatas = @{@"Category" : @[@{@"name" : @"Afghan",       @"code" : @"afghani"},
                                           @{@"name" : @"American New", @"code" : @"newamerican"},
                                           @{@"name" : @"Banuettes",    @"code" : @"banuettes"},
                                           @{@"name" : @"Barbeque",     @"code" : @"bbq"},
                                           @{@"name" : @"Beisl",        @"code" : @"beisl"},
                                           @{@"name" : @"Burmese",      @"code": @"burmese"},
                                           @{@"name" : @"Cajun/Creole", @"code": @"cajun"},
                                           @{@"name" : @"Chinese",      @"code" : @"chiness"}],
                           @"Sort"     : @[@{@"name" : @"Best match",   @"code" : @"0"},
                                           @{@"name" : @"Distance",     @"code" : @"1"},
                                           @{@"name" : @"Highest Rated",@"code" : @"2"}],
                           @"Radius"   : @[@{@"name" : @"1 miles",      @"code" : @"1"},
                                           @{@"name" : @"5 miles",      @"code" : @"5"},
                                           @{@"name" : @"10 miles",     @"code": @"10"}],
                           @"Offer a Deal":@[@{@"name" : @"deals",      @"code" : @"true"}]};
                           
                           
        self.SectionTitles = [self.yelpDatas allKeys];
    }
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.SectionTitles count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.SectionTitles objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSString *sectionTitle = [self.SectionTitles objectAtIndex:section];
    NSArray *sectionItems = [self.yelpDatas objectForKey:sectionTitle];
    return [sectionItems count];
}

- (IBAction)onClick:(id)sender {
   [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onDone:(id)sender {
    [self.delegate filterViewController:self didUpdateFilters:self.switchDictionary];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
*/
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCellID" forIndexPath:indexPath];
    
    
    NSString *sectionTitle = [self.SectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionItems = [self.yelpDatas objectForKey:sectionTitle];
    NSString *item = sectionItems[indexPath.row][@"name"];
    cell.FilterLable.text = item;
 
    
    
   // cell.FilterLable.text = [NSString stringWithFormat:@"filter %ld", (long)indexPath.row];
    cell.delegate = self;
  
    NSNumber *value = [self.switchDictionary objectForKey:@(indexPath.row)];
    if(value != nil){
        cell.filterSwitch.on = value.boolValue;
    }else{
        cell.filterSwitch.on = NO;
    }
    
    return cell;
}

-(void)SwitchCell:(SwitchCell *)cell didChangeValue:(BOOL)value{
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSString *section      = [self.SectionTitles objectAtIndex:indexPath.section];
    NSString *item         = [self.yelpDatas objectForKey:section][indexPath.row][@"code"];
   // [self.switchDictionary setObject:@(value) forKey:@(indexPath.row)];
    NSString * filter;
    if ([ section isEqualToString: @"Category"]) {
        filter =@"category_filter";
        
    }else if([ section isEqualToString: @"Sort"]) {
        filter = @"sort";
        
    }else if([ section isEqualToString: @"Radius"]){
        filter = @"radius_filter";
        
    }else if([ section isEqualToString: @"Offer a Deal"]){
        filter = @"deals_filter";
    }
    
    if(value) {
        
      if( indexPath.section == 1 && [self.switchDictionary valueForKey:filter] != nil) {
        
        NSString *filter_cat = [NSString stringWithFormat:@"%@,%@",item,[self.switchDictionary valueForKey:filter]];
        
        [self.switchDictionary setObject:filter_cat forKey:filter];
      } else {
        [self.switchDictionary setObject:item forKey:filter];
      }
    }else{
        [self.switchDictionary removeObjectForKey:filter];
    }
    
    NSLog(@"VC Change : section:%d => %@ path:%d => %@", (int) indexPath.section,section, (int)indexPath.row, item);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
