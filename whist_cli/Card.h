//
//  Card.h
//  Whist
//
//  Created by Harry Maclean on 14/04/2011.
//  Copyright 2011 Harry Maclean. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Player;

@interface Card : NSObject {
@private
    NSString * number;
	NSString * suit;
	Player * owner;
}

- (Card *)initWithNumber:(NSString *)aNumber andSuit:(NSString *)aSuit;
+ (NSArray *)possibleNumbers;
+ (NSArray *)possibleSuits;
- (BOOL)isGreaterThan:(Card *)comparison;
- (int)numberIntValue;
- (NSString *)description;
- (NSString *)abbreviation;
+ (Card *)highestOfCards:(NSMutableArray *)cards;

@property (nonatomic, retain) NSString * number;
@property (nonatomic, retain) NSString * suit;
@property (nonatomic, retain) Player * owner;
@end
