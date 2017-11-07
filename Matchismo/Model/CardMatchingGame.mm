// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by Ofir Ben Yashar.


#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic,strong) NSMutableArray *cards;
@property (nonatomic) NSUInteger cardsCount;
@property (nonatomic, strong) Deck *deck;
@end

@implementation CardMatchingGame

- (NSMutableArray *) cards{
  if (!_cards) _cards = [[NSMutableArray alloc] init];
  return _cards;
}

- (NSMutableArray *) movesDescriptorsHistory{
  if (!_movesDescriptorsHistory) _movesDescriptorsHistory = [[NSMutableArray alloc] init];
  return _movesDescriptorsHistory;
}

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
  if (self = [super init]) {
    self.deck = deck;
    self.cardsCount = count;
    if (![self fillCards]) return nil;
  }
  return self;
}

- (Card *)cardAtIndex:(NSUInteger)index{
  return (index < self.cards.count) ? [self.cards objectAtIndex:index] : nil;
}

- (void)resetGame{
  self.score = 0;
  self.gameRuns = NO;
  [self.cards removeAllObjects];
  [self.movesDescriptorsHistory removeAllObjects];
  [self.deck resetCards];
  [self fillCards];
}

- (BOOL)fillCards{
  if (!self.deck) return nil;
  for (int i=0; i< self.cardsCount; i++){
    Card *card = [self.deck drawRandomCard];
    if (card) {
      [self.cards addObject:card];
    } else {
      return NO;
    }
  }
  return YES;
}

static const int MATCH_BONUS = 4;
static const int MISMATCH_PENALTY = 2;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index{
  MoveDescriptor *desc = [[MoveDescriptor alloc] init];
  self.gameRuns = YES;
  int moveScore = 0;
  Card *card = [self cardAtIndex:index];
  if (!card) {
    NSLog(@"no card!!");
  }
  NSLog(@"card");
  NSLog(@"%@", card.description);
  if (card.matched) {
    NSLog(@"card matched - nothing to do");
    return;
  }
  if (card.chosen){
    card.chosen = NO;
    NSLog(@"card is chosen - unchose!!");
  } else {
    int chosenCardsNum = 0;
    NSMutableArray *chosenOtherCards;
    chosenOtherCards = [[NSMutableArray alloc] init];
    chosenCardsNum++; //this card
    for (Card* otherCard in self.cards) {
      if (otherCard.chosen && !otherCard.matched) {
        chosenCardsNum++;
        [chosenOtherCards addObject:otherCard];
        NSLog(@"%@", [@"card for match found & added" stringByAppendingString:otherCard.description] );
        NSLog(@"chosenCardsNum: %d",chosenCardsNum);
      }
    }
    if ([card checkMatch:chosenCardsNum]) {
      desc.matching = YES;
      NSLog(@"check match");
      int matchScore = [card match:chosenOtherCards];
      desc.success = (matchScore != 0);
      for (Card *matchedCard in chosenOtherCards) [desc.cards addObject:matchedCard];
      if (matchScore) {
        NSLog(@"score = %d", matchScore);
        moveScore += matchScore * MATCH_BONUS;
        for (Card *matchedCard in chosenOtherCards) {
          NSLog(@"%@", [@"mark as mtched card " stringByAppendingString:matchedCard.description]);
          matchedCard.matched = YES;
        }
        NSLog(@"mark mmy card as matched");
        card.matched = YES;
      } else {
        NSLog(@"match failed");
        moveScore -= MISMATCH_PENALTY;
        for  (Card *matchedCard in chosenOtherCards) {
          NSLog(@" mark as unchoosen %@",matchedCard.contexts);
          matchedCard.chosen = NO;
        }
      }
      desc.matchScore = moveScore;
    }
    [desc.cards addObject:card];
    NSLog(@"mark my card as choosen");
    card.chosen = YES;
    moveScore -= COST_TO_CHOOSE;
  }
  self.score += moveScore;
  [self.movesDescriptorsHistory addObject:desc];
}
@end


