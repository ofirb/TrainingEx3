// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by Ofir Ben Yashar.

/// This is super class of Card View.
/// It includes logic of card rounded borders,
/// card background and other common setups.
///

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Card.h"

@interface CardView : UIView
///matched - holds card status if already matched
@property (nonatomic) BOOL matched;
///matched - holds card status if chosen at the moment
@property (nonatomic) BOOL chosen;
///This function is abstract and implemented in the subclasses set the card values to the correspond values in the view
- (void)setValues:(Card *)card;
///This function draw the Card Borders - outlined and rounded corners
- (void)drawCardBorders;
///This function returns the corner radius
- (CGFloat)cornerRadius;
///a virtual function that returns if this card should appear in game
/// by defualt returns true, if desired can be overloaded
- (BOOL)shouldAppear;
@end

