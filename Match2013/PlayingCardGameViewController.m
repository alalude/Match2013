//
//  PlayingCardGameViewController.m
//  Match2013
//
//  Created by Akinbiyi Adesina Lalude on 12/3/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
    // It would be best to set this property when initializing the view controller
    self.gameType = @"Playing Cards";
    
    return [[PlayingCardDeck alloc] init];
}

@end
