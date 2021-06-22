//
//  SettingsViewController.m
//  Tip Calculator
//
//  Created by johnjakobsen on 6/22/21.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISlider *defaultTipSlider;
@property (weak, nonatomic) IBOutlet UILabel *defaultTipLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *themeSegmentedControl;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated {
    if ([[[NSUserDefaults.standardUserDefaults dictionaryRepresentation] allKeys] containsObject:@"theme"]) {
        self.themeSegmentedControl.selectedSegmentIndex = [[NSUserDefaults standardUserDefaults] integerForKey: @"theme"];
        if ([[NSUserDefaults standardUserDefaults] integerForKey: @"theme"]) {
            [self setThemeToDark];
        } else [self setThemeToLight];
    }
    
    if ([[[NSUserDefaults.standardUserDefaults dictionaryRepresentation] allKeys] containsObject:@"defaultTip"]) {
        self.defaultTipSlider.value = [[NSUserDefaults standardUserDefaults] integerForKey:@"defaultTip"];
        self.defaultTipLabel.text = [NSString stringWithFormat: @"%d %%", (int) self.defaultTipSlider.value];
    }
}

- (IBAction)onTipValueChanged:(id)sender {
    
    self.defaultTipLabel.text = [NSString stringWithFormat: @"%d %%", (int) self.defaultTipSlider.value];
}
- (void)viewWillDisappear:(BOOL)animated {
    [[NSUserDefaults standardUserDefaults] setInteger: (int) self.defaultTipSlider.value forKey:@"defaultTip"];
    bool theme = self.themeSegmentedControl.selectedSegmentIndex;
    [[NSUserDefaults standardUserDefaults] setInteger:theme forKey:@"theme"];
}
- (IBAction)onThemeChange:(id)sender {
    if (self.themeSegmentedControl.selectedSegmentIndex) {
        [self setThemeToDark];
    } else [self setThemeToLight];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void) setThemeToDark {
    self.view.backgroundColor = UIColor.darkGrayColor;
    self.defaultTipSlider.thumbTintColor = UIColor.whiteColor;
}

- (void) setThemeToLight {
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    self.defaultTipSlider.thumbTintColor = UIColor.darkGrayColor;

}
@end
