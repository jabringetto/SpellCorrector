//
//  SpellChecker.h
//  SpellCorrector
//
//  Created by Jeremy Bringetto on 3/16/17.
//  Copyright © 2017 Jeremy Bringetto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Console.h"


@interface SpellChecker : NSObject <ConsoleDelegate>

-(void)launchTheConsole;
-(NSString*)receiveConsoleInput:(NSString*)input;
@property (nonatomic) BOOL testMode;

@end
