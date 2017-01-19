//
//  ConnectionHandler.m
//  GoEuroTest
//
//  Created by Nagarro on 18/01/17.
//  Copyright © 2017 KV. All rights reserved.
//

#import "ConnectionHandler.h"
#import "Reachability.h"
#import "ProjectConstants.h"

@interface ConnectionHandler()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) Reachability *reachability;
@property (nonatomic, assign) BOOL connectionRequired;

@end

@implementation ConnectionHandler

- (instancetype)initWithURL:(NSURL *)url {
    
    if(self = [super init]) {
        
        self.url = url;
        self.reachability = [Reachability reachabilityForInternetConnection];
        [self.reachability startNotifier];
    }
    
    return self;
}

- (void)executeRequestOnSuccess:(OnSuccess)onSuccessBlock onFailure:(OnFailure)onFailureBlock {
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    [sessionConfig setHTTPAdditionalHeaders:@{@"Accept": kAccecptHeader}];
    
    sessionConfig.timeoutIntervalForRequest = kTimeOutInterval;
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    
    NSCachedURLResponse *response = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
    if ([self.reachability currentReachabilityStatus] == NotReachable) {
        
        onSuccessBlock([response data]);
    }
    else {
        
        self.session = [NSURLSession sharedSession];
        self.dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if (error) {
                
                onFailureBlock(response,data,error);
            }
            else {
                
                onSuccessBlock(data);
            }
        }];
    }
    
    [self.dataTask resume];
}

@end
