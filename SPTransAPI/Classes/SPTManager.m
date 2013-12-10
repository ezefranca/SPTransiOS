//
//  SPTManager.m
//  SPTransAPI
//
//  Created by Victor Gabriel Maraccini on 12/9/13.
//  Copyright (c) 2013 Victor Gabriel Maraccini. All rights reserved.
//

#import "SPTManager.h"
#define absolutePathString @"http://api.olhovivo.sptrans.com.br/v0"
#define absoluteURL [NSURL URLWithString:absolutePathString]

AFHTTPRequestOperationManager *manager;

@implementation SPTManager

- (id) init {
    
    self = [super init];
    
    if (self) {
        
        NSURL *baseURL = [NSURL URLWithString:absolutePathString];
        manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
        _isLoggedIn = FALSE;
        
    }
    
    return self;

}

/*!Starts a login procedure with provided authentication token*/
- (void) login {

    //Create request to login
    NSMutableURLRequest *aReq = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/Login/Autenticar?token=%@",absolutePathString,token]]];
    [aReq setHTTPMethod:@"POST"];
    
    //Send over with AFNetworking
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:aReq];
    [op setResponseSerializer:[AFHTTPResponseSerializer serializer]];

    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if ([response rangeOfString:@"true"].location != NSNotFound) {
            _isLoggedIn = TRUE;
            NSLog(@"Logged in");
        } else {
            _isLoggedIn = FALSE;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _isLoggedIn = FALSE;
        
        NSLog(@"Request Failed: %@", [error description]);
    }];
    
    [[NSOperationQueue mainQueue] addOperation:op];
    
}

/*!Request to run a search for the content inside the string 'umaLinha' on the SPTrans database and returs possible matches to the delegate via the 'receiveBuscaLinhaResults' method*/
- (void) buscaLinha: (NSString *) umaLinha {
    
    NSURLRequest *aReq = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:[NSString stringWithFormat:@"%@/Linha/Buscar", absolutePathString] parameters:@{@"termosBusca":umaLinha}];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:aReq];
    [op setResponseSerializer:[AFJSONResponseSerializer serializer]];
    
    [op setCompletionBlockWithSuccess:
     ^(AFHTTPRequestOperation *operation, id responseObject) {
        
         //Parse response into Cocoa objects
         
         NSMutableArray *result;
         if ([responseObject isKindOfClass:[NSArray class]]) {
             //Got expected response
             for (NSDictionary *currDict in responseObject) {

                 SPTInfoLinha *currInfo = [[SPTInfoLinha alloc] initWithDictionary:currDict];
                 
                 if (currInfo) {
                     
                     if (!result) {
                         result = [[NSMutableArray alloc] init];
                     }
                     
                     [result addObject:currInfo];
                 }
                 
             }
             
         }
         
         //Push back to delegate, if supported
         if ([_delegate respondsToSelector:@selector(receiveBuscaLinhaResults:)]) {
             [_delegate receiveBuscaLinhaResults:result];
         }
         
        NSLog(@"BuscaLinha finished successfully");
        
    } failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
        [_delegate receiveBuscaLinhaResults:nil];
        NSLog(@"Error in BuscaLinha");
    }];
    
    [[NSOperationQueue mainQueue] addOperation:op];
    
}

/* Currently facing problems (server side)
- (void) buscaDetalhes: (NSInteger) codLinha {
    
    NSURLRequest *aReq = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:[NSString stringWithFormat:@"%@/Linha/CarregarDetalhes", absolutePathString] parameters:@{@"codigoLinha":[NSString stringWithFormat:@"%d", codLinha]}];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:aReq];
    [op setResponseSerializer:[AFJSONResponseSerializer serializer]];
    
    [op setCompletionBlockWithSuccess:
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         
         //Parse response into Cocoa objects
         
         NSMutableArray *result;
         if ([responseObject isKindOfClass:[NSArray class]]) {
             //Got expected response
             for (NSDictionary *currDict in responseObject) {
                 
                 SPTInfoLinha *currInfo = [[SPTInfoLinha alloc] initWithDictionary:currDict];
                 
                 if (currInfo) {
                     
                     if (!result) {
                         result = [[NSMutableArray alloc] init];
                     }
                     
                     [result addObject:currInfo];
                 }
                 
             }
             
         }
         
         //Push back to delegate, if supported
         if ([_delegate respondsToSelector:@selector(receiveBuscaLinhaResults:)]) {
             [_delegate receiveBuscaLinhaResults:result];
         }
         
         NSLog(@"buscaDetalhes finished successfully");
         
     } failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         [_delegate receiveBuscaLinhaResults:nil];
         NSLog(@"Error in buscaDetalhes");
     }];
    
    [[NSOperationQueue mainQueue] addOperation:op];
    
}
*/

/*!Requests stops positions for a provided codLinha and calls 'receiveBuscaParadasPorLinha' on the delegate once done*/
- (void) buscaParadasPorLinha: (NSInteger) codLinha {
    
    NSURLRequest *aReq = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:[NSString stringWithFormat:@"%@/Parada/BuscarParadasPorLinha", absolutePathString] parameters:@{@"codigoLinha":[NSString stringWithFormat:@"%d",codLinha]}];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:aReq];
    [op setResponseSerializer:[AFJSONResponseSerializer serializer]];
    
    [op setCompletionBlockWithSuccess:
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         
         //Parse response into Cocoa objects
         NSMutableArray *result;
         if ([responseObject isKindOfClass:[NSArray class]]) {
             //Got expected response
             for (NSDictionary *currDict in responseObject) {
                 
                 SPTInfoParada *currInfo = [[SPTInfoParada alloc] initWithDictionary:currDict];
                 
                 if (currInfo) {
                     
                     if (!result) {
                         result = [[NSMutableArray alloc] init];
                     }
                     
                     [result addObject:currInfo];
                 }
                 
             }
             
         }
         
         //Push back to delegate, if supported
         if ([_delegate respondsToSelector:@selector(receiveBuscaParadasPorLinha:)]) {
             [_delegate receiveBuscaParadasPorLinha:result];
         }
         
         NSLog(@"buscaParadasPorLinha finished successfully");
         
     } failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         [_delegate receiveBuscaLinhaResults:nil];
         NSLog(@"Error in buscaParadasPorLinha");
     }];
    
    [[NSOperationQueue mainQueue] addOperation:op];
    
}

/*!Requests bus positions for a provided codLinha and calls 'receiveBuscaPosicao' on the delegate once done*/
- (void) buscaPosicao: (NSInteger) codLinha {
    
    NSURLRequest *aReq = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:[NSString stringWithFormat:@"%@/Posicao", absolutePathString] parameters:@{@"codigoLinha":[NSString stringWithFormat:@"%d",codLinha]}];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:aReq];
    [op setResponseSerializer:[AFJSONResponseSerializer serializer]];
    
    [op setCompletionBlockWithSuccess:
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         
         //Parse response into Cocoa objects
         NSMutableArray *result;
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             NSDictionary *responseDict = (NSDictionary *) responseObject;
             
             //Look for an array
             NSArray *allKeys = [responseObject allKeys];
             for (int i = 0; i < [allKeys count]; i++) {
                 id currObj = [responseDict objectForKey:[allKeys objectAtIndex:i]];
                 
                 if ([currObj isKindOfClass:[NSArray class]]) {
                     //Try to parse bus location info here
                     NSArray *allInfo = (NSArray *) currObj;
                     
                     for (NSDictionary *currDict in allInfo) {
                         SPTInfoPosicao *currInfo = [[SPTInfoPosicao alloc] initWithDictionary:currDict];
                         
                         if (currInfo) {
                             
                             result = [[NSMutableArray alloc] init];
                             [result addObject:currInfo];
                             
                         }
                         
                     }
                     
                 }
                 
             }
             
             
             
         }
         
         //Push back to delegate, if supported
         if ([_delegate respondsToSelector:@selector(receiveBuscaPosicao:)]) {
             [_delegate receiveBuscaPosicao:result];
         }
         
         NSLog(@"buscaPosicao finished successfully");
         
     } failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         [_delegate receiveBuscaLinhaResults:nil];
         NSLog(@"Error in buscaPosicao");
     }];
    
    [[NSOperationQueue mainQueue] addOperation:op];
    
    
}

@end
