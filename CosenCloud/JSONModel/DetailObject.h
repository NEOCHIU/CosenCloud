//
//  DetailObject.h
//  CosenCloud
//
//  Created by CosenMac on 2015/9/7.
//  Copyright (c) 2015年 kidmac. All rights reserved.
//

#import "JSONModel.h"
#import "DetailInfoObject.h"

@interface DetailObject : JSONModel
@property (nonatomic) NSString *machine;
@property (nonatomic) NSString *blad_id;
@property (nonatomic) NSString *blade_cv;
@property (nonatomic) NSString *machine_status;
@property (strong, nonatomic) NSArray<DetailInfoObject,ConvertOnDemand> *detail;
@end
