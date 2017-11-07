//
//  ViewController.m
//  Matchismo
//
//  Created by Ofir Ben Yashar on 24/10/2017.
//  Copyright © 2017 Ofir Ben Yashar Corporations. All rights reserved.
//

#import "MatchingGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"

@interface MatchingGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModer;
@property (strong , nonatomic) CardMatchingGame* game;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation MatchingGameViewController

- (CardMatchingGame *)game {
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
    return _game;
}
- (IBAction)gameModeSelected:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        [self.game setGameMode:TwoCardsMode];
    } else {
        [self.game setGameMode:ThreeCardsMode];
    }
    [self updateUI];
}

- (IBAction)redealButton:(id)sender {
    [self.game resetGame];
    [self updateUI];
}

- (Deck *)createDeck {
    return  [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}


- (void)updateUI{
    for (UIButton *cardButton in self.cardButtons) {
        NSInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.matched;
        self.scoreLabel.text = [NSString stringWithFormat:@"score: %ld", self.game.score];
        self.descriptionLabel.text = self.game.moveDescription;
    }
    _gameModer.enabled = !self.game.gameRuns;
}

- (NSString *)titleForCard:(Card *)card {
    return card.chosen ? card.contexts : @"";
}

-(UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.chosen? @"cardfront" : @"cardback"];
}

    
@end
