//
//  Player.m
//  Whist
//
//  Created by Harry Maclean on 18/04/2011.
//  Copyright 2011 City of London School. All rights reserved.
//

#import "Player.h"


@implementation Player
@synthesize name, hand, tricks, delegate;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
		hand = [[NSMutableArray alloc] init];
		tricks = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)lead {
	Card * card = [delegate cardMustBePlayedByPlayer:self fromCards:hand];
	[hand removeObject:card];
	[delegate cardPlayed:card byPlayer:self];
}
- (void)playCard {
	Card * card = [delegate cardMustBePlayedByPlayer:self fromCards:[self cardsToPlay]];
	[hand removeObject:card];
	[delegate cardPlayed:card byPlayer:self];
}

- (NSMutableArray *)cardsToPlay {
	NSMutableArray * cards = [self cardsFromHandOfSuit:[[delegate bottomCard] suit]];
	if ([cards count] != 0) {
		return cards;
	}
	cards = [self cardsFromHandOfSuit:[delegate trumpSuit]];
	if ([cards count] != 0) {
		return cards;
	}
	return self.hand;
}

- (Card *)cardToPlay {
	// Get cards from hand of led suit
	NSMutableArray * cards = [self cardsFromHandOfSuit:[[delegate bottomCard] suit]];
	// Return highest of the cards if there are any
	if ([cards count] != 0) {
		return [Card highestOfCards:cards];
	}
	// Get trumps
	cards = [self cardsFromHandOfSuit:[delegate trumpSuit]];
	// Return a random trump if there are any
	if ([cards count] != 0) {
		return [Card highestOfCards:cards];
	}
	// Return a random card
	return [hand objectAtIndex:0];
}

- (NSMutableArray *)cardsFromHandOfSuit:(NSString *)suit {
	NSMutableArray * cards = [hand mutableCopy];
	for (Card * c in hand) {
		if (![c.suit isEqualToString:suit]) {
			[cards removeObject:c];
		}
	}
	return cards;
}

- (void)addCardToHand:(Card *)card {
	[hand addObject:card];
}

- (void)dealloc
{
    [super dealloc];
}

@end
