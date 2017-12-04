// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by Ofir Ben Yashar.

#import "PlayingCardView.h"
#import "PlayingCard.h"

@interface PlayingCardView()
@property (nonatomic) CGFloat faceCardScaleFactor;
@property (nonatomic) CGRect originalFrame;
@end

@implementation PlayingCardView

#pragma mark - Properties

#define kDefaultFaceCardScaleFactor 0.90

@synthesize faceCardScaleFactor = _faceCardScaleFactor;

- (CGFloat)faceCardScaleFactor {
  if (!_faceCardScaleFactor) _faceCardScaleFactor = kDefaultFaceCardScaleFactor;
  return _faceCardScaleFactor;
}

- (void)setSuit:(NSString *)suit {
  _suit = suit;
  [self setNeedsDisplay];
}

- (void)setRank:(NSUInteger)rank {
  _rank = rank;
  [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp {
  _faceUp = faceUp;
  [self setNeedsDisplay];
}

- (void)setValues:(Card *)card {
  if (![card isKindOfClass:[PlayingCard class]]) return;
  PlayingCard *playingCard = (PlayingCard *)card;
  [super setValues:card];
  _suit = playingCard.suit;
  _rank = playingCard.rank;
  [self setNeedsDisplay];
}

- (NSArray *) rankAsStrings {
  return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
  [self drawCardBorders];
  if (self.faceUp) {
    [self drawCardUpSide];
  } else {
    [self drawCardBackSide];
  }
}

-(void)drawCardUpSide{
  UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", [self rankAsStrings], self.suit]];
  if (faceImage) {
    [self drawCardImage:faceImage];
  } else {
    [self drawPips];
  }
  [self drawCorners];
}

-(void)drawCardImage:(UIImage *)image{
  CGRect imageRect = CGRectInset(self.bounds,
                                 self.bounds.size.width * (1.0 - self.faceCardScaleFactor),
                                 self.bounds.size.height * (1.0 - self.faceCardScaleFactor));
  [image drawInRect:imageRect];
}

#pragma mark - corners

- (void)drawCorners{
  [self drawUpCorner];
  [self drawDownCorner];
}

- (void)drawUpCorner {
  NSAttributedString *cornerText = [self cardCornerText];
  [cornerText drawInRect:[self cornerTextBounds:cornerText]];
}

-(void)drawDownCorner {
  NSAttributedString *cornerText = [self cardCornerText];
  [self pushContext];
  [self RotateUpsideDown];
  [cornerText drawInRect:[self cornerTextBounds:cornerText]];
  [self popContext];
}

- (NSAttributedString *)cardCornerText{
  NSMutableAttributedString *cornerText = [[NSMutableAttributedString alloc]
                                    initWithString:[NSString stringWithFormat:@"%@\n%@",[self rankAsStrings],self.suit]
                                    attributes: @{NSFontAttributeName : [self cardCornerFont],
                                                  NSParagraphStyleAttributeName : [self cardCornerAlignment]
                                                  } ];
  if ([self.suit isEqualToString:@"♥"] || [self.suit isEqualToString:@"♦"] ) {
    [cornerText addAttribute:NSForegroundColorAttributeName value:[UIColor redColor]range:(NSRange){0,cornerText.length}];
  }
  return cornerText;
}

- (UIFont *)cardCornerFont {
  UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  if ([self.suit isEqualToString:@"♥"]) {
    cornerFont = [cornerFont fontWithSize:[cornerFont pointSize] * 0.6];

  } else {
    cornerFont = [cornerFont fontWithSize:[cornerFont pointSize] * 0.5];
  }
   return cornerFont;
}

- (NSMutableParagraphStyle *)cardCornerAlignment{
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  paragraphStyle.alignment = NSTextAlignmentCenter;
  return paragraphStyle;
}

- (CGRect)cornerTextBounds:(NSAttributedString *)cornerText{
  CGRect textBounds;
  textBounds.origin = CGPointMake([self cornerOffset], [self cornerOffset]);
  textBounds.size = [cornerText size];
  return textBounds;
}

- (void)RotateUpsideDown {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
  CGContextRotateCTM(context, M_PI);
}

- (void)pushContext {
  CGContextSaveGState(UIGraphicsGetCurrentContext());
}

- (CGFloat)cornerOffset {
  return [self cornerRadius] / 3.0;
}

- (void)popContext {
  CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

- (void)drawCardBackSide {
  [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds];
}

#pragma mark - Pips

#define kPipHOffsetPercentage 0.165
#define kPipVOffset1Percentage 0.090
#define kPipVOffset2Percentage 0.175
#define kPipVOffset3Percentage 0.270

- (void)drawPips{
  if ((self.rank == 1) || (self.rank == 3) || (self.rank == 5) || (self.rank == 9)) {
    [self drawPipsWithHorizontalOffset:0
                        verticalOffset:0
                    mirroredVertically:NO];
  }
  if ((self.rank == 6) || (self.rank == 7) || (self.rank == 8)) {
    [self drawPipsWithHorizontalOffset:kPipHOffsetPercentage
                        verticalOffset:0
                    mirroredVertically:NO];
  }
  if ((self.rank == 2) || (self.rank == 3) || (self.rank == 7) || (self.rank == 8) || (self.rank == 10)) {
    [self drawPipsWithHorizontalOffset:0
                        verticalOffset:kPipVOffset2Percentage
                    mirroredVertically:(self.rank != 7)];
  }
  if ((self.rank == 4) || (self.rank == 5) || (self.rank == 6) || (self.rank == 7) ||
      (self.rank == 8) || (self.rank == 9) || (self.rank == 10)) {
    [self drawPipsWithHorizontalOffset:kPipHOffsetPercentage
                        verticalOffset:kPipVOffset3Percentage
                    mirroredVertically:YES];
  }
  if ((self.rank == 9) || (self.rank == 10)) {
    [self drawPipsWithHorizontalOffset:kPipHOffsetPercentage
                        verticalOffset:kPipVOffset1Percentage
                    mirroredVertically:YES];
  }
}

#define kPipFontScaleFactor 0.008

- (void)drawPipsWithHorizontalOffset:(CGFloat)hOffset
                      verticalOffset:(CGFloat)vOffset
                  mirroredVertically:(BOOL)mirroredVertically {
  [self drawPipsWithHorizontalOffset:hOffset verticalOffset:vOffset upsideDown:NO];
  if (mirroredVertically) {
    [self drawPipsWithHorizontalOffset:hOffset verticalOffset:vOffset upsideDown:YES];
  }
}

- (void)drawPipsWithHorizontalOffset:(CGFloat)hOffset
                      verticalOffset:(CGFloat)vOffset
                          upsideDown:(BOOL)upsideDown {
  if (upsideDown) {
    [self pushContext];
    [self RotateUpsideDown];
  }
  [self drawPipsWithHorizontalOffset:hOffset verticalOffset:vOffset];
  if (upsideDown) {
    [self popContext];
  }
}

- (void)drawPipsWithHorizontalOffset:(CGFloat)hOffset
                      verticalOffset:(CGFloat)vOffset {
  NSMutableAttributedString *attributedSuit = [[NSMutableAttributedString alloc] initWithString:self.suit
                                                                       attributes:@{ NSFontAttributeName : [self pipsFont]}];
  if ([self.suit isEqualToString:@"♥"] || [self.suit isEqualToString:@"♦"] ) {
    [attributedSuit addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:(NSRange){0,attributedSuit.length}];
  }
  CGPoint pipOrigin = [self pipOriginSize:[attributedSuit size] HorizontalOffset:hOffset verticalOffset:vOffset];
  [attributedSuit drawAtPoint:pipOrigin];
  if (hOffset) {
    pipOrigin.x += hOffset * 2.0 * self.bounds.size.width;
    [attributedSuit drawAtPoint:pipOrigin];
  }
}

- (UIFont *)pipsFont{
  UIFont *pipFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];

  if ([self.suit isEqualToString:@"♥"]) {
    pipFont = [pipFont fontWithSize:[pipFont pointSize] * self.bounds.size.width * kPipFontScaleFactor * 1.4];
  } else {
    pipFont = [pipFont fontWithSize:[pipFont pointSize] * self.bounds.size.width * kPipFontScaleFactor];
  }
  return pipFont;
}

- (CGPoint)pipOriginSize:(CGSize)pipSize
        HorizontalOffset:(CGFloat)hOffset
          verticalOffset:(CGFloat)vOffset {
  CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
  CGPoint pipOrigin =  CGPointMake(middle.x - pipSize.width/2.0 - hOffset*self.bounds.size.width,
                                   middle.y - pipSize.height/2.0 - vOffset*self.bounds.size.height);
  return pipOrigin;
}

@end

