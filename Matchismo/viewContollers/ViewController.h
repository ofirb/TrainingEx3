//
//  ViewController.h
//  Matchismo
//
//  Created by Ofir Ben Yashar on 24/10/2017.
//  Copyright © 2017 Ofir Ben Yashar Corporations. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Deck.h"
#import "CardView.h"
#import "Card.h"

/// This is the main view controller of the card games,
/// it controlls the game
/// it allows start, redealing and start a new game
/// it updates the score view
/// it has few virtual functions that must be implemented through subclasses - see below

@interface ViewController : UIViewController

///virtual function - should be implemented in sub class -
/// init and return the specific cards deck
- (Deck *)createDeck;
///virtual function - should be implemented in sub class -
/// init and return the specific CardView
- (CardView *)createCardView;
///virtual function - should be implemented in sub class -
/// implements what should be done when Chosen field updated
/// recieved as argument both the view (for the updates(output)) and the card (for the values(input))
- (void)updateViewWithChosen:(CardView*)cardView card:(Card *)card;
///virtual function - should be implemented in sub class -
/// implements what should be done when Matched field updated
/// recieved as argument both the view (for the updates(output)) and the card (for the values(input))
- (void)updateViewWithMatched:(CardView*)cardView card:(Card *)card;

@end
