//
//  ViewController.m
//  CartoonTest
//
//  Created by 一波 on 2017/4/26.
//  Copyright © 2017年 一波. All rights reserved.
//

#import "ViewController.h"
#import "DetailTableViewController.h"
#import <SDWebImageManager.h>
#import <SDImageCache.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *cacheLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setCacheSize];
}

- (void)setCacheSize{
    CGFloat tmpSize = [SDImageCache sharedImageCache].getSize;
    NSLog(@"%f",tmpSize);
    CGFloat MSize = tmpSize/1024/1024;
    self.cacheLabel.text = MSize >= 1 ? [NSString stringWithFormat:@"%.2fM",MSize] : [NSString stringWithFormat:@"%.2fK",tmpSize / 1024];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clearCache:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清除缓存？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction  = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[SDImageCache sharedImageCache] clearDisk];
        [[SDImageCache sharedImageCache] clearMemory];
        [self resetDefaults];
        [self setCacheSize];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    [alert addAction:confirmAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (void)resetDefaults {
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     int chapter = 0;
     if ([segue.identifier isEqualToString:@"first"]) {
         chapter = 1;
     }
     else if ([segue.identifier isEqualToString:@"second"]) {
         chapter = 2;
     }
     else if ([segue.identifier isEqualToString:@"firstSmall"]){
         chapter = 3;
     }
     else if ([segue.identifier isEqualToString:@"secondSmall"]){
         chapter = 4;
     }
     else {
         return;
     }
     DetailTableViewController  *activityDetailVC = segue.destinationViewController;
     activityDetailVC.chapter = chapter;
     
     
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 


@end
