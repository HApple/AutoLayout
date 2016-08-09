//
//  DataManager.h
//  AutoLayout
//
//  Created by Jn.Huang on 16/8/8.
//  Copyright © 2016年 huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FDFeedEntity.h"

@interface DataManager : NSObject

@property (nonatomic, strong, readonly)NSArray<FDFeedEntity*> *entities;
@property (nonatomic, strong, readonly)NSArray<NSString*> *tagTexts;

+ (instancetype)shareManager;

@end
