//
//  SPTInfoParada.m
//  SPTransAPI
//
//  Created by Victor Gabriel Maraccini on 12/9/13.
//  Copyright (c) 2013 Victor Gabriel Maraccini. All rights reserved.
//

#import "SPTInfoParada.h"

#define codigoParadaKey @"CodigoParada"
#define enderecoKey @"Endereco"
#define latitudeKey @"Latitude"
#define longitudeKey @"Longitude"
#define nomeKey @"Nome"

@implementation SPTInfoParada

- (id) initWithDictionary: (NSDictionary *) info {
 
    self = [super init];
    
    if (self) {
        
        _codigoParada = [[info objectForKey:codigoParadaKey] integerValue];
        _endereco = [info objectForKey:enderecoKey];
        _nome = [info objectForKey:nomeKey];
        
        float lat = [[info objectForKey:latitudeKey] floatValue];
        float lng = [[info objectForKey:longitudeKey] floatValue];
        
        CLLocation *currLoc = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
        _local = currLoc;
        
    }
    
    return self;
    
}

- (id <MKAnnotation>) annotation {
    
    return nil;
    
}

@end
