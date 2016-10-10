//
//  ViewController.h
//  DailyTarrot
//
//  Created by Do Quoc Lam on 9/13/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMobileAds;
@interface ViewController : UIViewController {
    NSArray *arrayTarots;
    BOOL isOpenWork,isOpenHealth,isOpenFinance,isOpenLove;
}
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImage;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;

@property (weak, nonatomic) IBOutlet GADBannerView *bannerAdmod;

@end

