//
//  DetailTableViewController.m
//  CartoonTest
//
//  Created by 一波 on 2017/4/26.
//  Copyright © 2017年 一波. All rights reserved.
//

#import "DetailTableViewController.h"
#import "DetailTableViewCell.h"
#import "EDCLoadinGif.h"
#import "DayNetwork.h"
#import <UIImageView+WebCache.h>

@interface DetailTableViewController ()
@property (nonatomic) NSMutableArray<NSString *> *images;
@end

@implementation DetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DetailTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([DetailTableViewCell class])];
    self.title = [NSString stringWithFormat:@"第%d话",self.chapter];
    [self loadData];
    
}


- (void)loadData
{
    
    [EDCLoadinGif showWithMaskType:EDCLodingMaskTypeBlack];
    
    NSString *URLString = [NSString stringWithFormat:@"%@/imgs/carton",kISBaseURL];
    NSDictionary *param = @{@"chapter":@(self.chapter)};
    
    [[DayNetwork network] POST:URLString
                    parameters:param
                       success:^(AFHTTPRequestOperation *operation, id responseObject) {
                           [EDCLoadinGif dismiss];
                           
                           NSArray *data = responseObject[@"result"][@"data"];
                           NSLog(@"\n%@",data);
                           self.images = nil;
                           self.images = @[].mutableCopy;
                           for (NSString *imgUrl in data) {
                               [self.images addObject:imgUrl];
                           }
                           [self.tableView reloadData];
                       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                           [EDCLoadinGif dismiss];
                       }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.images.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DetailTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *url = self.images[indexPath.row];
    [cell.imgeView sd_setImageWithURL:[NSURL URLWithString:url]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 2200;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

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
