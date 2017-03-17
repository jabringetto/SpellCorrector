//
//  SpellChecker.m
//  SpellCorrector
//
//  Created by Jeremy Bringetto on 3/16/17.
//  Copyright © 2017 Jeremy Bringetto. All rights reserved.
//

#import "SpellChecker.h"
#import "MyDictionary.h"


@interface SpellChecker()

@property (nonatomic) MyDictionary *d;
@property (nonatomic) Console *c;
@property (nonatomic) NSString *cleaned;

@end

@implementation SpellChecker

-(void)launchTheConsole
{
    _d = [[MyDictionary alloc]init];
    NSLog(@"L O A D I N G . . .");
    [_d loadTheWords];
    _c = [[Console alloc]init];
    _c.delegate = self;
    if(!_testMode)
    {
        [_c getConsoleInput];
    }
}
-(NSString*)receiveConsoleInput:(NSString*)input
{
    NSString *cap;
    NSString *dup;
    NSString *vow;
    NSString *suggestion;
    
    if(input && input.length > 0)
    {
        NSString *prefix = [self getPrefix:input];
        NSString *lower = [input lowercaseString];
        cap = [self capitalizationCorrection:prefix:input];
        dup = [self repeatedCharactersCorrection:prefix:lower];
        vow = [self incorrectVowellCorrection:prefix:_cleaned];
    }

    if(cap)
    {   
        suggestion = cap;
        if(!_testMode)
        {
            [_c receiveSuggestion:suggestion];
        }
        return suggestion;
    }
    if(dup)
    {
        suggestion = dup;
        if(!_testMode)
        {
            [_c receiveSuggestion:suggestion];
        }
        return suggestion;
    }
    if (vow)
    {
       
        suggestion = vow;
        if(!_testMode)
        {
            [_c receiveSuggestion:suggestion];
        }
        return suggestion;
    }
    if(!cap && !dup && !vow )
    {
        suggestion = @"NO SUGGESTION";
        if(!_testMode)
        {
             [_c receiveSuggestion:suggestion];
        }
    }
    return suggestion;
}
-(NSString*)capitalizationCorrection:(NSString*)prefix :(NSString*)input
{
    NSString *correctedString;
    NSArray *a = _d.wordsByPrefix[prefix];
    NSString *lower = [input lowercaseString];
    
    for (NSDictionary *d in a)
    {
        NSString *word = d[@"word"];
        
        if([word isEqualToString:lower])
        {
            correctedString = word;
        }
    }
    return correctedString;
}
-(NSString *)repeatedCharactersCorrection:(NSString*)prefix :(NSString*)input
{
    NSString *correctedString;
    
    NSArray *chars = [_d arrayOfCharacters:input];
    NSMutableString *m = [chars[0] mutableCopy];
    
    for (NSInteger j = 0; j < chars.count-1; j++)
    {
        NSString *jth = chars[j];
        NSString *jPlus = chars[j+1];
        if(![jth isEqualToString:jPlus])
        {
            [m appendString:jPlus];
        }
    }
    _cleaned = [m copy];
    
    
    prefix = [self getPrefix:_cleaned];
    NSArray *a = _d.wordsByPrefix[prefix];
    
    for (NSDictionary *d in a)
    {
        NSString *word = d[@"word"];
        
        if([word isEqualToString:_cleaned])
        {
            correctedString = word;
        }
    }
    
    return correctedString;
}
-(NSString*)incorrectVowellCorrection:(NSString*)prefix :(NSString*)input
{
    NSString *correctedString;
    NSMutableArray *allPerms = [[NSMutableArray alloc]init];
    NSArray *vowells = [self vowells];
    NSMutableArray *vowellIndices = [[NSMutableArray alloc]init];
    NSArray *chars = [_d arrayOfCharacters:input];
    for (NSInteger k = 0; k < chars.count; k++)
    {
        NSString *s = chars[k];
        if([vowells containsObject:s])
        {
            NSNumber *n = [NSNumber numberWithInteger:k];
            [vowellIndices addObject:n];
        }
    }
    if(vowellIndices.count > 0)
    {
        NSArray *a = [self vowellPermuations:input:[vowellIndices[0] integerValue]];  
        allPerms = [a mutableCopy];
        
        for (NSInteger i = 1; i < vowellIndices.count; i++)
        {
            NSInteger m = [vowellIndices[i] integerValue];
            NSArray *temp = [allPerms copy];
            allPerms = [[NSMutableArray alloc]init];
            for (NSString *z in temp)
            {
                NSArray *b = [self vowellPermuations:z:m]; 
                [allPerms addObjectsFromArray:b];
            }
        }
        for (NSString *perm in allPerms)
        {
            NSString *pre = [self getPrefix:perm];
            NSArray *a = _d.wordsByPrefix[pre];
            for (NSDictionary *d in a)
            {
                NSString *word = d[@"word"];
                
                if([word isEqualToString:perm])
                {
                    correctedString = perm;
                }
            }
            
        }
    }
    
    return correctedString;
}


-(NSString *)getPrefix:(NSString*)input
{
    NSString *prefix = @"";
    if(input.length == 1)
    {
        prefix = [input substringToIndex:1];
    }
    else if (input.length > 1)
    {
        prefix = [input substringToIndex:2];
    }
    prefix = [prefix lowercaseString];
    return prefix;
}
-(NSArray *)vowellPermuations:(NSString*)word :(NSInteger)index
{
    NSMutableArray *perms = [[NSMutableArray alloc]init];
    NSMutableArray *chars = [[_d arrayOfCharacters:word]mutableCopy];
    
    NSArray *vowells = [self vowells];
    for (NSString *v in vowells)
    {
        [chars replaceObjectAtIndex:index withObject:v];
        NSString *s = [chars componentsJoinedByString:@""];
        [perms addObject:s];
    }

    return perms;
}
-(NSArray*)vowells
{
    NSMutableArray *m = [[NSMutableArray alloc]init];
    [m addObject:@"a"];
    [m addObject:@"e"];
    [m addObject:@"i"];
    [m addObject:@"o"];
    [m addObject:@"u"];
    return [m copy];
}



@end
