//
//  DataManager.m
//  AutoLayout
//
//  Created by Jn.Huang on 16/8/8.
//  Copyright © 2016年 huang. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static DataManager *dataManager = nil;
    dispatch_once(&onceToken, ^{
        dataManager = [[DataManager alloc] init];
    });
    return dataManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //为了演示方便直接拿https://github.com/forkingdog/UITableView-FDTemplateLayoutCell的演示数据
        
        // Data from `data.json`
        NSString *dataFilePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:dataFilePath];
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *feedDicts = rootDict[@"feed"];
        
        // Convert to `FDFeedEntity`
        NSMutableArray *entities = @[].mutableCopy;
        [feedDicts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [entities addObject:[[FDFeedEntity alloc] initWithDictionary:obj]];
        }];
        _entities = entities;
        
        
        
        //tag
        _tagTexts = @[@"张氏冷漠",@"我是1500米之王",@"七夕",@"东海南海同时出手",@"吴敏霞男朋友",@"张梦雪",@"中国再添一金",@"火锅",@"女排",@"里约奥运奖牌榜",@"中国观众",@"宁泽涛女朋友",@"这70个号码都是诈骗号",@"papi"];
        
    }
    return self;
}
@end
