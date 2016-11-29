//
//  KKZipFile.h
//  KKZip
//
//  Created by zhanghailong on 2016/11/29.
//  Copyright © 2016年 kkserver.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKZipFile : NSObject

-(instancetype) initWithPath:(NSString *) path;

-(BOOL) createFile:(NSString *) path;

-(BOOL) closeFile;

-(int) write:(void *) data len:(unsigned) len;

-(void) close;

@end
