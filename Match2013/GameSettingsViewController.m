//
//  GameSettingsViewController.m
//  Match2013
//
//  Created by Akinbiyi Adesina Lalude on 12/5/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "GameSettingsViewController.h"
#import "GameSettings.h"

@interface GameSettingsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *matchBonusLabel;
@property (weak, nonatomic) IBOutlet UILabel *mismatchPenaltyLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipCostLabel;

@property (weak, nonatomic) IBOutlet UISlider *matchBonusSlider;
@property (weak, nonatomic) IBOutlet UISlider *mismatchPenaltySlider;
@property (weak, nonatomic) IBOutlet UISlider *flipCostSlider;

@property (strong, nonatomic) GameSettings *gameSettings;

@end

@implementation GameSettingsViewController

- (GameSettings *)gameSettings
{
    if (!_gameSettings) _gameSettings = [[GameSettings alloc] init];
    return _gameSettings;
}

/* - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - */
/* Methods set the labels as well as the settings model. The helper method assures that only discrete values are selectable */
/* - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - */


- (void)setLabel:(UILabel *)label forSlider:(UISlider *)slider
{
    int sliderValue;
    sliderValue = lroundf(slider.value);
    [slider setValue:sliderValue animated:NO];
    label.text = [NSString stringWithFormat:@"%d", sliderValue];
}

- (IBAction)matchBonusSliderChanged:(UISlider *)sender
{
    [self setLabel:self.matchBonusLabel forSlider:sender];
    self.gameSettings.matchBonus = floor(sender.value);
}

- (IBAction)mismatchPenaltySliderChanged:(UISlider *)sender
{
    [self setLabel:self.mismatchPenaltyLabel forSlider:sender];
    self.gameSettings.mismatchPenalty = floor(sender.value);
}

- (IBAction)flipCostSliderChanged:(UISlider *)sender
{
    
    
    [self setLabel:self.flipCostLabel forSlider:sender];
    self.gameSettings.flipCost = floor(sender.value);
}

// When the tab is selected, set the labels and sliders according to the stored settings
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.matchBonusSlider.value = self.gameSettings.matchBonus;
    self.mismatchPenaltySlider.value = self.gameSettings.mismatchPenalty;
    self.flipCostSlider.value = self.gameSettings.flipCost;
    
    [self setLabel:self.matchBonusLabel forSlider:self.matchBonusSlider];
    [self setLabel:self.mismatchPenaltyLabel forSlider:self.mismatchPenaltySlider];
    [self setLabel:self.flipCostLabel forSlider:self.flipCostSlider];
}



/*
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"GSVC self.gameSettings.matchBonus = %d", self.gameSettings.matchBonus);
    NSLog(@"GSVC self.gameSettings.mismatchPenalty = %d", self.gameSettings.mismatchPenalty);
    NSLog(@"GSVC self.gameSettings.flipCost = %d", self.gameSettings.flipCost);
    
    float matchBonusFloat = (float) self.gameSettings.matchBonus;
    float mismatchPenaltyFloat = (float) self.gameSettings.mismatchPenalty;
    float flipCostFloat = (float) self.gameSettings.flipCost;
    float dummySettingFloat = (float) self.gameSettings.dummySetting;
    
    NSLog(@"GSVC matchBonusFloat = %f", matchBonusFloat);
    NSLog(@"GSVC mismatchPenaltyFloat = %f", mismatchPenaltyFloat);
    NSLog(@"GSVC flipCostFloat = %f", flipCostFloat);
    
    self.matchBonusSlider.value = matchBonusFloat;
    self.mismatchPenaltySlider.value = mismatchPenaltyFloat;
    self.flipCostSlider.value = flipCostFloat;
    self.flipCostSlider.value = dummySettingFloat;
    
    
    // self.matchBonusSlider.value = self.gameSettings.matchBonus;
    // self.mismatchPenaltySlider.value = self.gameSettings.mismatchPenalty;
    // self.flipCostSlider.value = self.gameSettings.flipCost;
    
    NSLog(@"GSVC self.matchBonusSlider.value = %f", self.matchBonusSlider.value);
    NSLog(@"GSVC self.mismatchPenaltySlider.value = %f", self.mismatchPenaltySlider.value);
    NSLog(@"GSVC self.flipCostSlider.value = %f", self.flipCostSlider.value);
    
    [self setLabel:self.matchBonusLabel forSlider:self.matchBonusSlider];
    [self setLabel:self.mismatchPenaltyLabel forSlider:self.mismatchPenaltySlider];
    [self setLabel:self.flipCostLabel forSlider:self.flipCostSlider];
}
*/

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 */

@end
