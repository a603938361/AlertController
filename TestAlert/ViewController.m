//
//  ViewController.m
//  TestAlert
//
//  Created by Shunli, Huang on 2018/6/11.
//  Copyright © 2018年 Shunli, Huang. All rights reserved.
//

#import "ViewController.h"
#import "AlertViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)addCancel:(id)sender {
    AlertViewController *vc = [[AlertViewController alloc] initWithTitle:@"" cancelButtonTitle:@"取消" otherButtonTitles:@[@"测试1", @"测试2"] destructiveButtonTitle:nil actionSheetBlock:^(NSInteger buttonTag) {
        NSLog(@"--- %li", (long)buttonTag);
    }];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)addDestructive:(id)sender {
    AlertViewController *vc = [[AlertViewController alloc] initWithTitle:@"" cancelButtonTitle:@"取消" otherButtonTitles:@[@"测试1", @"测试2"] destructiveButtonTitle:@"撤销选择" actionSheetBlock:^(NSInteger buttonTag) {
        NSLog(@"--- %li", (long)buttonTag);
    }];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)addTitle:(id)sender {
    
    AlertViewController *vc = [[AlertViewController alloc] initWithTitle:@"标题" cancelButtonTitle:@"取消" otherButtonTitles:@[@"测试1", @"测试2"] destructiveButtonTitle:@"撤销选择" actionSheetBlock:^(NSInteger buttonTag) {
        NSLog(@"--- %li", (long)buttonTag);
    }];
    [self presentViewController:vc animated:YES completion:nil];
}
- (IBAction)noCancel:(id)sender {
    
    AlertViewController *vc = [[AlertViewController alloc] initWithTitle:@"标题" cancelButtonTitle:nil otherButtonTitles:@[@"测试1", @"测试2"] destructiveButtonTitle:@"撤销选择" actionSheetBlock:^(NSInteger buttonTag) {
        NSLog(@"--- %li", (long)buttonTag);
    }];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
