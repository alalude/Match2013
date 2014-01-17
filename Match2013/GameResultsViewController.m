//
//  GameResultsViewController.m
//  Match2013
//
//  Created by Akinbiyi Adesina Lalude on 12/4/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "GameResultsViewController.h"
#import "GameResult.h"

@interface GameResultsViewController ()

@property (weak, nonatomic) IBOutlet UITextView *scoresTextView;
@property (strong, nonatomic) NSArray *scores;

@end

@implementation GameResultsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.scores = [GameResult allGameResults];
    [self updateUI];
}

- (void)updateUI
{
    NSString *text = @"";
    
    // create strings from all game results
    for (GameResult *result in self.scores)
    {
        text = [text stringByAppendingString:[self stringFromResult:result]];
    }
    
    self.scoresTextView.text = text;
    
    // sort the game results using the helper method from the model and colorize the first and last result
    NSArray *sortedScores = [self.scores sortedArrayUsingSelector:@selector(compareScore:)];
    [self changeScore:[sortedScores firstObject] toColor:[UIColor redColor]];
    [self changeScore:[sortedScores lastObject] toColor:[UIColor greenColor]];
    
    sortedScores = [self.scores sortedArrayUsingSelector:@selector(compareDuration:)];
    [self changeScore:[sortedScores firstObject] toColor:[UIColor purpleColor]];
    [self changeScore:[sortedScores lastObject] toColor:[UIColor blueColor]];
}

- (NSString *)stringFromResult:(GameResult *)result
{
    return [NSString stringWithFormat:@"%@: %d, (%@, %gs)\n",
            result.gameType,
            result.score,
            [NSDateFormatter localizedStringFromDate:result.end
                                           dateStyle:NSDateFormatterShortStyle
                                           timeStyle:NSDateFormatterShortStyle],
            round(result.duration)];
}

- (void)changeScore:(GameResult *)result toColor:(UIColor *)color
{
    NSRange range = [self.scoresTextView.text rangeOfString:[self stringFromResult:result]];
    
    [self.scoresTextView.textStorage addAttribute:NSForegroundColorAttributeName
                                            value:color
                                            range:range];
}

- (IBAction)sortByDate:(UIButton *)sender
{
    self.scores = [self.scores sortedArrayUsingSelector:@selector(compareDate:)];
    [self updateUI];
}

- (IBAction)sortByScore:(UIButton *)sender
{
    self.scores = [self.scores sortedArrayUsingSelector:@selector(compareScore:)];
    [self updateUI];
}

- (IBAction)sortByDuration:(UIButton *)sender
{
    self.scores = [self.scores sortedArrayUsingSelector:@selector(compareDuration:)];
    [self updateUI];
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
