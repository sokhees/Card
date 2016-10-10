//
//  PickCardViewController.h
//  DailyTarrot
//
//  Created by Do Quoc Lam on 9/13/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import "ViewController.h"

@interface PickCardViewController : ViewController {
    //List image view to display card
    NSMutableArray *imageViewArray;
    
    //index card selected;
    NSInteger indexSelected;
}
@property (weak, nonatomic) IBOutlet UIButton *buttonPick;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic) NSInteger typeCard;
@end
