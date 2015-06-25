//
//  YelpClient.m
//  Yelp
//
//  Created by Chary Tu on 6/22/15.
//  Copyright (c) 2015 chary tu. All rights reserved.
//

#import "YelpClient.h"

@implementation YelpClient

- (id)initWithConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret accessToken:(NSString *)accessToken accessSecret:(NSString *)accessSecret {
    NSURL *baseURL = [NSURL URLWithString:@"http://api.yelp.com/v2/"];
    self = [super initWithBaseURL:baseURL consumerKey:consumerKey consumerSecret:consumerSecret];
    if (self) {   
        BDBOAuth1Credential *token = [BDBOAuth1Credential credentialWithToken:accessToken secret:accessSecret expiration:nil];
        [self.requestSerializer saveAccessToken:token];
    }
    return self;
}

- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term params:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
    NSDictionary *defaultsDict = @{@"term": term, @"ll" : @"37.774866,-122.394556"};
   // NSDictionary *defaults = @{@"term": term};
    NSMutableDictionary *allParameters = [defaultsDict mutableCopy];
    
    if (params) {
        [allParameters addEntriesFromDictionary:params];
    }
    NSLog(@"search all:%@", allParameters);
    return [self GET:@"search" parameters:allParameters success:success failure:failure];
}


@end
