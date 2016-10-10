//
//  PickCardViewController.m
//  DailyTarrot
//
//  Created by Do Quoc Lam on 9/13/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import "PickCardViewController.h"
#import "AppDelegate.h"
#import "DetailCardViewController.h"
@interface PickCardViewController ()

@end

@implementation PickCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createView];
    self.buttonPick.hidden = YES;
    indexSelected = 9999;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createView {
    NSArray *tarotArray = [AppDelegate sharedInstance].TarotCardArray;
    
    imageViewArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < tarotArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40 +i*100, (self.view.frame.size.height - 450)*2/3, 180, 290)];
        imageView.image = [UIImage imageNamed:@"backcard.png"];
        imageView.userInteractionEnabled = YES;
        [imageViewArray addObject:imageView];
        [self.scrollView addSubview:imageView];
        
        //add gesture
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(cardSelected:)];
        [imageView addGestureRecognizer:singleFingerTap];

        
        self.scrollView.contentSize = CGSizeMake(100 * tarotArray.count + 200, 300);
    }
    self.buttonPick.layer.cornerRadius = 3.0f;
}

- (void)cardSelected:(UITapGestureRecognizer *)sender {
    NSInteger indexTap = [imageViewArray indexOfObject:sender.view];
    if (indexSelected == indexTap) {
        return;
    }
    if (indexTap < arrayTarots.count) {
        
        self.buttonPick.hidden = NO;
        UIImageView *thisImageViewTapped = [imageViewArray objectAtIndex:indexTap];
        [self goUpCard:thisImageViewTapped];
        
        
        if (indexSelected >= arrayTarots.count) {
            indexSelected = indexTap;
            return;
        }
        UIImageView *currentUpImageView = [imageViewArray objectAtIndex:indexSelected];
        [self goDownCard:currentUpImageView];
        indexSelected = indexTap;
        
        
    }
}
- (IBAction)buttonBackClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)buttonPickClick:(id)sender {
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    DetailCardViewController *detailVC = [main instantiateViewControllerWithIdentifier:@"DetailVC"];
    detailVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    detailVC.typeCard = self.typeCard;
    detailVC.callBackDismissBlock = ^(){
        [self dismissViewControllerAnimated:NO completion:nil];
    };
    [self presentViewController:detailVC animated:YES completion:nil];
}

- (void)goUpCard:(UIImageView *)view {
    CGRect frame = view.frame;
    frame.origin.y -= 70;
    view.frame = frame;
}

- (void)goDownCard:(UIImageView *)view {
    CGRect frame = view.frame;
    frame.origin.y += 70;
    view.frame = frame;
}
@end
