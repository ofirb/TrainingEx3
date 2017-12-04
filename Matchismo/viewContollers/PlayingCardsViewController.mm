// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by Ofir Ben Yashar.

#import "PlayingCardsViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCardView.h"
#import "PlayingCard.h"


@implementation PlayingCardsViewController

- (Deck *)createDeck{
  return [[PlayingCardDeck alloc] init];
}

- (CardView *)createCardView{
  return [[PlayingCardView alloc] initWithFrame:CGRectZero];
}

- (void)updateViewWithChosen:(CardView*)cardView card:(Card *)card {
  [super  updateViewWithChosen:cardView card:card];
  if (![cardView isKindOfClass:[PlayingCardView class]]) return;
  PlayingCardView *playingCardView = (PlayingCardView *)cardView;
  if (playingCardView.faceUp != playingCardView.chosen) {
    [self animateCardFaceFlip:playingCardView];
  }
}

#define kTimeForFlip 0.5

- (void)animateCardFaceFlip:(PlayingCardView *)view {
  [UIView transitionWithView:view duration:kTimeForFlip options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
    view.faceUp = view.chosen;
  } completion:{}];
}

- (void)updateViewWithMatched:(CardView*)cardView card:(Card *)card{
  [super updateViewWithMatched:cardView card:card];
  [cardView setUserInteractionEnabled:(!card.matched)];
  cardView.alpha = card.matched ? 0.7 : 1;
}

- (NSUInteger)gameStartCardNum{
  return kMatchPlayCardStartCardsNum;
}

- (NSUInteger)cardsNumShouldBeDisplayed {
  return [self gameStartCardNum];
}

@end

