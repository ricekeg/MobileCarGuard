//
//  AllCarStore.m
//  MobileCarGuard
//
//  Created by tyz on 15/7/21.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//

#import "AllCarStore.h" 

@import CoreData;

@interface AllCarStore ()

@property (nonatomic,strong) NSMutableArray *allIconTypes;
@property (nonatomic,strong) NSMutableArray *allLineTypes;

@property (nonatomic,strong) NSManagedObjectContext *context;
@property (nonatomic,strong) NSManagedObjectModel *model;

@end

@implementation AllCarStore

#pragma mark -初始化

+(instancetype)shareStore
{
    static AllCarStore *shareStore = nil;
    
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        shareStore = [[self alloc] initPrivate];
    });
    
    return shareStore;
    
}

-(instancetype)init
{
    return nil;
}

-(instancetype)initPrivate
{
    self = [super init];
    if(self)
    {
        //从sqlite路径加载
        
    }
    return self;
}

#pragma mark -加载所有icon类型

-(NSArray *)allIconType
{
    if(!_allIconTypes)
    {
        NSFetchRequest *request =[[NSFetchRequest alloc] init];
        NSEntityDescription *e =[NSEntityDescription entityForName:@"XHCarAnnotationIconType"
                                            inManagedObjectContext:self.context];
        request.entity = e;
        
        NSError *error = nil;
        NSArray *result =[self.context executeFetchRequest:request
                                                     error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed" format:@"Reason: %@",[error localizedDescription]];
        }
        _allIconTypes =[result mutableCopy];
        
    }
    
    if([_allIconTypes count]==0)
    {
        NSArray *iconTypeNames = [NSArray arrayWithObjects:
                                  /** 正常绿色带方向图标 */
                                  @"XHCarAnnotationIconTypeBlueDirect",
                                  /** 重车黄色带方向图标 */
                                  @"XHCarAnnotationIconTypeYelloDirect",
                                  /** 报警红色带方向图标 */
                                  @"XHCarAnnotationIconTypeRedDirect",
                                  /** 警报图标 */
                                  @"XHCarAnnotationIconTypeWarning",
                                  /** 带警告停车图标 */
                                  @"XHCarAnnotationIconTypeStopWarning",
                                  /** 正常停车图标 */
                                  @"XHCarAnnotationIconTypeStopNormal",
                                  /** 重车停车图标 */
                                  @"XHCarAnnotationIconTypeStopTranSport",
                                  /** 离线图标 */
                                  @"XHCarAnnotationIconTypeOffline",
                                  nil];
        NSManagedObject *type;
        for (NSString *iconTypeName in iconTypeNames) {
            type =[NSEntityDescription insertNewObjectForEntityForName:@"XHCarAnnotationIconType"
                                                inManagedObjectContext:self.context];
            [type setValue:iconTypeName forKey:@"label"];
            [_allIconTypes addObject:type];
        }
        
 
    }
    return _allIconTypes;
}


#pragma mark -加载所有轨迹line类型

-(NSArray *)allLineType
{
    if(!_allLineTypes)
    {
        NSFetchRequest *request =[[NSFetchRequest alloc] init];
        NSEntityDescription *e =[NSEntityDescription entityForName:@"XHCarAnnotationLineType"
                                            inManagedObjectContext:self.context];
        request.entity = e;
        
        NSError *error = nil;
        NSArray *result =[self.context executeFetchRequest:request
                                                     error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed" format:@"Reason: %@",[error localizedDescription]];
        }
        _allLineTypes =[result mutableCopy];
        
    }
    
    if([_allLineTypes count]==0)
    {
        NSArray *lineTypeNames = [NSArray arrayWithObjects:
                                  /** 默认蓝色轨迹 */
                                  @"XHCarAnnotationLineTypeBlue",
                                  /** 警报红色轨迹 */
                                  @"XHCarAnnotationLineTypeRed",
                                  /** 无轨迹 */
                                  @"XHCarAnnotationLineTypeNone",
                                  nil];
        NSManagedObject *type;
        for (NSString *lineTypeName in lineTypeNames) {
            type =[NSEntityDescription insertNewObjectForEntityForName:@"XHCarAnnotationLineType"
                                                inManagedObjectContext:self.context];
            [type setValue:lineTypeName forKey:@"label"];
            [_allLineTypes addObject:type];
        }
     
    }
    return _allLineTypes;
}


@end
