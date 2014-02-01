//
//  CardGameViewController.h
//  Match2013
//
//  Created by Akinbiyi Adesina Lalude on 11/5/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

// @property (weak, nonatomic) IBOutlet UILabel *flipDescription; // - - - - - - - - - - CHOP
// @property (strong, nonatomic) NSMutableArray *flipHistory;  // of NSStrings // - - - - - - - - - - CHOP
@property (strong, nonatomic) NSString *gameType;

// protected
// for subclasses
- (Deck *)createDeck; // abstract

- (void)updateUI;
- (NSAttributedString *)titleForCard:(Card *)card;
- (UIImage *)backgroundImageForCard:(Card *)card;

@end
