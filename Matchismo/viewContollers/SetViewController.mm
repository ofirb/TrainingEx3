// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by Ofir Ben Yashar.

#import "SetViewController.h"
#import "SetDeck.h"

@implementation SetViewController

- (Deck *)createDeck{
  return [[SetDeck alloc] init];
}

- (NSAttributedString *)titleForCard:(SetCard *)card {
  NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:card.symbols];
  UIColor *color = [self colorOfCard:card];
  NSRange range = NSMakeRange(0, [title length]);
  CGFloat alpha = 0;
  if ([card.shade isEqualToString:@"striped"]) alpha = 0.35;
  if ([card.shade isEqualToString:@"solid"]) alpha = 1;
  UIColor *transparentColor = [color colorWithAlphaComponent:alpha];
  [title setAttributes:@{NSForegroundColorAttributeName:  transparentColor,
                         NSStrokeWidthAttributeName: @-4,
                         NSStrokeColorAttributeName: color,
                         } range:range];
  return title;
}

- (NSAttributedString *)attributedContextOfCard:(Card *)card {
  return [self titleForCard:(SetCard *)card];
}

- (UIColor *)colorOfCard:(SetCard *)card{
  if ([card.color isEqualToString:@"red"]) return [UIColor redColor];
  if ([card.color isEqualToString:@"purple"]) return [UIColor purpleColor];
  if ([card.color isEqualToString:@"green"]) return [UIColor greenColor];
  return [UIColor blackColor];
}

- (CGFloat)alphaButtonForCard:(Card *)card {
  return card.chosen ? 0.7 : 1;
}

-(UIImage *)backgroundImageForCard:(Card *)card {
  return [UIImage imageNamed:@"cardfront"];
}

@end


