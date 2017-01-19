//
//  ConnectionHandler.h
//  GoEuroTest
//
//  Created by Nagarro on 18/01/17.
//  Copyright © 2017 KV. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^OnSuccess) (NSData *responseData);
typedef void (^OnFailure) (NSURLResponse *response, NSData *data, NSError *error);

@interface ConnectionHandler : NSObject

- (instancetype)initWithURL:(NSURL *)url;

- (void)executeRequestOnSuccess:(OnSuccess)onSuccessBlock onFailure:(OnFailure)onFailureBlock;

@end
