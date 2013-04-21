//
//  SLObjcRuntimeAdditionsHiddenClass.m
//  iCuisineWaiter
//
//  Created by Oliver Letterer on 21.04.13.
//  Copyright 2013 SparrowLabs. All rights reserved.
//

#import "SLObjcRuntimeAdditionsWithoutARC.h"

#if __has_feature(objc_arc)
#error SLObjcRuntimeAdditionsHiddenClass does not support Objective-C Automatic Reference Counting (ARC)
#endif


Class object_interposeHiddenClass(id object)
{
    Class originalClass = object_getClass(object);
    
    NSString *(^newClassName)(void) = ^NSString *() {
        NSString *suffix = [[[NSUUID UUID] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
        
        return [NSStringFromClass(originalClass) stringByAppendingFormat:@"_%@", suffix];
    };
    
    NSString *newClassNameString = newClassName();
    while (NSClassFromString(newClassNameString)) {
        newClassNameString = newClassName();
    }
    
    Class newClass = objc_allocateClassPair(originalClass, newClassNameString.UTF8String, 0);
    objc_registerClassPair(newClass);
    NSCAssert(newClass != Nil, @"");
    
    IMP classImplementation = imp_implementationWithBlock(^Class(id _self) {
        return originalClass;
    });
    BOOL success = class_addMethod(newClass, @selector(class), classImplementation, "@@:");
    NSCAssert(success, @"");
    success = class_addMethod(objc_getMetaClass(newClassNameString.UTF8String), @selector(class), classImplementation, "@@:");
    NSCAssert(success, @"");
    
    IMP deallocImplementation = imp_implementationWithBlock(^(id _self) {
        struct objc_super super = {
            _self,
            [_self class]
        };
        
        objc_msgSendSuper(&super, @selector(dealloc));
        objc_disposeClassPair(newClass);
    });
    
    success = class_addMethod(newClass, @selector(dealloc), deallocImplementation, "v@:");
    NSCAssert(success, @"");
    
    object_setClass(object, newClass);
    
    return newClass;
}