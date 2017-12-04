//
//  ViewController.m
//  Matchismo
//
//  Created by Ofir Ben Yashar on 24/10/2017.
//  Copyright © 2017 Ofir Ben Yashar Corporations. All rights reserved.
//

#import "ViewController.h"
#import "CardMatchingGame.h"
#import "Grid.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) Grid *cardsGrid;
@property (strong, nonatomic) NSMutableArray *cardViews;
@property (nonatomic) NSUInteger currentDisplayedCards;
@property (weak, nonatomic) IBOutlet UIView *cardsArea;
@property (weak, nonatomic) IBOutlet UIView *deckView;
@property (strong, nonatomic) UIAttachmentBehavior *attachment;
@property (strong, nonatomic) UIDynamicAnimator *stackOfCardsAnimator;
@property (strong, nonatomic) CardView* stackLastCardView;
@property (nonatomic) BOOL cardsGathered;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
  [self updateUI:NO];
}

- (void)viewDidLayoutSubviews {
  [self updateGridAndPlaceCards];
  [super viewDidLayoutSubviews];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setup];
  [self setCards];
  [self updateUI:NO];
}

- (IBAction)tapCard:(UITapGestureRecognizer *)sender {
  if (self.cardsGathered) {
    [self stopGatherParty];
  } else {
    [self gameCardSelected:sender];
  }
  [self updateUI:YES];
}

- (IBAction)tapDeck:(UITapGestureRecognizer *)sender {
  if (!self.cardsGathered) {
    [self addCardsButtonTouched:sender];
  }
}

- (void)stopGatherParty{
  self.cardsGathered = FALSE;
  self.stackLastCardView = nil;
  [self.stackOfCardsAnimator removeAllBehaviors];
}

- (void)gameCardSelected:(UITapGestureRecognizer *)sender {
  NSInteger chosenButtonIndex = [self.cardViews indexOfObject:sender.view];
  [self.game touchCardAtIndex:chosenButtonIndex];
}

- (IBAction)addCardsButtonTouched:(id)sender {
  if ([self.game cardsInDeckNum] < 3) return;
  [self addCards:3];
  [self updateUI:NO];
}

- (IBAction)redealButton:(id)sender {
  [self.game resetGame];
  [self resetCards];
}

- (void)addCards:(NSUInteger)num{
  for (int i=0 ; i<num ; i++) {
    Card *card = [self.game addCard];
    if (!card) {
      NSLog(@"addCrards: null card returned form deck");
      return;
    }
    CardView *cardView = [self createCardView];
    cardView.frame = [self.view convertRect:self.deckView.frame toView:self.cardsArea];
    [cardView setValues:card];
    [self connectCardViewToMainView:cardView];
  }
}

- (void)connectCardViewToMainView:(CardView *)cardView{
  [self setCardViewGesture:cardView];
  [self.cardsArea addSubview:cardView];
  [self.cardViews addObject:cardView];
}

- (void)disconnectCardViewToMainView:(CardView *)cardView{
  [cardView removeFromSuperview];
}

- (void)setCardViewGesture:(CardView *)cardView{
  UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCard:)];
  [cardView addGestureRecognizer:tapRec];
}

- (void)resetCards{
  [self animateRedealCards];
}

- (void)setCards{
  [self addCards:[self gameStartCardNum]];
}

#define kRePositionCardsDuration 0.8
- (void)animateRedealCards {
  [UIView animateWithDuration:kRePositionCardsDuration
                        delay:0.0
                      options:UIViewAnimationOptionCurveEaseOut
                   animations:^{[self moveAllCardViewsToDeckFrame];}
                   completion:^(BOOL finished) {
                     if (finished) {
                       [self removeCards];
                       [self addCards:[self gameStartCardNum]];
                       [self updateUI:NO];
                     }
                   }];
}

- (void)moveAllCardViewsToDeckFrame{
  for (CardView* cardView in self.cardViews) {
    cardView.frame = [self.view convertRect:self.deckView.frame toView:self.cardsArea];
  }
}

- (void)removeCards {
  for (CardView* cardView in self.cardViews) {
    [self disconnectCardViewToMainView:cardView];
  }
  [self.cardViews removeAllObjects];
  self.currentDisplayedCards = 0;
}

- (void)updateUI:(BOOL)updateCardValues {
  if (updateCardValues) {
    [self updateCardViews];
  }
  if ([self isGridUpdateRequired]) {
    [self updateGridAndPlaceCards];
  }
  self.deckView.alpha = [self.game cardsInDeckNum] < 3 ? 0.5 : 1;
}
- (void)updateGridAndPlaceCards{
  [self changeGrid];
  [self placeCardViewsAccordingToGrid];
}

- (void)placeCardViewsAccordingToGrid {
  int gridIndex = 0;
  for (CardView* cardView in self.cardViews) {
    if ([cardView shouldAppear]) {
      [self setCardViewFrame:cardView gridINdex:gridIndex];
      gridIndex++;
    } else {
      [cardView removeFromSuperview];
    }
  }
}

- (void)setCardViewFrame:(CardView *)cardView gridINdex:(int)gridIndex {
  CGRect gridRect = [self.cardsGrid frameOfCellAtIndex:gridIndex];
  CGRect shrinkdGridRect = [self shrinkGridRect:gridRect];
  [self animateChangeFrame:shrinkdGridRect toCardView:cardView];

}

- (void)animateChangeFrame:(CGRect)shrinkdGridRect toCardView:(CardView *)cardView {
  [UIView animateWithDuration:kRePositionCardsDuration
                        delay:0.0
                      options: UIViewAnimationOptionCurveEaseIn
                   animations:^{ cardView.frame = shrinkdGridRect;}
                   completion:nil];
}

#define kShrinkScale 0.05
- (CGRect)shrinkGridRect:(CGRect)inputRect {
  CGFloat shrinkX = inputRect.origin.x + (kShrinkScale * inputRect.size.width);
  CGFloat shrinkY = inputRect.origin.y + (kShrinkScale * inputRect.size.height);
  CGFloat shrinkWidth  = inputRect.size.width  * (1 - 2 * kShrinkScale);
  CGFloat shrinkHeight = inputRect.size.height * (1 - 2 * kShrinkScale);
  CGRect shrinkedRect = CGRectMake(shrinkX, shrinkY, shrinkWidth, shrinkHeight);
  return shrinkedRect;
}

- (void)updateCardViews {
  for (CardView *cardView in self.cardViews) {
    NSInteger cardViewIndex = [self.cardViews indexOfObject:cardView];
    Card *card = [self.game cardAtIndex:cardViewIndex];
    [self updateViewWithMatched:cardView card:card];
    [self updateViewWithChosen:cardView card:card];
  }
}

- (BOOL)isGridUpdateRequired {
  NSUInteger gameActiveCards = [self cardsNumShouldBeDisplayed];
  if (self.currentDisplayedCards != gameActiveCards) {
    self.currentDisplayedCards = gameActiveCards;
    return YES;
  }
  return NO;
}

- (NSUInteger)cardsNumShouldBeDisplayed {
  return [self.game activeCardsNum];
}

#define kDefaultAspectRatio 0.65
#define kMinCellsNum 12

- (void)changeGrid {
  Grid *newGrid = [[Grid alloc] init];
  newGrid.size = self.cardsArea.bounds.size;
  newGrid.cellAspectRatio = kDefaultAspectRatio;
  newGrid.minimumNumberOfCells = MAX(self.currentDisplayedCards, kMinCellsNum);
  self.cardsGrid = newGrid;
  if (![self.cardsGrid inputsAreValid]) {
    NSLog(@"error grid input is not valid");
  }
}

- (void)updateViewWithChosen:(CardView*)cardView card:(Card *)card{
  cardView.chosen = card.chosen;
}

- (void)updateViewWithMatched:(CardView*)cardView card:(Card *)card{
  cardView.matched = card.matched;
}

- (void)setup {
  _game = [[CardMatchingGame alloc] initUsingDeck:[self createDeck]];
  _stackOfCardsAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.cardsArea];
  _cardViews = [[NSMutableArray alloc] init];
  if ([self gameHasDeck]) {
    UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDeck:)];
    [_deckView addGestureRecognizer:tapRec];
  } else {
    _deckView.alpha = 0;
  }
}

- (BOOL)gameHasDeck {
  return NO;
}

- (Deck *)createDeck{
  return nil;
}

- (CardView *)createCardView{
  return nil;
}

- (NSUInteger)gameStartCardNum{
  return 0;
}

- (BOOL)shouldUpdateGridOnCardTap{
  return YES;
}

#pragma mark - pile gestures

- (IBAction)pinchCards:(UIPinchGestureRecognizer *)sender {
  if ((sender.state == UIGestureRecognizerStateChanged) ||
      (sender.state == UIGestureRecognizerStateEnded)) {
  [self GatherCards];
  }
}

- (void)GatherCards {
  [self animateMovingAllCardsToCenterAndAttachThemWhenDone];
}

- (void)attachCardViewsToEachOther{
  CardView *prevCardView;
  for (CardView* cardView in self.cardViews) {
    if (![cardView shouldAppear]) continue;
    if (prevCardView) {
      [self attachPrevCardView:prevCardView toCardView:cardView];
    }
    prevCardView = cardView;
  }
}

- (void)animateMovingAllCardsToCenterAndAttachThemWhenDone{
  [UIView animateWithDuration:kRePositionCardsDuration
                        delay:0.0
                      options:UIViewAnimationOptionCurveEaseOut
                   animations:^{
                     for (CardView* cardView in self.cardViews) {
                       cardView.center = self.cardsArea.center;
                       self.stackLastCardView = cardView;
                     }
                   }
                   completion:^(BOOL finished) {
                     if (finished) {
                       [self attachCardViewsToEachOther];
                       self.cardsGathered = TRUE;
                     }
                   }];
}

- (void)attachPrevCardView:(CardView *)cardView toCardView:(CardView *)prevCardView {
  UIAttachmentBehavior *attachCards = [[UIAttachmentBehavior alloc] initWithItem:cardView attachedToItem:prevCardView];
  attachCards.length = 0.001;
  [self.stackOfCardsAnimator addBehavior:attachCards];
}

- (IBAction)panStackOfGatheredCards:(UIPanGestureRecognizer *)sender {
  if (!self.cardsGathered) return;
  CGPoint gesturePoint = [sender locationInView:self.cardsArea];
  if (sender.state == UIGestureRecognizerStateBegan) {
    [self attachStackToPoint:gesturePoint];
  } else if (sender.state == UIGestureRecognizerStateChanged) {
    self.attachment.anchorPoint = gesturePoint;
  } else if (sender.state == UIGestureRecognizerStateEnded) {
    [self.stackOfCardsAnimator removeBehavior:self.attachment];
  }
}

- (void)attachStackToPoint:(CGPoint)anchorPoint{
  self.attachment = [[UIAttachmentBehavior alloc] initWithItem:self.stackLastCardView attachedToAnchor:anchorPoint];
  [self.stackOfCardsAnimator addBehavior:self.attachment];
}


@end
