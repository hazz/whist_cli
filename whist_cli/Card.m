//
//  Card.m
//  Whist
//
//  Created by Harry Maclean on 14/04/2011.
//  Copyright 2011 City of London School. All rights reserved.
//

#import "Card.h"


@implementation Card
@synthesize number, suit, owner;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (Card *)initWithNumber:(NSString *)aNumber andSuit:(NSString *)aSuit {
	self = [super init];
	if (self) {
		if (![[Card possibleNumbers] containsObject:aNumber]) {
			NSLog(@"Number is invalid.");
			return nil;
		}
		if (![[Card possibleSuits] containsObject:aSuit]) {
			NSLog(@"Suit is invalid.");
			return nil;
		}
		self.suit = aSuit;
		self.number = aNumber;
		return self;
	}
}

- (BOOL)isGreaterThan:(Card *)comparison {
	if ([self numberIntValue] > [comparison numberIntValue]) {
		return TRUE;
	}
	return FALSE;
}

- (int)numberIntValue {
	if ([self.number isEqualToString:@"A"]) {
		return 14;
	}
	if ([self.number isEqualToString:@"K"]) {
		return 13;
	}
	if ([self.number isEqualToString:@"Q"]) {
		return 12;
	}
	if ([self.number isEqualToString:@"J"]) {
		return 11;
	}
	return [self.number intValue];
}

- (NSString *)description {
	return [NSString stringWithFormat:@"%@ of %@", [NSNumber numberWithInt:[self numberIntValue]], self.suit];
}

+ (NSArray *)possibleNumbers {
	NSMutableArray * arr = [[NSMutableArray alloc] init];
	for (int i = 2; i < 11; i++) {
		NSString * num = [NSString stringWithFormat:@"%i", i];
		[arr addObject:num];
	}
	[arr addObject:@"K"];
	[arr addObject:@"Q"];
	[arr addObject:@"J"];
	[arr addObject:@"A"];
	return [arr copy];
}

+ (NSArray *)possibleSuits {
	return [NSArray arrayWithObjects:@"Diamonds", @"Hearts", @"Clubs", @"Spades", nil];
}

+ (Card *)highestOfCards:(NSMutableArray *)cards {
	Card * highestCard = [cards objectAtIndex:0];
	for (int i = 1; i < [cards count]; i++) {
		if ([[cards objectAtIndex:i] isGreaterThan:highestCard]) {
			highestCard = [cards objectAtIndex:i];
		}
	}
	return highestCard;
}

- (void)dealloc
{
    [super dealloc];
}

@end
