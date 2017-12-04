// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by Ofir Ben Yashar.

#import "DeckView.h"

@interface DeckView()
@property (strong, nonatomic) UILabel *addCardsLabel;
@end

@implementation DeckView

- (void)drawRect:(CGRect)rect {
  [self drawCardBorders];
  [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds];
}

- (void)awakeFromNib{
  [super awakeFromNib];
}


@end

