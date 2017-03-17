//
//  Console.m
//  SpellCorrector
//
//  Created by Jeremy Bringetto on 3/16/17.
//  Copyright © 2017 Jeremy Bringetto. All rights reserved.
//

#import "Console.h"



@implementation Console


-(void)getConsoleInput
{
    NSString *carrot = @"\n>";
    [carrot writeToFile:@"/dev/stdout" atomically:NO encoding:NSUTF8StringEncoding error:nil];
    NSFileHandle *keyboard = [NSFileHandle fileHandleWithStandardInput];
    NSData *data = [keyboard availableData];
    NSString* input = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    input = [self sanitizeConsoleInput:input];
    [self.delegate receiveConsoleInput:input];

}
-(NSString*)sanitizeConsoleInput:(NSString*)input
{
    NSString *s =input;
    s = [s stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]]; 
    s = [[s componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@" "];
    s = [s substringToIndex:s.length-1];
    
    return s;
}
-(void)receiveSuggestion:(NSString *)suggestion
{
     NSString *spc = @"\n>";
     [spc writeToFile:@"/dev/stdout" atomically:NO encoding:NSUTF8StringEncoding error:nil];
    [suggestion writeToFile:@"/dev/stdout" atomically:NO encoding:NSUTF8StringEncoding error:nil];
    
    NSString *spaces = @"\n\n";
     [spaces writeToFile:@"/dev/stdout" atomically:NO encoding:NSUTF8StringEncoding error:nil];
    [self getConsoleInput];
}
-(void)passInputToDelegate:(NSString*)input
{
     input = [self sanitizeConsoleInput:input];
     [self.delegate receiveConsoleInput:input];
}


@end
