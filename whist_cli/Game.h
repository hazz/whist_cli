//
//  Game.h
//  Whist
//
//  Created by Harry Maclean on 14/04/2011.
//  Copyright 2011 City of London School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
//@class Player;
#import "Card.h"

@protocol GameDelegate
@optional
- (Card *)player:(Player *)player mustPlayACardFrom:(NSMutableArray *)cards;
@end

@interface Game : NSObject <PlayerDelegate> {
@private
	id <GameDelegate> delegate;
	NSMutableArray * table;
	NSArray * players;
	NSMutableArray * deck;
	NSString * trumpSuit;
	int rounds;
}

- (NSMutableArray *)newDeck;
- (void)deal:(int)numberOfCards startingWithPlayerAtIndex:(int)index;
- (Game *)initWith:(NSArray *)thePlayersNames;
- (void)shuffleDeck;
- (void)playTrick;
- (Player *)winnerOfTrick;
- (void)play;
- (Card *)bottomCard;

- (void)scores;

@property (nonatomic, retain) id <GameDelegate> delegate;
@property (nonatomic, retain) NSArray * players;
@property (nonatomic, retain) NSString * trumpSuit;
@property (nonatomic, retain) NSMutableArray * deck;
@property (nonatomic, retain) Card * topCard;
@property int rounds;
@end
