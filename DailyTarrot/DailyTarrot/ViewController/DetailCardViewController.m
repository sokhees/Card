//
//  DetailCardViewController.m
//  DailyTarrot
//
//  Created by Do Quoc Lam on 9/15/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import "DetailCardViewController.h"
#import "AppDelegate.h"
#include <stdlib.h>
#import "DataAccess.h"
@implementation DetailCardViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    TarotDetails *tarot;
    if (self.tarot) {
        [self setDataToDisplay:self.tarot];
        
    } else {
        [self clearCardAlreadyPicked];
        NSInteger r = arc4random_uniform((uint32_t)arrayTarot.count);
        tarot = [arrayTarot objectAtIndex:r];
        [self setDataToDisplay:tarot];
        [DataAccess setDailyTarot:tarot forKey:typeName];
    }
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",self.tarot.name]];
    UIImage *image2 = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",tarot.name]];
    FBSDKShareButton *button = [[FBSDKShareButton alloc] init];
    button.frame = CGRectMake(self.view.frame.size.width - 80, 20, button.frame.size.width, button.frame.size.height);
    FBSDKSharePhoto *photo = [FBSDKSharePhoto photoWithImage:image?image:image2 userGenerated:YES];
    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
    content.photos = @[photo];
    button.shareContent = content;
    [self.view addSubview:button];
    
   
}

- (void)setDataToDisplay:(TarotDetails *)tarot {
    self.labelNameCard.text = tarot.name;
    
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",tarot.name]];
    switch (self.typeCard) {
        case WorkType:
            self.textField.text = tarot.work;
            typeName = kWork;
            break;
        case HealthType:
            self.textField.text = tarot.health;
            typeName = kHealth;
            break;
        case FinanceType:
            self.textField.text = tarot.finances;
            typeName = kFinance;
            break;
        case LoveType:
            self.textField.text = tarot.love;
            typeName = kLove;
            break;
        default:
            break;
    }
    
    
        //
    self.imageViewBorder.layer.cornerRadius = 10.0f;
    self.imageViewBorder.layer.borderColor = [UIColor cyanColor].CGColor;
    self.imageViewBorder.layer.borderWidth = 2.0f;
}
- (void)clearCardAlreadyPicked {
    
    NSString *predicate = @"";
    for (TarotDetails *tarot in [DataAccess getAllTarotPicked]) {
        predicate = [NSString stringWithFormat:@"%@ && idCard != %ld",predicate,(long)tarot.idCard];
        
    }
    if (predicate.length >= 4) {
        predicate = [predicate substringWithRange:NSMakeRange(4, [predicate length] - 4)];
    } else {
        NSLog(@"<<<<<<<<<<<<<<<<<<");
    }
    
    NSPredicate *filterArray = [NSPredicate predicateWithFormat:[predicate isEqualToString:@""]?nil:predicate];
    
    if (filterArray) {
        arrayTarot = [[AppDelegate sharedInstance].TarotCardArray filteredArrayUsingPredicate:filterArray];
    } else {
        arrayTarot = [AppDelegate sharedInstance].TarotCardArray;
    }

}
- (IBAction)buttonBackClick:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    if (self.callBackDismissBlock) {
        self.callBackDismissBlock();
    }
}

- (void)viewWillLayoutSubviews {
    [self.textField setContentOffset:CGPointZero animated:NO];
}
@end
