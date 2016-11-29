//
//  KKZipFile.m
//  KKZip
//
//  Created by zhanghailong on 2016/11/29.
//  Copyright © 2016年 kkserver.cn. All rights reserved.
//

#import "KKZipFile.h"

#include "zip.h"

@interface KKZipFile() {
    zipFile _fd;
}

@end

@implementation KKZipFile

-(instancetype) initWithPath:(NSString *) path {
    
    zipFile fd = zipOpen([path UTF8String], APPEND_STATUS_CREATE);
    
    if(fd == NULL) {
        return nil;
    }
    
    if((self = [super init])) {
        _fd = fd;
    }
    
    return self;
}

-(void) dealloc {
    
    if(_fd ) {
        zipClose(_fd, nil);
    }
    
}

-(BOOL) createFile:(NSString *) path {
    
    if(_fd == nil) {
        return NO;
    }
    
    return zipOpenNewFileInZip(_fd, [path UTF8String], nil, nil, 0, nil, 0, nil, Z_DEFLATED, Z_DEFAULT_COMPRESSION) == Z_OK;
}

-(BOOL) closeFile {
    
    if(_fd == nil) {
        return NO;
    }
    
    return zipCloseFileInZip(_fd);
}

-(int) write:(void *) data len:(unsigned) len {
    
    if(_fd == nil) {
        return 0;
    }
    
    return zipWriteInFileInZip(_fd, data, len);
}

-(void) close {
    if(_fd ) {
        zipClose(_fd, nil);
        _fd = NULL;
    }
}


@end
