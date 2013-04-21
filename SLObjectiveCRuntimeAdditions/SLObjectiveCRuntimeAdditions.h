//
//  SLObjectiveCRuntimeAdditions.h
//  SLObjectiveCRuntimeAdditions
//
//  Created by Oliver Letterer on 28.04.12.
//  Copyright (c) 2012 ebf. All rights reserved.
//

#import <objc/runtime.h>

typedef void(^SLMethodEnumertor)(Class class, Method method);
typedef BOOL(^SLClassTest)(Class subclass);

/**
 @abstract Swizzles originalSelector with newSelector.
 */
void class_swizzleSelector(Class class, SEL originalSelector, SEL newSelector);

/**
 @abstract Swizzles all methods of a class with a given prefix with the corresponding SEL without the prefix. @selector(__hookedLoadView) will be swizzled with @selector(loadView). This method also swizzles class methods with a given prefix.
 */
void class_swizzlesMethodsWithPrefix(Class class, NSString *prefix);

/**
 @abstract Enumerate class methods.
 */
void class_enumerateMethodList(Class class, SLMethodEnumertor enumerator);

/**
 @return A subclass of class which passes test.
 */
Class class_subclassPassingTest(Class class, SLClassTest test);

/**
 @abstract Replaces implementation of method of originalSelector with block.
           if originalSelector's argument list is (id self, SEL _cmd, ...), then block's argument list must be (id self, ...)
 */
IMP class_replaceMethodWithBlock(Class class, SEL originalSelector, id block);

/**
 Implements class property at runtime which is backed by NSUserDefaults. This will use -[NSUserDefaults setObject:forKey:].
 */
void class_implementPropertyInUserDefaults(Class class, NSString *propertyName, BOOL automaticSynchronizeUserDefaults);

/**
 Implements a property at runtime.
 */
void class_implementProperty(Class class, NSString *propertyName);

/**
 Adds a new method to `object` for `selector` to a new subclass introduced at runtime.
 
 Sample if object response to `- (NSString *)sayHello;`:

object_interposeBlockImplementation(object, @selector(sayHello), ^NSString *(id _self) {
    struct objc_super super = {
        _self,
        [_self class]
    };
    
    NSString *original = objc_msgSendSuper(&super, @selector(sayHello));
    return [original stringByAppendingString:@" Wuff"];
});
 
 @warning: This does not work with some base Foundation classes like __NSCFString.
  */
void object_interposeBlockImplementation(id object, SEL selector, id block);
