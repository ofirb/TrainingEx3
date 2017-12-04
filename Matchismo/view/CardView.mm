// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by Ofir Ben Yashar.

#import "CardView.h"

@implementation CardView
#pragma mark - Drawing

#define kCornerFontStandardHeight 180.0
#define kCornerRadius 12.0

- (CGFloat) cornerScaleFactor {
  return self.bounds.size.height / kCornerFontStandardHeight;
}

- (CGFloat)cornerRadius {
  return kCornerRadius * [self cornerScaleFactor];
}

- (void)drawCardBorders{
  UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
  [roundedRect addClip];
  [[UIColor whiteColor] setFill];
  UIRectFill(self.bounds);
  [[UIColor blackColor] setStroke];
  [roundedRect stroke];
}

#pragma mark - Initialization

- (void)setup{
  self.backgroundColor = nil;
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib {
  [super awakeFromNib];
  [self setup];
}

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  [self setup];
  return self;
}

- (void)setValues:(Card *)card {
  self.matched = card.matched;
  self.chosen = card.chosen;
}

- (BOOL)shouldAppear {
  return YES;
}

- (CardView *)createCardView {
  return nil;
}


@end

