//
//  DetailInfoObject.h
//  CosenCloud
//
//  Created by CosenMac on 2015/9/7.
//  Copyright (c) 2015年 kidmac. All rights reserved.
//

#import "JSONModel.h"
@protocol DetailInfoObject
@end

@interface DetailInfoObject : JSONModel
@property (nonatomic) NSString *time_stamp;
@property (nonatomic) NSString *machine_name;
@property (nonatomic) NSString *machine_id;
@property (nonatomic) NSString *blade_name;
@property (nonatomic) NSString *standard_deviation;
@property (nonatomic) NSString *utillization;
@property (nonatomic) NSString *cutting_rate;
@property (nonatomic) NSString *accu_area;
@property (nonatomic) NSString *ambient_temp;
@property (nonatomic) NSString *hydraulic_oil_temp;
@property (nonatomic) NSString *coolant_water_temp;
@property (nonatomic) NSString *gearbox_temp;
@property (nonatomic) NSString *ph;
@property (nonatomic) NSString *main_mator_cur;
@property (nonatomic) NSString *coolant_mator_cur;
@property (nonatomic) NSString *hydraulic_motor_cur;
//alarm
@property (nonatomic) NSString *blade_health_h;
@property (nonatomic) NSString *blade_health_l;
@property (nonatomic) NSString *blade_health_alarm;
@property (nonatomic) NSString *blade_dev_h;
@property (nonatomic) NSString *blade_dev_l;
@property (nonatomic) NSString *blade_dev_alarm;
@property (nonatomic) NSString *main_mator_h;
@property (nonatomic) NSString *main_mator_l;
@property (nonatomic) NSString *main_mator_alarm;
@property (nonatomic) NSString *water_mator_h;
@property (nonatomic) NSString *water_mator_l;
@property (nonatomic) NSString *water_mator_alarm;
@property (nonatomic) NSString *oil_mator_h;
@property (nonatomic) NSString *oil_mator_l;
@property (nonatomic) NSString *oil_mator_alarm;
@property (nonatomic) NSString *water_h;
@property (nonatomic) NSString *water_l;
@property (nonatomic) NSString *water_alarm;
@property (nonatomic) NSString *temp_h;
@property (nonatomic) NSString *temp_l;
@property (nonatomic) NSString *temp_alarm;
@property (nonatomic) NSString *water_temp_h;
@property (nonatomic) NSString *water_temp_l;
@property (nonatomic) NSString *water__temp_alarm;
@property (nonatomic) NSString *oil_temp_h;
@property (nonatomic) NSString *oil_temp_l;
@property (nonatomic) NSString *oil_temp_alarm;
@property (nonatomic) NSString *gearbox_temp_h;
@property (nonatomic) NSString *gearbox_temp_l;
@property (nonatomic) NSString *gearbox_temp_alarm;
@property (nonatomic) NSString *ph_h;
@property (nonatomic) NSString *ph_l;
@property (nonatomic) NSString *ph_alarm;

@end
