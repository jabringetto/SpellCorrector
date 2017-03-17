//
//  MyDictionary.m
//  SpellCorrector
//
//  Created by Jeremy Bringetto on 3/16/17.
//  Copyright © 2017 Jeremy Bringetto. All rights reserved.
//

#import "MyDictionary.h"

@interface MyDictionary()

@property (nonatomic) NSArray *words;

@end

@implementation MyDictionary

-(void)loadTheWords
{
    _wordsByPrefix = [[NSMutableDictionary alloc]init];
    NSString *path = @"/usr/share/dict/words";
    NSError* error = nil;
    NSString* s = [NSString stringWithContentsOfFile:path
                                            encoding:NSUTF8StringEncoding
                                               error:&error];
    _words = [s componentsSeparatedByString:@"\n"];
    
    for (NSString *word in _words)
    {
        NSString *prefix = @"";
        
        if(word.length == 1)
        {
            prefix = [word substringToIndex:1];
        }
        else if (word.length > 1)
        {
             prefix = [word substringToIndex:2];
        }
        prefix = [prefix lowercaseString];
        if(_wordsByPrefix[prefix])
        {
            NSMutableArray *m = _wordsByPrefix[prefix];
            NSMutableDictionary *d = [[NSMutableDictionary alloc]init];
            NSNumber *score = [NSNumber numberWithInteger:[self scoreAWord:word]];
            [d setObject:[word lowercaseString] forKey:@"word"];
            [d setObject:score forKey:@"score"];
            [m addObject:d];
            [_wordsByPrefix setObject:m forKey:prefix];
        }
        else
        {
            NSMutableArray *m = [[NSMutableArray alloc]init];
            NSMutableDictionary *d = [[NSMutableDictionary alloc]init];
            NSNumber *score = [NSNumber numberWithInteger:[self scoreAWord:word]];
            [d setObject:word forKey:@"word"];
            [d setObject:score forKey:@"score"];
            [m addObject:d];
            [_wordsByPrefix setObject:m forKey:prefix];
        
        }
        
    }
    
}
-(NSInteger)scoreAWord:(NSString*)word
{
    NSInteger score = 0;
    NSArray *chars = [self arrayOfCharacters:word];
    for (NSString *s in chars)
    {
        NSInteger d = [self scoreALetter:s];
        score += d;
    }
    return score;
    
}
-(NSInteger)scoreALetter:(NSString*)letter
{
    NSInteger score = 0;
    NSString *lowerCase = [letter lowercaseString];
    
    if([lowerCase isEqualToString:@"a"])
    {
        score = 1;
    }
    else if ([lowerCase isEqualToString:@"b"])
    {
        score = 2;
    }
    else if ([lowerCase isEqualToString:@"c"])
    {
        score = 3;
    }
    else if ([lowerCase isEqualToString:@"d"])
    {
        score = 4;
    }
    else if ([lowerCase isEqualToString:@"e"])
    {
        score = 5;
    }
    else if ([lowerCase isEqualToString:@"f"])
    {
        score = 6;
    }
    else if ([lowerCase isEqualToString:@"g"])
    {
        score = 7;
    }
    else if ([lowerCase isEqualToString:@"h"])
    {
        score = 8;
    }
    else if ([lowerCase isEqualToString:@"i"])
    {
        score = 9;
    }
    else if ([lowerCase isEqualToString:@"j"])
    {
        score = 10;
    }
    else if ([lowerCase isEqualToString:@"k"])
    {
        score = 11;
    }
    else if ([lowerCase isEqualToString:@"l"])
    {
        score = 12;
    }
    else if ([lowerCase isEqualToString:@"m"])
    {
        score = 13;
    }
    else if ([lowerCase isEqualToString:@"n"])
    {
        score = 14;
    }
    else if ([lowerCase isEqualToString:@"o"])
    {
        score = 15;
    }
    else if ([lowerCase isEqualToString:@"p"])
    {
        score = 16;
    }
    else if ([lowerCase isEqualToString:@"q"])
    {
        score = 17;
    }
    else if ([lowerCase isEqualToString:@"r"])
    {
        score = 18;
    }
    else if ([lowerCase isEqualToString:@"s"])
    {
        score = 19;
    }
    else if ([lowerCase isEqualToString:@"t"])
    {
        score = 20;
    }
    else if ([lowerCase isEqualToString:@"u"])
    {
        score = 21;
    }
    else if ([lowerCase isEqualToString:@"v"])
    {
        score = 22;
    }
    else if ([lowerCase isEqualToString:@"w"])
    {
        score = 23;
    }
    else if ([lowerCase isEqualToString:@"x"])
    {
        score = 24;
    }
    else if ([lowerCase isEqualToString:@"y"])
    {
        score = 25;
    }
    else if ([lowerCase isEqualToString:@"z"])
    {
        score = 26;
    }
    
    return score;
    
}
-(NSArray *)arrayOfCharacters:(NSString*)word
{
    NSMutableArray *charArray = [NSMutableArray arrayWithCapacity:word.length];
    
    for (int i=0; i<word.length; i++)
    {
        NSString *charStr1 = [word substringWithRange:NSMakeRange(i, 1)];
        [charArray addObject:charStr1];
    }

    return [charArray copy];
    
}
-(NSArray *)suggestions
{
    NSMutableArray *suggestions = [[NSMutableArray alloc]init];
    
    
    
    
    return suggestions;
    
    
}


@end
