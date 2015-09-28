//
//  LoginObject.h
//  CosenCloud
//
//  Created by kid chiu on 2015/9/6.
//  Copyright (c) 2015年 kidmac. All rights reserved.
//

#import "JSONModel.h"

@interface LoginObject : JSONModel
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *pwd;
@end
