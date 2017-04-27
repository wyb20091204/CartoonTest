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
#import "ImgModel.h"

@interface DetailTableViewController ()
@property (nonatomic) NSMutableArray<ImgModel *> *images;
@end

@implementation DetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DetailTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([DetailTableViewCell class])];
    switch (self.chapter) {
        case 1:
            self.title = @"第1话(原画)";
            break;
        case 2:
            self.title = @"第2话(原画)";
            break;
        case 3:
            self.title = @"第1话";
            break;
        case 4:
            self.title = @"第2话";
            break;
        default:
            self.title = @"假标题";
            break;
    }
    self.tableView.tableFooterView = [UIView new];
    [self loadData];
    
}


- (void)loadData
{
    
    [EDCLoadinGif showWithMaskType:EDCLodingMaskTypeBlack];
    
    NSString *URLString = [NSString stringWithFormat:@"%@/imgs/carton",kISBaseURL];
    
    int cha;
    if (self.chapter %2 ==1) {
        cha = 1;
    }else {
        cha = 2;
    }
    
    NSDictionary *param = @{@"chapter":@(cha)};
    
    [[DayNetwork network] POST:URLString
                    parameters:param
                       success:^(AFHTTPRequestOperation *operation, id responseObject) {
                           NSArray *data = responseObject[@"result"][@"data"];
                           NSLog(@"\n%@",data);
                           self.images = nil;
                           self.images = @[].mutableCopy;
                           NSMutableArray *urls = @[].mutableCopy;
                           for (NSString *imgUrl in data) {
                               NSString *sstr = [NSString stringWithFormat:@"%@?imageView2/2/w/%.0f",imgUrl,SCREEN_WIDTH];
                               
                               if (self.chapter == 1 ||
                                   self.chapter == 2) {
                                   [urls addObject:imgUrl]; // 原话
                               } else{
                                   [urls addObject:sstr]; // 缩略图
                               }
                           }
                           [EDCLoadinGif dismiss];
                           for (int i = 0; i < urls.count ; i ++) {
                               SDWebImageManager *manager = [SDWebImageManager sharedManager];
                               [manager downloadImageWithURL:[NSURL URLWithString:urls[i]] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                   if (image) {
                                       CGFloat imgHeght = image.size.height;
                                       CGFloat imgWidth = image.size.width;
                                       CGFloat cellHeight = SCREEN_WIDTH * imgHeght / imgWidth + 10;
                                       ImgModel *model = [ImgModel new];
                                       model.img = image;
                                       model.cellHeight = cellHeight;
                                       [self.images addObject:model];
                                       [self.tableView reloadData];
                                   }
                               }];
                           }
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
    
    cell.imgeView.image = self.images[indexPath.row].img;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        return self.images[indexPath.row].cellHeight;
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
