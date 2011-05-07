//
//  AppDelegate.m
//  whist_cli
//
//  Created by Harry Maclean on 07/05/2011.
//

#import "AppDelegate.h"


@implementation AppDelegate

- (id)init
{
    self = [super init];
    if (self) {
        game = [[Game alloc] initWith:[NSArray arrayWithObjects:@"paul", @"will", @"steven", nil]];
		game.delegate = self;
		game.rounds = 5;
		[game play];
    }
    
    return self;
}

- (void)dealloc
{
	[game release];
    [super dealloc];
}

- (Card *)player:(Player *)player mustPlayACardFrom:(NSMutableArray *)cards {
	NSLog(@"It is %@'s turn. The options are:", player.name);
	for (Card * card in cards) {
		NSLog(@"%@ %@", [card description], [card abbreviation]);
	}
	NSLog(@"Type the card abbreviation of the card you wish to play (e.g. 4H for the 4 of Hearts).");
	BOOL choiceMade = NO;
	while (!choiceMade) {
		NSString * choice = [[self getUserChoice] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
		for (Card * card in cards) {
			if ([[card abbreviation] isEqualToString:choice]) {
				choiceMade = YES;
				return card;
			}
		}
		NSLog(@"incorrect choice");
	}
}

- (NSString *)getUserChoice {
	NSFileHandle *input = [NSFileHandle fileHandleWithStandardInput];
	BOOL returned = NO;
	while (!returned) {
		NSData *data = [input availableData];
		if (data != nil) {
			NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
			if ([str containsString:@"\n"]) {
				return str;
				returned = YES;
			}
		}
	}
}

@end
				 
 @implementation NSString (Util)
 
 - (BOOL)containsString:(NSString *)string {
	 return ([self rangeOfString:string].location != NSNotFound);
 }
 
 @end
