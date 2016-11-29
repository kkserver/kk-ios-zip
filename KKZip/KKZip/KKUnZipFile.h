//
//  KKUnZipFile.h
//  KKZip
//
//  Created by zhanghailong on 2016/11/29.
//  Copyright © 2016年 kkserver.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKUnZipFile : NSObject

-(instancetype) initWithPath:(NSString *) path;

-(NSString *) next;

-(BOOL) openCurrent;

-(BOOL) openCurrentWithPassword:(NSString *) password;

-(int) readCurrent:(void *) data len:(unsigned) len;

-(void) closeCurrent;

-(void) close;

@end
