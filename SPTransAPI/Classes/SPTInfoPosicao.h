//
//  SPTInfoPosicao.h
//  SPTransAPI
//
//  Created by Victor Gabriel Maraccini on 12/10/13.
//  Copyright (c) 2013 Victor Gabriel Maraccini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface SPTInfoPosicao : NSObject

@property (nonatomic, retain) NSDate *timeStamp;
@property (nonatomic, readonly) NSInteger numero;
@property (nonatomic, readonly) BOOL acessivel;
@property (nonatomic, retain) CLLocation *local;

- (id) initWithDictionary: (NSDictionary *) info;

@end
