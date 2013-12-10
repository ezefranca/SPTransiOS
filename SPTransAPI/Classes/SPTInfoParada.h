//
//  SPTInfoParada.h
//  SPTransAPI
//
//  Created by Victor Gabriel Maraccini on 12/9/13.
//  Copyright (c) 2013 Victor Gabriel Maraccini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface SPTInfoParada : NSObject

@property (nonatomic, readonly) NSUInteger codigoParada;
@property (nonatomic, retain) NSString *nome;
@property (nonatomic, retain) NSString *endereco;
@property (nonatomic, retain) CLLocation *local;

- (id) initWithDictionary: (NSDictionary *) info;

- (id <MKAnnotation>) annotation;

@end
