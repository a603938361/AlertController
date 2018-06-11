//
//  AlertViewController.m
//  TestAlert
//
//  Created by Shunli, Huang on 2018/6/11.
//  Copyright © 2018年 Shunli, Huang. All rights reserved.
//

#import "AlertViewController.h"

#define kLineHeight             10
#define kCNColor(r, g, b, a)   [UIColor colorWithRed : r / 255.0f green : g / 255.0f blue : b / 255.0f alpha : a]

@interface AlertViewController ()

@property (nonatomic, strong) NSArray *actionArr;
@property (nonatomic, copy) NSString *cancelStr;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSString *destructiveStr;
@property (nonatomic, copy) ActionSheetBlock actionButtonClick;
@end

@implementation AlertViewController

- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
             actionSheetBlock:(ActionSheetBlock) actionSheetBlock
{
    self = [super init];
    if (self) {
        self.actionButtonClick = actionSheetBlock;
        self.definesPresentationContext = YES;
        self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
        _destructiveStr = destructiveButtonTitle;
        _actionArr = otherButtonTitles;
        _cancelStr = cancelButtonTitle;
        _titleStr = title;
        
        NSMutableArray *titleArray = [NSMutableArray array];
        if (_destructiveStr.length) {
            [titleArray addObject:_destructiveStr];
        }
        [titleArray addObjectsFromArray:otherButtonTitles];
        _actionArr = [NSArray arrayWithArray:titleArray];
        
        [self setupSubViews];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self cancelButtonClick];
}

- (void)setupSubViews
{
    if ([_cancelStr isEqualToString:@""]) _cancelStr = nil;
    
    if (_cancelStr) {
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setTitle:_cancelStr forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:[self fmt_imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        cancelBtn.frame = CGRectMake(0, self.view.frame.size.height - 55, self.view.frame.size.width, 55);
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightLight];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:[self fmt_imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:[self fmt_imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
        [cancelBtn addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:cancelBtn];
        
        UIView *grayView = [UIView new];
        grayView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        grayView.frame = CGRectMake(0, CGRectGetMinY(cancelBtn.frame)-10, self.view.frame.size.height, 10);
        [self.view addSubview:grayView];
        
        [self setupActionButtonsWithShowCancelBtn:YES];
    }else{
        [self setupActionButtonsWithShowCancelBtn:NO];
    }
}

- (void)setupActionButtonsWithShowCancelBtn:(BOOL)flag
{
    UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    for (int i=0; i<_actionArr.count; i++) {
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tempBtn = cancelBtn;
        if (flag) {
            cancelBtn.frame = CGRectMake(0, self.view.frame.size.height - 55*(i+2) - kLineHeight, self.view.frame.size.width, 55);
        }else{
            cancelBtn.frame = CGRectMake(0, self.view.frame.size.height - 55*(i+1), self.view.frame.size.width, 55);
        }
        if (i == _actionArr.count - 1 && _destructiveStr.length) {
            [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }else{
            [cancelBtn setTitleColor:kCNColor(51,51, 51, 1) forState:UIControlStateNormal];
            UIView *lineView = [UIView new];
            lineView.backgroundColor = kCNColor(204, 204, 204, 1);
            lineView.frame = CGRectMake(0, 0, self.view.frame.size.width, 1);
            [cancelBtn addSubview:lineView];
        }
        [cancelBtn setTitle:_actionArr[_actionArr.count-i-1] forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightLight];
        [cancelBtn setBackgroundImage:[self fmt_imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:[self fmt_imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
        cancelBtn.tag = i;
        [cancelBtn addTarget:self action:@selector(buttonClickWithTag:) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.alpha = 1;
        [self.view addSubview:cancelBtn];
    }
    
    if (![_titleStr isEqualToString:@""]) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(0, tempBtn.frame.origin.y-44, self.view.frame.size.width, 44);
        titleLabel.text = _titleStr;
        titleLabel.backgroundColor = kCNColor(242, 242, 242, 1);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textColor = kCNColor(102, 102, 102, 1);
        [self.view addSubview:titleLabel];
    }
}

- (void)cancelButtonClick
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)buttonClickWithTag:(UIButton *)btn
{
    //NSLog(@"tag --- %i", _actionArr.count - btn.tag - 1);
    NSInteger buttonTag = _actionArr.count - btn.tag - 1;
    if (self.actionButtonClick) {
        self.actionButtonClick(buttonTag);
    }
}

- (UIImage *)fmt_imageWithColor:(UIColor *)color {
    return [self fmt_imageWithColor:color size:CGSizeMake(1, 1)];
}

- (UIImage *)fmt_imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
