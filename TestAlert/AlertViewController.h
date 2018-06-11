//
//  AlertViewController.h
//  TestAlert
//
//  Created by Shunli, Huang on 2018/6/11.
//  Copyright © 2018年 Shunli, Huang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionSheetBlock)(NSInteger buttonTag);

@interface AlertViewController : UIViewController

- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
             actionSheetBlock:(ActionSheetBlock) actionSheetBlock;

@end
