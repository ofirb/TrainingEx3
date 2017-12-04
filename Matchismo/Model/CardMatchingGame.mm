// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by Ofir Ben Yashar.


#import "CardMatchingGame.h"

@interface CardMatchingGame()

///
@property (nonatomic, readwrite) NSInteger score;

///
@property (nonatomic,strong, nullable) NSMutableArray *cards;
@property (nonatomic, strong) Deck *deck;
@end

@implementation CardMatchingGame

- (NSMutableArray *) cards{
  if (!_cards) _cards = [[NSMutableArray alloc] init];
  return _cards;
}

- (instancetype) initUsingDeck:(Deck *)deck {
  if (self = [super init]) {
    self.deck = deck;
    self.activeCardsNum = 0;
  }
  return self;
}

- (Card * _Nullable)cardAtIndex:(NSUInteger)index{
  return (index < self.cards.count) ? [self.cards objectAtIndex:index] : nil;
}

- (void)resetGame{
  self.score = 0;
  self.gameRuns = NO;
  self.activeCardsNum = 0;
  [self.cards removeAllObjects];
  [self.deck resetCards];
}

- (Card *)addCard{
  Card *card = [self.deck drawRandomCard];
  if (card) {
    [self.cards addObject:card];
    self.activeCardsNum++;
  } else {
    return nil;
  }
  return card;
}

- (void)removeCard{
  if (self.activeCardsNum == 0) NSLog(@"warning: trying to remove from 0 cards");
  self.activeCardsNum--;
}

static const int kMatchBonus = 4;
static const int kMissmatchPenalty = -2;
static const int kCostToChoose = -1;

- (void)touchCardAtIndex:(NSUInteger)index{
  self.gameRuns = YES;
  Card *card = [self cardAtIndex:index];
  if (card.matched) {
    return;
  }
  [self ChoseCard:card];
}

- (void)ChoseCard:(Card *)card{
  if (card.chosen) {
    card.chosen = NO;
    return;
  }
  int moveScore = kCostToChoose;
  NSArray *chosenOtherCards = [self chosenCards];
  if ([card shouldCheckMatch:[chosenOtherCards count]]) {
    int matchScore = [card scoreForMatchingWithCards:chosenOtherCards];
    moveScore = [self calcMoveScore:matchScore];
    [self setOtherCardsProperties:chosenOtherCards matchSuccess:(matchScore != 0)];
    if (matchScore) {
      card.matched = YES;
      [self removeCard];
    }
  }
  card.chosen = YES;
  self.score += moveScore;
}

- (int)calcMoveScore:(int)matchScore{
  if (matchScore) {
    return matchScore * kMatchBonus;
  } else {
    return kMissmatchPenalty;
  }
}

- (void)setOtherCardsProperties:(NSArray *)otherCards matchSuccess:(BOOL)matchSuccess {
  for (Card *matchedCard in otherCards) {
    matchedCard.matched = matchSuccess;
    [self removeCard];
    matchedCard.chosen = matchSuccess;
  }
}

-(NSArray *)chosenCards{
  NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
  for (Card* otherCard in self.cards) {
    if (otherCard.chosen && !otherCard.matched) {
      [chosenCards addObject:otherCard];
    }
  }
  return chosenCards;
}

- (NSUInteger)cardsInDeckNum {
  return [self.deck countCards];
}

@end
