//
//  Console.h
//  SpellCorrector
//
//  Created by Jeremy Bringetto on 3/16/17.
//  Copyright © 2017 Jeremy Bringetto. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConsoleDelegate 

-(NSString*)receiveConsoleInput:(NSString*)input;

@end

@interface Console : NSObject

@property (weak) id <ConsoleDelegate> delegate;

-(void)getConsoleInput;
-(void)passInputToDelegate:(NSString*)input;
-(void)receiveSuggestion:(NSString *)suggestion;

@end
