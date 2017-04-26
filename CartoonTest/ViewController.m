//
//  ViewController.m
//  CartoonTest
//
//  Created by 一波 on 2017/4/26.
//  Copyright © 2017年 一波. All rights reserved.
//

#import "ViewController.h"
#import "DetailTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     int chapter = 0;
     if ([segue.identifier isEqualToString:@"first"]) {
         chapter = 1;
     }
     else if ([segue.identifier isEqualToString:@"secend"]) {
         chapter = 2;
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
