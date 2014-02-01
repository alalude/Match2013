//
//  CardGameViewController.m
//  Match2013
//
//  Created by Akinbiyi Adesina Lalude on 11/5/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
// #import "HistoryViewController.h" // - - - - - - - - - - CHOP
#import "GameResult.h"
#import "GameSettings.h"


@interface CardGameViewController ()

/*
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck *deck;
*/

@property (strong, nonatomic) CardMatchingGame *game;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

// @property (weak, nonatomic) IBOutlet UISegmentedControl *modeSelector; // - - - - - - - - - - CHOP

// @property (weak, nonatomic) IBOutlet UISlider *historySlider; // - - - - - - - - - - CHOP

@property (strong, nonatomic) GameResult *gameResult;

@property (strong, nonatomic) GameSettings *gameSettings;

@end

@implementation CardGameViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Assure the settings from the settings tab are used immediately upon return to the card game
    self.game.matchBonus = self.gameSettings.matchBonus;
    self.game.mismatchPenalty = self.gameSettings.mismatchPenalty;
    self.game.flipCost = self.gameSettings.flipCost;
}

- (CardMatchingGame *) game // intializer
{
    if (!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
        //The outlet property is needed when the deal button is pressed to update the mode of the new game during lazy instantiation
        // [self changeModeSelector:self.modeSelector];  // - - - - - - - - - - - - - - - - - - - - CHOP
    }
    
    // Settings passed to the game upon initialization
    _game.matchBonus = self.gameSettings.matchBonus;
    _game.mismatchPenalty = self.gameSettings.mismatchPenalty;
    _game.flipCost = self.gameSettings.flipCost;
    
    return _game;
}


- (Deck *)createDeck // abstract
{
    return nil;
}

- (GameSettings *)gameSettings
{
    if (!_gameSettings) _gameSettings = [[GameSettings alloc] init];
    return _gameSettings;
}

/*
- (NSMutableArray *)flipHistory  // - - - - - - - - - - - - - - - - - - - - CHOP
{
    if (!_flipHistory)
    {
        _flipHistory = [NSMutableArray array];
    }
    
    return _flipHistory;
}

- (void)setSliderRange  // - - - - - - - - - - - - - - - - - - - - - - - - - CHOP
{
    int maxValue = [self.flipHistory count] - 1;
    self.historySlider.maximumValue = maxValue;
    [self.historySlider setValue:maxValue animated:YES];
}

- (IBAction)changeModeSelector:(UISegmentedControl *)sender  // - - - - - - - - - - CHOP
{
    self.game.maxMatchingCards =
    [[sender titleForSegmentAtIndex:sender.selectedSegmentIndex] integerValue];
}

- (GameResult *)gameResult
{
    if (!_gameResult) _gameResult = [[GameResult alloc] init];
    _gameResult.gameType = self.gameType;
    return _gameResult;
}
 */

- (IBAction)touchCardButton:(UIButton *)sender
{
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    // self.modeSelector.enabled = NO;  // - - - - - - - - - - - - - - - - - - - - - - - - - CHOP
    [self updateUI];
}

/*
- (IBAction)changeSlider:(UISlider *)sender  // - - - - - - - - - - - - - - - - - - - - CHOP
{
    int sliderValue;
    sliderValue = lroundf(self.historySlider.value);
    [self.historySlider setValue:sliderValue animated:NO];
    
    if ([self.flipHistory count])
    {
        // Low alpha for all but newest flip info
        self.flipDescription.alpha = (sliderValue + 1 < [self.flipHistory count]) ? 0.6 : 1.0;
        self.flipDescription.text = [self.flipHistory objectAtIndex:sliderValue];
        // NSLog(@"Flip Results: %@", self.flipDescription.text);
    }
}
 */

- (IBAction)dealButtonPressed:(UIButton *)sender
{
    // call initializer
    self.game = nil;
    // self.flipHistory = nil; // reset flip history  // - - - - - - - - - - - - - - - - - - CHOP
    self.gameResult = nil; // reset game result
    // self.modeSelector.enabled = YES;  // - - - - - - - - - - - - - - - - - - - - - - CHOP
    [self updateUI];
}

- (void) updateUI
{
    for (UIButton *cardButton in self.cardButtons)
    {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        
        [cardButton setAttributedTitle:[self titleForCard:card]
                              forState:UIControlStateNormal];
        
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        
        cardButton.enabled = !card.isMatched;
        
        /* Flip Result Logic
        if (self.game)  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - CHOP
        {
            NSString *description = @"";
            
            if ([self.game.lastChosenCards count])
            {
                NSMutableArray *cardContents = [NSMutableArray array];
                
                for (Card *card in self.game.lastChosenCards)
                {
                    [cardContents addObject:card.contents];
                }
                
                description = [cardContents componentsJoinedByString:@" "];
            }
            
            if (self.game.lastScore > 0)
            {
                description = [NSString stringWithFormat:@"Matched %@ for %d points.", description, self.game.lastScore];
            }
            
            else if (self.game.lastScore < 0)
            {
                
                description = [NSString stringWithFormat:@"%@ don’t match! %d point penalty!", description, -self.game.lastScore];
            }
            
            self.flipDescription.text = description;
            self.flipDescription.alpha = 1;
            
            if (![description isEqualToString:@""] && ![[self.flipHistory lastObject] isEqualToString:description])
            {
                [self.flipHistory addObject:description];
                [self setSliderRange];
            }
        }
         */
        
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
        self.gameResult.score = self.game.score;
    }
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:card.chosen ? card.contents : @""];
    return title;
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
