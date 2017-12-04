// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by Ofir Ben Yashar.

#import "DemoVC.h"
#import "PlayingCardView.h"
#import "SetCardView.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface DemoVC()
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;
@property (weak, nonatomic) IBOutlet SetCardView *setCardView1;
@property (weak, nonatomic) IBOutlet SetCardView *setCardView2;
@property (weak, nonatomic) IBOutlet SetCardView *setCardView3;

@property (strong, nonatomic) Deck *deck;
@end

@implementation DemoVC

- (IBAction)swipePlayingCard:(id)sender {
  if (!self.playingCardView.faceUp) [self drawRandomPlayingCard];
  self.playingCardView.faceUp = !self.playingCardView.faceUp;
}

- (void)drawRandomPlayingCard {
  Card *card = [self.deck drawRandomCard];
  if (![card isKindOfClass:[PlayingCard class]]) return;
  PlayingCard *playingCard = (PlayingCard *)card;
  self.playingCardView.rank = playingCard.rank;
  self.playingCardView.suit = playingCard.suit;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setup];
  [self.playingCardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.playingCardView action:@selector(pinch:)]];
  self.setCardView1.color = @"red";
  self.setCardView1.symbol = @"diamond";
  self.setCardView1.shade = @"striped";
  self.setCardView1.number = 1;
  self.setCardView2.color = @"purple";
  self.setCardView2.symbol = @"squiggle";
  self.setCardView2.shade = @"open";
  self.setCardView2.number = 2;
  self.setCardView3.color = @"green";
  self.setCardView3.symbol = @"oval";
  self.setCardView3.shade = @"solid";
  self.setCardView3.number = 3;
}

- (void)setup {
  _deck = [[PlayingCardDeck alloc] init];
}

@end


