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
//  ISNetwork.h
//  Isis
//
//  Created by fanbo on 15/9/4.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <UIKit/UIKit.h>

typedef void (^VoidBlock)(void);

extern NSString *const kISBaseURL;

@interface DayNetwork : NSObject
+ (DayNetwork *)network;


- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void) set401HandlerBlock:(VoidBlock)handler401;

- (void)uploadImage:(id)image
                key:(NSString*)key
              token:(NSString*)token
         uploadBase:(NSString*)uploadBase    
            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
