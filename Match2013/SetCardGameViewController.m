//
//  SetCardGameViewController.m
//  Match2013
//
//  Created by Akinbiyi Adesina Lalude on 11/21/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "HistoryViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// set cards need to be generated when displayed the first time
    [self updateUI];
}

- (Deck *)createDeck
{
    // It would be best to set this property when initializing the view controller
    self.gameType = @"Set Cards";
    
    return [[SetCardDeck alloc] init];
}

- (void)updateUI
{
    // run super classes's update
    [super updateUI];
    
    self.flipDescription.attributedText = [self replaceCardDescriptionsInText:self.flipDescription.attributedText];

}

- (NSAttributedString *)replaceCardDescriptionsInText:(NSAttributedString *)text
{
    NSMutableAttributedString *newText = [text mutableCopy];
    
    // returns list of cards mentioned in the flip description
    NSArray *setCards = [SetCard cardsFromText:text.string];
    
    // replace card descriptions with card titles
    if (setCards)
    {
        for (SetCard *setCard in setCards)
        {
            NSRange range = [newText.string rangeOfString:setCard.contents];
            
            if (range.location != NSNotFound)
            {
                [newText replaceCharactersInRange:range
                             withAttributedString:[self titleForCard:setCard]];
            }
        }
    }
    
    return newText;
}



- (NSAttributedString *)titleForCard:(Card *)card
{
    // Create a string with a dummy content and an empty dictionary for the string attributes, which at the end are used to create the attributed string
    NSString *symbol = @"?";
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    
    if ([card isKindOfClass:[SetCard class]])
    {
        SetCard *setCard = (SetCard *)card;
        
        if ([setCard.symbol isEqualToString:@"oval"]) symbol = @"●";
        if ([setCard.symbol isEqualToString:@"squiggle"]) symbol = @"▲";
        if ([setCard.symbol isEqualToString:@"diamond"]) symbol = @"■";
        
        symbol = [symbol stringByPaddingToLength:setCard.number
                                      withString:symbol
                                 startingAtIndex:0];
        
        if ([setCard.color isEqualToString:@"red"])
            [attributes setObject:[UIColor redColor]
                           forKey:NSForegroundColorAttributeName];
        if ([setCard.color isEqualToString:@"green"])
            [attributes setObject:[UIColor greenColor]
                           forKey:NSForegroundColorAttributeName];
        if ([setCard.color isEqualToString:@"purple"])
            [attributes setObject:[UIColor purpleColor]
                           forKey:NSForegroundColorAttributeName];
        
        if ([setCard.shading isEqualToString:@"solid"])
            [attributes setObject:@-5
                           forKey:NSStrokeWidthAttributeName];
        if ([setCard.shading isEqualToString:@"striped"])
            [attributes addEntriesFromDictionary:@{NSStrokeWidthAttributeName : @-5,
                                                   NSStrokeColorAttributeName : attributes[NSForegroundColorAttributeName],
                                               NSForegroundColorAttributeName : [attributes[NSForegroundColorAttributeName] colorWithAlphaComponent:0.1]}];
        if ([setCard.shading isEqualToString:@"open"])
            [attributes setObject:@5
                           forKey:NSStrokeWidthAttributeName];
    }
    
    // a new title
    return [[NSMutableAttributedString alloc] initWithString:symbol attributes:attributes];
}

// Backgrounds that let the user see the difference between a selected and unselected card
- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.chosen ? @"setCardSelected" : @"setCard"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show History"])
    {
        if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]])
        {
            NSMutableArray *attributedHistory = [NSMutableArray array];
            
            for (NSString *flip in self.flipHistory)
            {
                NSAttributedString *attributedFlip = [[NSAttributedString alloc] initWithString:flip];
                [attributedHistory addObject:[self replaceCardDescriptionsInText:attributedFlip]];
            }
            
            [segue.destinationViewController setHistory:attributedHistory];
        }
    }
}

/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 */

@end
