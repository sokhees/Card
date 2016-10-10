//
//  ViewController.m
//  DailyTarrot
//
//  Created by Do Quoc Lam on 9/13/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import "ViewController.h"
#import "DBHelper.h"
#import "TarotDetails.h"
#import "AppDelegate.h"
#import "PickCardViewController.h"
#import "Const.h"
#import "DataAccess.h"
#import "DetailCardViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    arrayTarots = [AppDelegate sharedInstance].TarotCardArray;
    [self setDisplay];
    
    self.bannerAdmod.adUnitID = @"ca-app-pub-1033592509452797/2585334662";
    self.bannerAdmod.rootViewController = self;
    GADRequest *request = [GADRequest request];
    // Requests test ads on devices you specify. Your test device ID is printed to the console when
    // an ad request is made. GADBannerView automatically returns test ads when running on a
    // simulator.
    request.testDevices = @[kGADSimulatorID];
    [self.bannerAdmod loadRequest:request];
    
//    [GADRequest request].testDevices = @[ kGADSimulatorID ];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setImageForCard];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}
//Default setting layout
- (void)setDisplay {
    self.resetButton.layer.cornerRadius = 5.0f;
    self.backGroundImage.image = [UIImage imageNamed:@"mainbg.png"];
    NSArray *imageViewArray = [NSArray arrayWithObjects:self.imageView,self.imageView1,self.imageView2,self.imageView3, nil];
    UIImage *imageBackCard = [UIImage imageNamed:@"backcard.png"];
    for (UIImageView *imageView in imageViewArray) {
        imageView.tag = [imageViewArray indexOfObject:imageView];
        [self animation:imageView zoomOut:YES];
        imageView.image = imageBackCard;
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(cardTapped:)];
        [imageView addGestureRecognizer:singleFingerTap];
        
        
    }
    
}
//Show Card Image
- (void)setImageForCard {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        TarotDetails *tarot;
        UIImage *imageBackCard = [UIImage imageNamed:@"backcard.png"];
        for (int i = 0; i < 4; i++) {
            switch (i) {
                case WorkType:
                    tarot = [DataAccess getTarrotForKey:kWork];
                    if (tarot) {
                        self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",tarot.name]];
                        isOpenWork = YES;
                    }else {
                        self.imageView.image = imageBackCard;
                        
                    }
                    break;
                case HealthType:
                    tarot = [DataAccess getTarrotForKey:kHealth];
                    if (tarot) {
                        self.imageView3.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",tarot.name]];
                        isOpenHealth = YES;
                    }else {
                        self.imageView3.image = imageBackCard;
                        
                    }
                    break;
                case FinanceType:
                    tarot = [DataAccess getTarrotForKey:kFinance];
                    if (tarot) {
                        self.imageView1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",tarot.name]];
                        isOpenFinance = YES;
                    }else {
                        self.imageView1.image = imageBackCard;
                        
                    }
                    break;
                case LoveType:
                    tarot = [DataAccess getTarrotForKey:kLove];
                    if (tarot) {
                        
                        self.imageView2.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",tarot.name]];
                        isOpenLove = YES;
                    }else {
                        self.imageView2.image = imageBackCard;
                    }
                    break;
            }
        }
        
    });
}

//Animation zoom in zoom out
- (void)animation:(UIView *)view zoomOut:(BOOL)isZoom {
    [UIView animateWithDuration:2.0 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        CGFloat scaleRatio = isZoom?1.06f:1;
        view.transform =CGAffineTransformMakeScale(scaleRatio,scaleRatio);
        
    }   completion:^(BOOL finished) {
        [self animation:view zoomOut:!isZoom];
    }];

}

#pragma mark - Card Click

- (void)cardTapped:(UITapGestureRecognizer *)sender{
    
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    PickCardViewController *cardVC = [main instantiateViewControllerWithIdentifier:@"PickCardVC"];
    cardVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    DetailCardViewController *detailVc = [main instantiateViewControllerWithIdentifier:@"DetailVC"];
    detailVc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    switch (sender.view.tag) {
        case 0:
            if (isOpenWork) {
                detailVc.typeCard = WorkType;
                detailVc.tarot = [DataAccess getTarrotForKey:kWork];
                [self presentViewController:detailVc animated:YES completion:nil];
            } else {
            cardVC.typeCard = WorkType;
                [self presentViewController:cardVC animated:YES completion:nil];
            }
            break;
        case 1:
            if (isOpenFinance) {
                detailVc.typeCard = FinanceType;
                detailVc.tarot = [DataAccess getTarrotForKey:kFinance];
                [self presentViewController:detailVc animated:YES completion:nil];
            } else {
                cardVC.typeCard = FinanceType;
                [self presentViewController:cardVC animated:YES completion:nil];
            }
            
            break;
        case 2:
            if (isOpenLove) {
                detailVc.typeCard = LoveType;
                detailVc.tarot = [DataAccess getTarrotForKey:kLove];
                [self presentViewController:detailVc animated:YES completion:nil];
            } else {
                cardVC.typeCard = LoveType;
                [self presentViewController:cardVC animated:YES completion:nil];
            }
            
            break;
            
        default:
            if (isOpenHealth) {
                detailVc.typeCard = HealthType;
                detailVc.tarot = [DataAccess getTarrotForKey:kHealth];
                [self presentViewController:detailVc animated:YES completion:nil];
            } else {
                cardVC.typeCard = HealthType;
                [self presentViewController:cardVC animated:YES completion:nil];
            }
           
            break;
    }
    
}
- (IBAction)resetButtonClick:(id)sender {
    NSArray *arr = @[kWork,kHealth,kLove,kFinance];
    for (NSString *str in arr) {
        [DataAccess setDailyTarot:nil forKey:str];
    }
    isOpenHealth = NO;
    isOpenLove = NO;
    isOpenWork = NO;
    isOpenFinance = NO;
    [self setImageForCard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
