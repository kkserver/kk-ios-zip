//
//  KKUnZipFile.m
//  KKZip
//
//  Created by zhanghailong on 2016/11/29.
//  Copyright © 2016年 kkserver.cn. All rights reserved.
//

#import "KKUnZipFile.h"

#include "unzip.h"

@interface KKUnZipFile() {
    unzFile _fd;
    int _fileno;
}

@end

@implementation KKUnZipFile

-(instancetype) initWithPath:(NSString *) path {
    
    unzFile fd = unzOpen([path UTF8String]);
    
    if(fd == NULL) {
        return nil;
    }
    
    if((self = [super init])) {
        _fd = fd;
        _fileno = 0;
    }
    
    return self;
}

-(void) dealloc {
    if(_fd != nil) {
        unzClose(_fd);
    }
}

-(NSString *) next {
    
    if(_fd == nil) {
        return nil;
    }
    
    if(_fileno < 0) {
        return nil;
    }
    
    int v = UNZ_OK;
    
    if(_fileno == 0) {
        v = unzGoToFirstFile(_fd);
    }
    else {
        v = unzGoToNextFile(_fd);
    }
    
    if( v != UNZ_OK) {
        _fileno = v;
        return nil;
    }
    
    unz_file_info info;
    char filename[2048];
    
    unzGetCurrentFileInfo(_fd, &info, filename, sizeof(filename) - 1, nil, 0, nil, 0);
    
    filename[info.size_filename] = 0;
    
    return [NSString stringWithCString:filename encoding:NSUTF8StringEncoding];
}

-(BOOL) openCurrent {
    
    if(_fd == nil) {
        return NO;
    }
    
    return unzOpenCurrentFile(_fd) == UNZ_OK;
}

-(BOOL) openCurrentWithPassword:(NSString *) password {
    
    if(_fd == nil) {
        return NO;
    }
    
    return unzOpenCurrentFilePassword(_fd, [password UTF8String]) == UNZ_OK;
}

-(int) readCurrent:(void *) data len:(unsigned) len {
    
    if(_fd == nil) {
        return 0;
    }
    
    return unzReadCurrentFile(_fd, data, len);
}

-(void) closeCurrent {
    unzCloseCurrentFile(_fd);
}

-(void) close {
    if(_fd != nil) {
        unzClose(_fd);
        _fd = nil;
    }
}

@end
