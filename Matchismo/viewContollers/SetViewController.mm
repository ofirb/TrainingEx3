// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by Ofir Ben Yashar.

#import "SetViewController.h"
#import "SetDeck.h"
#import "SetCard.h"
#import "SetCardView.h"

@implementation SetViewController

- (Deck *)createDeck{
  return [[SetDeck alloc] init];
}

- (CardView *)createCardView{
  return [[SetCardView alloc] initWithFrame:CGRectZero];
}

- (UIColor *)colorOfCard:(SetCard *)card{
  if ([card.color isEqualToString:@"red"]) return [UIColor redColor];
  if ([card.color isEqualToString:@"purple"]) return [UIColor purpleColor];
  if ([card.color isEqualToString:@"green"]) return [UIColor greenColor];
  return [UIColor blackColor];
}

- (void)updateViewWithChosen:(CardView*)cardView card:(Card *)card {
  [super updateViewWithChosen:cardView card:card];
  cardView.alpha = card.chosen ? 0.7 : 1;
}

- (void)updateViewWithMatched:(CardView*)cardView card:(Card *)card{
  [super updateViewWithMatched:cardView card:card];
}

- (NSUInteger)gameStartCardNum{
  return kSetStartCardsNum;
}

- (BOOL)gameHasDeck {
  return YES;
}

@end
