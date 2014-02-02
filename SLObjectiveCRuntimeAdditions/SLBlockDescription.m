//
//  SLBlockDescription.m
//  SLBlockDescription
//
//  Created by Oliver Letterer on 01.09.12.
//  Copyright (c) 2012 olettere. All rights reserved.
//

#import "SLBlockDescription.h"
#import <Foundation/Foundation.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
NS_INLINE const char * remove_quoted_parts(const char *str){
    char *result = malloc(strlen(str) + 1);
    BOOL skip = NO;
    char *to = result;
    char c;
    while ((c = *str++)) {
        if ('"' == c) {
            skip = !skip;
            continue;
        }
        if (skip) continue;
        *to++ = c;
    }
    *to = '\0';
    return result;
}
#endif

@implementation SLBlockDescription

- (id)initWithBlock:(id)block
{
    if (self = [super init]) {
        _block = block;
        
        struct SLBlockLiteral *blockRef = (__bridge struct SLBlockLiteral *)block;
        _flags = blockRef->flags;
        _size = blockRef->descriptor->size;
        
        if (_flags & SLBlockDescriptionFlagsHasSignature) {
            void *signatureLocation = blockRef->descriptor;
            signatureLocation += sizeof(unsigned long int);
            signatureLocation += sizeof(unsigned long int);
            
            if (_flags & SLBlockDescriptionFlagsHasCopyDispose) {
                signatureLocation += sizeof(void(*)(void *dst, void *src));
                signatureLocation += sizeof(void (*)(void *src));
            }
            
            const char *signature = (*(const char **)signatureLocation);
            
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
            // NSMethodSignature on iOS 5 can not handle quoted class names
            signature = remove_quoted_parts(signature);
#endif
            
            _blockSignature = [NSMethodSignature signatureWithObjCTypes:signature];
        }
    }
    return self;
}

- (BOOL)blockSignatureIsCompatibleWithMethodSignature:(NSMethodSignature *)methodSignature
{
    if (_blockSignature.methodReturnType[0] != methodSignature.methodReturnType[0]) {
        return NO;
    }
    
	for (NSUInteger i = 2; i < methodSignature.numberOfArguments; i++) {
		if ([methodSignature getArgumentTypeAtIndex:i][0] != [_blockSignature getArgumentTypeAtIndex:i - 1][0]) {
			return NO;
        }
	}
    
    return YES;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@: %@", [super description], _blockSignature.description];
}

@end
