// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by Ofir Ben Yashar.


/// This class is Set game Card view represents the symbols according to the properties,
/// Symbols supported are the legacy ones, described below

#import "CardView.h"

@interface PlayingCardView : CardView
///The rank of card : [1-13]
@property (nonatomic) NSUInteger rank;
///The suit of the card: available values are: "♣","♠","♥","♦"
@property (strong, nonatomic) NSString *suit;
///Holds the card status up or down
@property (nonatomic) BOOL faceUp;

@end

