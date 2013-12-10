//
//  SPTInfoPosicao.m
//  SPTransAPI
//
//  Created by Victor Gabriel Maraccini on 12/10/13.
//  Copyright (c) 2013 Victor Gabriel Maraccini. All rights reserved.
//

#import "SPTInfoPosicao.h"

#define acessivelKey @"a"
#define numeroKey @"p"
#define latKey @"px"
#define lngKey @"py"

@implementation SPTInfoPosicao

- (id) initWithDictionary:(NSDictionary *)info {
    
    self = [super init];
    
    if (self) {
        _timeStamp = [NSDate date];
        _numero = [[info objectForKey:numeroKey] integerValue];
        _acessivel = [[info objectForKey:acessivelKey] boolValue];
        
        float lat = [[info objectForKey:latKey] floatValue];
        float lng = [[info objectForKey:lngKey] floatValue];
        _local = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
        
    }
    
    if (_numero) {
        return self;
    }
    
    return nil;
    
}

@end
