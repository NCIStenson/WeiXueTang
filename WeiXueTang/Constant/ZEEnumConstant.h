//
//  ZEEnumConstant.h
//  NewCentury
//
//  Created by Stenson on 16/1/20.
//  Copyright © 2016年  Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#ifndef ZEEnumConstant_h
#define ZEEnumConstant_h

typedef NS_ENUM (NSInteger,TEST_BODY_PART){
    TEST_BODY_PART_FACE,
    TEST_BODY_PART_NOSE
};

typedef NS_ENUM (NSInteger,DIANZAN_TYPE){
    DIANZAN_TYPE_DONE,//已点赞
    DIANZAN_TYPE_DOING,//评估中
    DIANZAN_TYPE_Master,//已掌握
    DIANZAN_TYPE_NO//未点赞
};

typedef NS_ENUM (NSInteger,EXPERTASSESSMENT_TYPE){
    EXPERTASSESSMENT_TYPE_DONE,//已评估
    EXPERTASSESSMENT_TYPE_NO//未评估
};

//进入课件列表 入口
typedef NS_ENUM (NSInteger,ENTER_FILELIST_TYPE){
    ENTER_FILELIST_TYPE_TOOLKIT,//工具包进入
    ENTER_FILELIST_TYPE_SELFSKILL//个人技能库进入
};

#endif /* ZEEnumConstant_h */
