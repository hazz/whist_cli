//
//  Player.h
//  Whist
//
//  Created by Harry Maclean on 14/04/2011.
//  Copyright 2011 City of London School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
@class Game;

@protocol PlayerDelegate
@optional
- (void)cardPlayed:(Card *)card byPlayer:(id)sender;
- (Card *)cardMustBePlayedByPlayer:(id)sender fromCards:(NSMutableArray *)cards;
@end

@interface Player : NSObject {
@private
	NSString * name;
    NSMutableArray * hand;
	NSMutableArray * tricks;
	Game <PlayerDelegate> *delegate;
}
- (void)lead;
- (void)playCard;
- (Card *)cardToPlay;
- (NSMutableArray *)cardsToPlay;
- (NSMutableArray *)cardsFromHandOfSuit:(NSString *)suit;
- (void)addCardToHand:(Card *)card;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSMutableArray * hand;
@property (nonatomic, retain) NSMutableArray * tricks;
@property (nonatomic, retain) id <PlayerDelegate> delegate;
@end
