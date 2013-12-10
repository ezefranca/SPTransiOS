//
//  SPTManager.h
//  SPTransAPI
//
//  Created by Victor Gabriel Maraccini on 12/9/13.
//  Copyright (c) 2013 Victor Gabriel Maraccini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPTInfoLinha.h"
#import "SPTInfoParada.h"
#import "SPTInfoPosicao.h"
#import "AFNetworking.h"

#define token @"def7b9c543fce385290d018ebdf86f90e3289a1c94e2c408e27eac1b5ddc2a82"

@protocol SPTManagerDelegate <NSObject>

@optional
- (void) receiveBuscaLinhaResults: (NSArray *) result;
//- (void) receiveBuscaDetalhesResults: (id) result;
- (void) receiveBuscaParadasPorLinha: (id) result;
- (void) receiveBuscaPosicao: (id) result;

@end

@interface SPTManager : NSObject

@property (nonatomic, readonly) BOOL isLoggedIn;

@property (nonatomic, retain) id <SPTManagerDelegate> delegate;

- (void) login;
- (void) buscaLinha: (NSString *) umaLinha;
//- (void) buscaDetalhes: (NSInteger) codLinha; Currently facing problems (server side)
- (void) buscaParadasPorLinha: (NSInteger) codLinha;
- (void) buscaPosicao: (NSInteger) codLinha;

@end
