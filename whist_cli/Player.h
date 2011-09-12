//
//  Player.h
//  Whist
//
//  Created by Harry Maclean on 14/04/2011.
//  Copyright 2011 Harry Maclean. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
@class Game;

@protocol PlayerDelegate
@optional
- (void)cardPlayed:(Card *)card byPlayer:(id)sender;
- (Card *)cardMustBePlayedByPlayer:(id)sender fromCards:(NSMutableArray *)cards;
- (int)playerMustBid:(id)sender lastBid:(BOOL)last;
@end

@interface Player : NSObject {
@private
	NSString * name;
    NSMutableArray * hand;
	NSMutableArray * tricks;
	int bid;
	int score;
	Game <PlayerDelegate> *delegate;
}
- (void)lead;
- (void)playCard;
- (int)bidLast:(BOOL)lastbid;
- (Card *)cardToPlay;
- (NSMutableArray *)cardsToPlay;
- (NSMutableArray *)cardsFromHandOfSuit:(NSString *)suit;
- (void)addCardToHand:(Card *)card;

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSMutableArray * hand;
@property (nonatomic, retain) NSMutableArray * tricks;
@property (nonatomic, assign) int bid;
@property (nonatomic, assign) int score;
@property (nonatomic, retain) id <PlayerDelegate> delegate;
@end
