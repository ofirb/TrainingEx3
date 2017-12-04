// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by Ofir Ben Yashar.

#import "SetCardView.h"
#import "SetCard.h"



@interface SetCardView()
@property (nonatomic) CGFloat faceCardScaleFactor;
@property (strong, nonatomic) UIBezierPath *Symbols;
@end

@implementation SetCardView

#pragma mark - Properties

#define kDefaultFaceCardScaleFactor 0.90

@synthesize faceCardScaleFactor = _faceCardScaleFactor;

- (CGFloat)faceCardScaleFactor {
  if (!_faceCardScaleFactor) _faceCardScaleFactor = kDefaultFaceCardScaleFactor;
  return _faceCardScaleFactor;
}

- (void)setNumber:(NSUInteger)number {
  _number = number;
  [self setNeedsDisplay];
}

- (void)setSymbol:(NSString *)symbol{
  _symbol = symbol;
  [self setNeedsDisplay];
}

- (void)setColor:(NSString *)color {
  _color = color;
  [self setNeedsDisplay];
}

- (void)setShade:(NSString *)shade {
  _shade = shade;
  [self setNeedsDisplay];
}

- (void)setValues:(Card *)card {
  if (![card isKindOfClass:[SetCard class]]) return;
  SetCard *playingCard = (SetCard *)card;
  [super setValues:card];
  _number = playingCard.number;
  _symbol = playingCard.symbol;
  _shade = playingCard.shade;
  _color = playingCard.color;
  [self setNeedsDisplay];
}


#pragma mark - Gesture Handling

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
  [self drawCardBorders];
  [self drawContent];
}

- (void)drawContent {
  self.Symbols = [[UIBezierPath alloc] init];
  [self drawSymbols];
  [self drawOutline];
  [self.Symbols stroke];
  [self drawShading];
}

#define kMiddleOfCardWidth       self.bounds.size.width  * 0.5
#define kMiddleOfCardHeight      self.bounds.size.height * 0.5
#define k2UpperRectCenterHeight  self.bounds.size.height * 0.37
#define k2DownerRectCenterHeight self.bounds.size.height * 0.63
#define k3UpperRectCenterHeight  self.bounds.size.height * 0.25
#define k3DownerRectCenterHeight self.bounds.size.height * 0.75
#define kRectHalfWidth  self.bounds.size.width   * 0.375
#define kRectHalfHeight self.bounds.size.height  * 0.09
#define kRectWidth  kRectHalfWidth  * 2
#define kRectHeight kRectHalfHeight * 2
#define kOriginX kMiddleOfCardWidth - kRectHalfWidth


- (void)drawSymbols{
  switch (self.number) {
    case 1:
      [self drawSymbolAround:(kMiddleOfCardHeight)];
      break;
    case 2:
      [self drawSymbolAround:(k2UpperRectCenterHeight)];
      [self drawSymbolAround:(k2DownerRectCenterHeight)];
      break;
    case 3:
      [self drawSymbolAround:(kMiddleOfCardHeight)];
      [self drawSymbolAround:(k3UpperRectCenterHeight)];
      [self drawSymbolAround:(k3DownerRectCenterHeight)];
      break;
    }
}

- (void)drawSymbolAround:(CGFloat)height  {
  if ([self.symbol isEqualToString:@"squiggle"]) {
    [self drawSquiggleAround:height];
  }
  if ([self.symbol isEqualToString:@"diamond"]) {
    [self drawDiamondAround:height];
  }
  if ([self.symbol isEqualToString:@"oval"]) {
    [self drawOvalAround:height];
  }
}

- (void)drawDiamondAround:(CGFloat)height {
  UIBezierPath *path = self.Symbols;
  [path moveToPoint:CGPointMake(kMiddleOfCardWidth, height - kRectHalfHeight)];
  [path addLineToPoint:CGPointMake(kMiddleOfCardWidth + kRectHalfWidth, height)];
  [path addLineToPoint:CGPointMake(kMiddleOfCardWidth, height + kRectHalfHeight)];
  [path addLineToPoint:CGPointMake(kMiddleOfCardWidth - kRectHalfWidth, height)];
  [path closePath];
}

- (void)drawSquiggleAround:(CGFloat)height {
  UIBezierPath *squiggle = self.Symbols;
  CGRect squiggleBounds = CGRectMake(kOriginX, height - kRectHalfHeight, kRectWidth, kRectHeight);
  CGFloat squigX = squiggleBounds.origin.x;
  CGFloat squigY = squiggleBounds.origin.y;
  CGFloat squigWidth = squiggleBounds.size.width;
  CGFloat squigHeight = squiggleBounds.size.height;
  [squiggle moveToPoint:CGPointMake(squigX + squigWidth*0.05, squigY + squigHeight*0.40)];
  [squiggle addCurveToPoint:CGPointMake(squigX + squigWidth*0.35, squigY + squigHeight*0.25)
          controlPoint1:CGPointMake(squigX + squigWidth*0.09, squigY + squigHeight*0.15)
          controlPoint2:CGPointMake(squigX + squigWidth*0.18, squigY + squigHeight*0.10)];
  [squiggle addCurveToPoint:CGPointMake(squigX + squigWidth*0.75, squigY + squigHeight*0.30)
          controlPoint1:CGPointMake(squigX + squigWidth*0.40, squigY + squigHeight*0.30)
          controlPoint2:CGPointMake(squigX + squigWidth*0.60, squigY + squigHeight*0.50)];
  [squiggle addCurveToPoint:CGPointMake(squigX + squigWidth*0.97, squigY + squigHeight*0.35)
          controlPoint1:CGPointMake(squigX + squigWidth*0.87, squigY + squigHeight*0.15)
          controlPoint2:CGPointMake(squigX + squigWidth*0.98, squigY + squigHeight*0.00)];
  [squiggle addCurveToPoint:CGPointMake(squigX + squigWidth*0.45, squigY + squigHeight*0.85)
          controlPoint1:CGPointMake(squigX + squigWidth*0.95, squigY + squigHeight*1.10)
          controlPoint2:CGPointMake(squigX + squigWidth*0.50, squigY + squigHeight*0.95)];
  [squiggle addCurveToPoint:CGPointMake(squigX + squigWidth*0.25, squigY + squigHeight*0.85)
          controlPoint1:CGPointMake(squigX + squigWidth*0.40, squigY + squigHeight*0.80)
          controlPoint2:CGPointMake(squigX + squigWidth*0.35, squigY + squigHeight*0.75)];
  [squiggle addCurveToPoint:CGPointMake(squigX + squigWidth*0.05, squigY + squigHeight*0.40)
          controlPoint1:CGPointMake(squigX + squigWidth*0.00, squigY + squigHeight*1.10)
          controlPoint2:CGPointMake(squigX + squigWidth*0.005, squigY + squigHeight*0.60)];
  [squiggle closePath];
}

#define kOvalRadius 15.0

- (void)drawOvalAround:(CGFloat)height {
  UIBezierPath *path = self.Symbols;
  CGRect rect = CGRectMake(kOriginX , height - kRectHalfHeight, kRectWidth, kRectHeight);
  UIBezierPath *oval = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:kOvalRadius];
  [path appendPath:oval];
}

- (void)drawOutline{
  [[self getUiColor] setStroke];
  self.Symbols.lineWidth = 2.0;
}

- (UIColor *)getUiColor{
  if ([self.color isEqualToString:@"red"]) {
    return [UIColor redColor];
  }
  if ([self.color isEqualToString:@"purple"]) {
    return [UIColor purpleColor];
  }
  if ([self.color isEqualToString:@"green"]) {
    return [UIColor greenColor];
  }
  return nil;
}

- (void)drawShading {
  if ([self.shade isEqualToString:@"solid"]) {
    [[self getUiColor] setFill];
    [self.Symbols fill];
  }
  if ([self.shade isEqualToString:@"striped"]) {
    [self doStriped];
  }
  if ([self.shade isEqualToString:@"open"]) {
  }
}

#define kDistanceBetweenStripes 3

- (void)doStriped {
  CGRect bounds = self.Symbols.bounds;
  UIBezierPath *stripes = [[UIBezierPath alloc] init];
  for (int i = 0; i < bounds.size.width*2; i += kDistanceBetweenStripes)  {
    [stripes moveToPoint:CGPointMake(bounds.origin.x + i, bounds.origin.y)];
    [stripes addLineToPoint:CGPointMake(bounds.origin.x + i - (kDistanceBetweenStripes*3), bounds.origin.y + bounds.size.height)];
  }
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  [self.Symbols addClip];
  [[self getUiColor] setStroke];
  [stripes stroke];
  CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

- (BOOL)shouldAppear {
  return !self.matched;
}

@end

