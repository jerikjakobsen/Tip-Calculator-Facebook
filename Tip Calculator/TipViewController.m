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
@property (weak, nonatomic) IBOutlet UIView *showBillSplitBarView;
@property (weak, nonatomic) IBOutlet UIStepper *partyAmountStepper;
@property (weak, nonatomic) IBOutlet UILabel *splitBillForLabel;
@property (weak, nonatomic) IBOutlet UILabel *splitBillAmount;
@property (weak, nonatomic) IBOutlet UILabel *changePartyAmountLabel;
@property bool isShowingSplitBill;

@end

@implementation TipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.showBillSplitBarView.layer.cornerRadius = 6;
    
}

- (void) viewWillAppear:(BOOL)animated {
    [self loadSettings];
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
    self.splitBillAmount.text = [NSString stringWithFormat:@"$ %.2f", totalBill/ (int) self.partyAmountStepper.value];
    
    
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
        tipLabelsFrame.origin.y += 600;
        //CGRect billLabelFrame = self.totalAmountLabel.frame;
        //billLabelFrame.origin.y -= 20;
        CGRect tipLabelViewFrame = self.tipLabelView.frame;
        tipLabelViewFrame.origin.y -= 200;
        self.tipLabelView.frame = tipLabelViewFrame;
        //self.totalAmountLabel.frame = billLabelFrame;
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
        tipLabelsFrame.origin.y -= 600;
        //CGRect billLabelFrame = self.totalAmountLabel.frame;
        //billLabelFrame.origin.y += 20;
        CGRect tipLabelViewFrame = self.tipLabelView.frame;
        tipLabelViewFrame.origin.y += 200;
        self.tipLabelView.frame = tipLabelViewFrame;
        //self.totalAmountLabel.frame = billLabelFrame;
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
- (IBAction)partyAmountStepperChanged:(id)sender {
    [self updateLabels: sender];
    self.splitBillForLabel.text = [NSString stringWithFormat: @"Split Bill For %d", (int) self.partyAmountStepper.value];
}
- (void) showSplitBillOption {
    [self hideTipLabels];
}

- (void) hideSplitBillOption {
    [self showTipLabels];
    
}
- (IBAction)onSplitBillSwipeUp:(id)sender {
    [self showSplitBillOption];
}
- (IBAction)onSplitBillSwipeDown:(id)sender {
    [self hideSplitBillOption];
}

- (void) loadSettings {
    if ([[[NSUserDefaults.standardUserDefaults dictionaryRepresentation] allKeys] containsObject:@"theme"]) {
        if ([[NSUserDefaults standardUserDefaults] integerForKey: @"theme"]) {
            [self setThemeToDark];
        } else [self setThemeToLight];
    }
    
    if ([[[NSUserDefaults.standardUserDefaults dictionaryRepresentation] allKeys] containsObject:@"defaultTip"]) {
        self.tipSlider.value = [[NSUserDefaults standardUserDefaults] integerForKey:@"defaultTip"];
        [self sliderChanged: (id) nil];

    }
}

- (void) setThemeToDark {
    self.totalAmountView.backgroundColor = UIColor.darkGrayColor;
    self.showBillSplitBarView.backgroundColor = UIColor.whiteColor;
    self.totalAmountLabel.textColor = UIColor.whiteColor;
    self.splitBillAmount.textColor = UIColor.whiteColor;
    self.splitBillForLabel.textColor = UIColor.whiteColor;
    self.changePartyAmountLabel.textColor = UIColor.whiteColor;
}

- (void) setThemeToLight {
    self.totalAmountView.backgroundColor = UIColor.whiteColor;
    self.showBillSplitBarView.backgroundColor = UIColor.darkGrayColor;
    self.totalAmountLabel.textColor = UIColor.darkGrayColor;
    self.splitBillAmount.textColor = UIColor.darkGrayColor;
    self.splitBillForLabel.textColor = UIColor.darkGrayColor;
    self.changePartyAmountLabel.textColor = UIColor.darkGrayColor;
}
@end
