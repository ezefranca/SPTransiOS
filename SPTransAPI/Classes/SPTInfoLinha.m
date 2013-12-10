//
//  SPTInfoLinha.m
//  SPTransAPI
//
//  Created by Victor Gabriel Maraccini on 12/9/13.
//  Copyright (c) 2013 Victor Gabriel Maraccini. All rights reserved.
//

#import "SPTInfoLinha.h"

@implementation SPTInfoLinha

#define circularKey @"Circular"
#define codLinhaKey @"CodigoLinha"
#define denominacaoPrincipalSecundarioKey @"DenominacaoTPTS"
#define denominacaoSecundarioPrincipalKey @"DenominacaoTSTP"
#define informacoesKey @"Informacoes"
#define letreiroKey @"Letreiro"
#define sentidoKey @"Sentido"
#define tipoKey @"Tipo"

- (id) initWithDictionary: (NSDictionary *) info {
    
    self = [super init];
    
    if (self) {
        
        _isCircular = [[info objectForKey:circularKey] boolValue];
        _codLinha = [[info objectForKey:codLinhaKey] integerValue];
        _denominacaoPrincipalSecundario = [info objectForKey:denominacaoPrincipalSecundarioKey];
        _denominacaoSecundarioPrincipal = [info objectForKey:denominacaoSecundarioPrincipalKey];
        _informacoes = [info objectForKey:informacoesKey];
        _letreiro = [info objectForKey:letreiroKey];
        _sentido = [[info objectForKey:sentidoKey] integerValue];
        _tipo = [[info objectForKey:sentidoKey] integerValue];
        
    }
    
    return self;
    
}

@end
