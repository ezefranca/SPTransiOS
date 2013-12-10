//
//  SPTInfoLinha.h
//  SPTransAPI
//
//  Created by Victor Gabriel Maraccini on 12/9/13.
//  Copyright (c) 2013 Victor Gabriel Maraccini. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSUInteger SPTSentido;

enum SPTSentido {
    SentidoTPTS = 1,
    SentidoTSTP = 2
};

@interface SPTInfoLinha : NSObject

@property (nonatomic, readonly) BOOL isCircular;
@property (nonatomic, retain) NSString *letreiro;
@property (nonatomic, readonly) NSInteger codLinha;
@property (nonatomic, readonly) SPTSentido sentido;
@property (nonatomic, readonly) NSInteger tipo;
@property (nonatomic, retain) NSString *denominacaoPrincipalSecundario;
@property (nonatomic, retain) NSString *denominacaoSecundarioPrincipal;
@property (nonatomic, retain) NSString *informacoes;

- (id) initWithDictionary: (NSDictionary *) info;

@end
