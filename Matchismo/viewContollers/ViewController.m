//
//  ViewController.m
//  Matchismo
//
//  Created by Ofir Ben Yashar on 24/10/2017.
//  Copyright © 2017 Ofir Ben Yashar Corporations. All rights reserved.
//

#import "ViewController.h"
#import "CardMatchingGame.h"
#import "HistoryViewContoller.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong , nonatomic) CardMatchingGame* game;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation ViewController

- (CardMatchingGame *)game {
  if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                        usingDeck:[self createDeck]];
  return _game;
}

- (void)viewWillAppear:(BOOL)animated{
  [self updateUI];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"historyView"]) {
    if ([segue.destinationViewController isKindOfClass:[HistoryViewContoller class]]) {
      HistoryViewContoller *historyVC = (HistoryViewContoller *)segue.destinationViewController;
      historyVC.historyArray = [self makeHistoryArray];
    }
  }
}

- (Deck *)createDeck{
  return nil;
}

- (IBAction)redealButton:(id)sender {
  [self.game resetGame];
  [self updateUI];
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
    [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
    [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
    cardButton.alpha = [self alphaButtonForCard:card];
    cardButton.enabled = !card.matched;
  }
  self.scoreLabel.text = [NSString stringWithFormat:@"score: %ld", self.game.score];
  self.descriptionLabel.attributedText = [self moveDescriptorToString:[self.game.movesDescriptorsHistory lastObject]];
  
}

- (NSAttributedString *)moveDescriptorToString:(MoveDescriptor *) desc{
  NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:@""];
  NSMutableAttributedString *cardsString = [[NSMutableAttributedString alloc] initWithString:@""];
  NSMutableAttributedString *preString  = [[NSMutableAttributedString alloc] initWithString:@""];
  NSMutableAttributedString *postString  = [[NSMutableAttributedString alloc] initWithString:@""];
  for (Card *card in desc.cards) {
    [cardsString appendAttributedString: [self attributedContextOfCard:card]];
    [cardsString appendAttributedString: [[NSMutableAttributedString alloc] initWithString:@" "]];
  }
  if (desc.matching) {
    if (desc.success) {
      [preString appendAttributedString: [[NSMutableAttributedString alloc] initWithString:@"Matched "]];
      [postString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" for %ld points.", desc.matchScore]]];
    } else {
      [postString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" don't match! %ld points penalty!", desc.matchScore]]];
    }
  }
  [titleString appendAttributedString:preString];
  [titleString appendAttributedString:cardsString];
  [titleString appendAttributedString:postString];
  return titleString;
}

- (NSArray *)makeHistoryArray{
  NSMutableArray *historyStringArray = [[NSMutableArray alloc] init];
  for (MoveDescriptor *desc in self.game.movesDescriptorsHistory) {
    [historyStringArray addObject:[self moveDescriptorToString:desc]];
  }
  return historyStringArray;
}


- (CGFloat)alphaButtonForCard:(Card *)card {
  return 1;
}

- (NSAttributedString *)titleForCard:(Card *)card {
  return nil;
}

- (NSAttributedString *)attributedContextOfCard:(Card *)card {
  return nil;
}

- (NSAttributedString *)contextOfCard:(Card *)card {
  return nil;
}

-(UIImage *)backgroundImageForCard:(Card *)card {
  return nil;
}




@end
