/*******************************************************************************
* Copyright (C) 2016 Hangzhou Jiaheng Health Technology Co., Ltd.
* All rights reserved.
*  
* This file is part of Jia Heng GYM Project
*  
* Jia Heng GYM Project can not be copied and/or distributed without the express
* permission of Hangzhou Jiaheng Health Technology Co., Ltd.
* 
* www.jiahenghealth.com
*******************************************************************************/
//
//  ISNetwork.m
//  Isis
//
//  Created by fanbo on 15/9/4.
//
#import "DayNetwork.h"

NSString *const kISBaseURL = @"http://gymdev.jiahenghealth.com";


#ifdef DEBUG
// for debug mode
#ifndef DLog
#define DLog(f, ...) DLog(f, ##__VA_ARGS__)
#endif
#else
// for release mode
#ifndef DLog
#define DLog(f, ...) /* noop */
#endif
#endif


@interface DayNetwork ()
@property (strong, nonatomic) AFHTTPRequestOperationManager *manager;
@property (strong, nonatomic) VoidBlock handler401;
@end

@implementation DayNetwork
+ (DayNetwork *)network {
    static dispatch_once_t onceToken;
    static DayNetwork *network;
    dispatch_once(&onceToken, ^{
        network = [[DayNetwork alloc] init];
    });
    
    return network;
}

- (instancetype)init {
    if (self = [super init]) {
        self.manager = [AFHTTPRequestOperationManager manager];
        [self.manager.requestSerializer setTimeoutInterval:30];
        self.manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        self.manager.securityPolicy.allowInvalidCertificates = YES;
//        self.manager.responseSerializer.acceptableContentTypes = [self.manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
//        NSString *userAgent = [self.manager.requestSerializer  valueForHTTPHeaderField:@"User-Agent"];
//        userAgent = [userAgent stringByAppendingPathComponent:[NSString stringWithFormat:@" gid1"]];
//        [self.manager.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    }
    return self;
}

-(void) set401HandlerBlock:(VoidBlock)handler401{
    _handler401 = handler401;
}

#pragma mark - private
- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
//    return [self.manager GET:URLString parameters:parameters success:success failure:failure];
    return [self.manager GET:URLString parameters:parameters success:success failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"error");
        if (self.handler401 && [operation.responseObject[@"result"][@"status"] integerValue] == 401) {
            self.handler401();
        } else if (failure) {
                failure(operation, error);
        }
    }];
}


- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
//    return [self.manager POST:URLString parameters:parameters success:success failure:failure];
    return [self.manager POST:URLString parameters:parameters success:success failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"URI: %@, Param:%@, error, %@", URLString, parameters, error);
        if (self.handler401 && [operation.responseObject[@"result"][@"status"] integerValue] == 401) {
            self.handler401();
        } else if (failure) {
            failure(operation, error);
        }
    }];
}

- (void)uploadImage:(id)image
                key:(NSString*)key
              token:(NSString*)token
         uploadBase:(NSString*)uploadBase
            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    NSString *URLString = uploadBase;
    
    NSMutableURLRequest *request = [self.manager.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:URLString parameters:@{@"key":key, @"token":token}  constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"tmp.jpg" mimeType:@"image/jpeg"];
    } error:nil];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(operation, operation.responseString);
        }
    } failure:failure];
    [op start];
}


@end
