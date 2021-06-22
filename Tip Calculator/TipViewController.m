//
//  TipViewController.m
//  Tip Calculator
//
//  Created by johnjakobsen on 6/22/21.
//

#import "TipViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billField;
@property (weak, nonatomic) IBOutlet UILabel *tipPercentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;
@property (weak, nonatomic) IBOutlet UISlider *tipSlider;
@property (weak, nonatomic) IBOutlet UIView *tipView;
@property (weak, nonatomic) IBOutlet UIView *totalAmountView;
@property (weak, nonatomic) IBOutlet UIView *tipLabelView;

@end

@implementation TipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)onTapView:(id)sender {
    NSLog(@"Hello World");
    [self showTipLabels];
    [self.view endEditing: true];
}
- (IBAction)updateLabels:(id)sender {
    double bill = [self.billField.text doubleValue];
    double totalBill = bill + bill * ((int) self.tipSlider.value)/100;
    self.tipAmountLabel.text = [NSString stringWithFormat:@"$ %.2f", bill * ((int) self.tipSlider.value)/100];
    self.totalAmountLabel.text = [NSString stringWithFormat: @"$ %.2f", totalBill];
    
    
}
- (IBAction)sliderChanged:(id)sender {
    self.tipPercentageLabel.text = [NSString stringWithFormat:@"%d %%", (int) self.tipSlider.value];
    [self updateLabels: (id) sender];
}

- (void)hideTipLabels {
    [UIView animateWithDuration: 0.3 animations:^{
        CGRect billFrame = self.totalAmountView.frame;
        billFrame.origin.y -= 200;
        CGRect tipLabelsFrame = self.tipView.frame;
        tipLabelsFrame.origin.y += 500;
        CGRect billLabelFrame = self.totalAmountLabel.frame;
        billLabelFrame.origin.y -= 50;
        CGRect tipLabelViewFrame = self.tipLabelView.frame;
        tipLabelViewFrame.origin.y -= 200;
        self.tipLabelView.frame = tipLabelViewFrame;
        self.totalAmountLabel.frame = billLabelFrame;
        self.totalAmountView.frame = billFrame;
        self.tipView.frame = tipLabelsFrame;
        self.totalAmountView.layer.cornerRadius = 20;
    }];
    
}
- (void) showTipLabels {
    [UIView animateWithDuration: 0.3 animations:^{
        CGRect billFrame = self.totalAmountView.frame;
        billFrame.origin.y += 200;
        CGRect tipLabelsFrame = self.tipView.frame;
        tipLabelsFrame.origin.y -= 500;
        CGRect billLabelFrame = self.totalAmountLabel.frame;
        billLabelFrame.origin.y += 50;
        CGRect tipLabelViewFrame = self.tipLabelView.frame;
        tipLabelViewFrame.origin.y += 200;
        self.tipLabelView.frame = tipLabelViewFrame;
        self.totalAmountLabel.frame = billLabelFrame;
        self.totalAmountView.frame = billFrame;
        self.tipView.frame = tipLabelsFrame;
        self.totalAmountView.layer.cornerRadius = 0;
    }];
}
- (IBAction)onStartEditing:(id)sender {
    [self hideTipLabels];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
