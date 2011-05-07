//
//  AppDelegate.h
//  whist_cli
//
//  Created by Harry Maclean on 07/05/2011.
//

#import <Foundation/Foundation.h>
#import "Game.h"


@interface AppDelegate : NSObject <GameDelegate> {
    Game *game;
}

- (NSString *)getUserChoice;

@end

@interface NSString (Util) {
@private
	
}
- (BOOL)containsString:(NSString *)string;
@end