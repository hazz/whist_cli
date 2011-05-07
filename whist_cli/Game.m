//
//  Game.m
//  Whist
//
//  Created by Harry Maclean on 14/04/2011.
//  Copyright 2011 City of London School. All rights reserved.
//

#import "Game.h"


@implementation Game
@synthesize delegate, players, trumpSuit, deck, topCard, rounds;

#pragma mark Lifecycle

- (id)init
{
    self = [super init];
    if (self) {
    }
    
    return self;
}

- (void)dealloc
{
	[table release];
	[bids release];
	for (Player * p in players) {
		[p release];
	}
    [super dealloc];
}

#pragma mark Game

- (Game *)initWith:(NSArray *)thePlayersNames {
	self = [super init];
	if (self) {
		table = [[NSMutableArray alloc] init];
		bids = [[NSMutableArray alloc] init];
		NSMutableArray * arr = [[NSMutableArray alloc] init];
		for (NSString * name in thePlayersNames) {
			Player * p = [[Player alloc] init];
			p.name = name;
			p.delegate = self;
			[arr addObject:p];
		}
		self.players = [arr copy];
		self.deck = [self newDeck];
	}
	return self;
}

- (void)play {
	NSLog(@"%i rounds", self.rounds);
	for (int i = rounds; i > 0; i--) {
		currentRound = i;
		self.deck = [self newDeck];
		[self shuffleDeck];
		[self deal:i startingWithPlayerAtIndex:0];
		trumpSuit = [[Card possibleSuits] objectAtIndex:arc4random()%4];
		NSLog(@"Trumps are %@", trumpSuit);
		[self startBidding];
		for (int p = 0; p < i; p++) {
			[self playTrick];
		}
		[self scores];
	}
}

- (void)startBidding {
	[bids removeAllObjects];
	for (int i = 0; i < [players count]-1; i++) {
		NSNumber *num = [NSNumber numberWithInt:[[players objectAtIndex:i] bidLast:NO]];
		[bids insertObject:num atIndex:i];
		[num release];
	}
	NSUInteger d = [players count]-1;
	[bids insertObject:[NSNumber numberWithInt:[[players objectAtIndex:d] bidLast:YES]] atIndex:d];
}

#pragma mark Deck

- (NSArray *)newDeck {
	NSMutableArray * arr = [[NSMutableArray alloc] init];
	NSArray * suits = [NSArray arrayWithObjects:@"Diamonds", @"Hearts", @"Clubs", @"Spades", nil];
	NSArray * numbers = [NSArray arrayWithObjects:@"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K", @"A", nil];
	for (NSString * s in suits) {
		for (NSString * n in numbers) {
			Card * c = [[Card alloc] initWithNumber:n andSuit:s];
			[arr addObject:c];
		}
	}
	return arr;
}

- (void)shuffleDeck {
	NSMutableArray * theDeck = [[NSMutableArray alloc] initWithArray:deck];
	for (int i = 0; i < [theDeck count]; i++) {
		[theDeck exchangeObjectAtIndex:i withObjectAtIndex:arc4random()%[theDeck count]];
	}
	deck = theDeck;
}

- (void)deal:(int)numberOfCards startingWithPlayerAtIndex:(int)index {
	for (int i = 1; i <= numberOfCards; i++) {
		for (Player * p in players) {
			Card * card = [deck objectAtIndex:0];
			card.owner = p;
			[p addCardToHand:card];
			[deck removeObjectAtIndex:0];
		}
	}
	for (Player * player in players) {
		NSLog(@"%@:", player.name);
		for (Card * c in player.hand) {
			NSLog(@"%@", [c description]);
		}
	}
}

#pragma mark Trick

- (void)playTrick {
	table = [[NSMutableArray alloc] init];
	[[players objectAtIndex:0] lead];
	for (int i = 1; i < [players count]; i++) {
		[[players objectAtIndex:i] playCard];
	}
	Player * winner = [self winnerOfTrick];
	[winner.tricks addObject:table];
	NSLog(@"%@ won the trick.", winner.name);
	[table release];
}

- (Player *)winnerOfTrick {
	// Get a list of the trumps played
	NSMutableArray * trumps = [table mutableCopy];
	for (Card * card in table) {
		if (![card.suit isEqualToString:trumpSuit]) {
			[trumps removeObject:card];
		}
	}
	// If any trumps were played, return the player of the highest one
	if ([trumps count] != 0) {
		Card * highestCard = [Card highestOfCards:trumps];
		return highestCard.owner;
		}
	// Get a list of cards played which followed suit
	trumps = [table mutableCopy];
	for (Card * card in table) {
		if (![card.suit isEqualToString:[self bottomCard].suit]) {
			[trumps removeObject:card];
		}
	}
	// Return the player of the highest card that followed suit
	Card * highestCard = [Card highestOfCards:trumps];
	return highestCard.owner;
}

#pragma mark PlayerDelegate

- (void)cardPlayed:(Card *)card byPlayer:(id)sender {
	[table addObject:card];
	self.topCard = card;
	NSLog(@"%@ played %@", [sender name], [card description]);
}

- (Card *)cardMustBePlayedByPlayer:(id)sender fromCards:(NSMutableArray *)cards {
	return [delegate player:(Player *)sender mustPlayACardFrom:cards];
}

- (int)playerMustBid:(id)sender lastBid:(BOOL)last {
	return [delegate player:(Player *)sender mustBidLast:last];
}

#pragma mark Misc

- (Card *)bottomCard {
	if (!table) {
		NSLog(@"no cards on the table");
		return nil;
	}
	return [table objectAtIndex:0];
}

- (void)scores {
	for (Player * p in players) {
		int tricks = [p.tricks count];
		int bid = p.bid;
		if (tricks == bid) {
			p.score += (10+tricks);
		}
		else if (tricks < bid) {
			p.score += tricks;
		}
		else if (tricks > bid) {
			p.score -= (tricks - bid);
		}
		NSLog(@"%@: %i", p.name, p.score);
	}
}

- (int)rem {
	int num = 0;
	for (NSNumber *n in bids) {
		num += [n intValue];
	}
	return currentRound - num;
}

@end
