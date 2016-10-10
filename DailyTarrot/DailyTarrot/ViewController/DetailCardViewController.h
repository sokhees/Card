//
//  DetailCardViewController.h
//  DailyTarrot
//
//  Created by Do Quoc Lam on 9/15/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import "ViewController.h"
#import "TarotDetails.h"
#import <FBSDKShareKit/FBSDKShareKit.h>
#import "Const.h"

@interface DetailCardViewController : UIViewController {
    NSArray *arrayTarot;
    NSString *typeName;
    
}
@property (strong, nonatomic) TarotDetails *tarot;
@property (nonatomic) TypeCard type;
@property (weak, nonatomic) IBOutlet UILabel *labelNameCard;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textField;

@property (weak, nonatomic) IBOutlet UIView *imageViewBorder;
@property (nonatomic) NSInteger typeCard;
@property (copy,nonatomic) void(^callBackDismissBlock)();
@end
