SLObjectiveCRuntimeAdditions [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
============================

SLObjectiveCRuntimeAdditions introduces the following new runtime additions:

* `void class_swizzleSelector(Class class, SEL originalSelector, SEL newSelector);`
* `void class_swizzlesMethodsWithPrefix(Class class, NSString *prefix);`
* `void class_enumerateMethodList(Class class, SLMethodEnumertor enumerator);`
* `Class class_subclassPassingTest(Class class, SLClassTest test);`
* `IMP class_replaceMethodWithBlock(Class class, SEL originalSelector, id block);`
* `void class_implementPropertyInUserDefaults(Class class, NSString *propertyName, BOOL automaticSynchronizeUserDefaults);`
* `void class_implementProperty(Class class, NSString *propertyName, objc_AssociationPolicy associationPolicy);`


Getting runtime information about blocks
============================
[SLBlockDescription](https://github.com/ebf/SLObjectiveCRuntimeAdditions/blob/master/SLObjectiveCRuntimeAdditions/SLObjectiveCRuntimeAdditions/SLBlockDescription.h) lets you inspect blocks including arguments and compile time features at runtime.

One could use SLBlockDescription for the following test block:

``` objc
// a test block.
BOOL(^testBlock)(BOOL animated, id object) = ^BOOL(BOOL animated, id object) {
    return YES;
};

// allocating a block description
SLBlockDescription *blockDescription = [[SLBlockDescription alloc] initWithBlock:testBlock];

// getting a method signature for this block
NSMethodSignature *methodSignature = blockDescription.blockSignature;
/**
<NSMethodSignature: 0x253f080>
    number of arguments = 3
    frame size = 12
    is special struct return? NO
    return value: -------- -------- -------- --------
        type encoding (c) 'c'
        flags {isSigned}
        modifiers {}
        frame {offset = 0, offset adjust = 0, size = 4, size adjust = -3}
        memory {offset = 0, size = 1}
    argument 0: -------- -------- -------- --------
        type encoding (@) '@?'
        flags {isObject, isBlock}
        modifiers {}
        frame {offset = 0, offset adjust = 0, size = 4, size adjust = 0}
        memory {offset = 0, size = 4}
    argument 1: -------- -------- -------- --------
        type encoding (c) 'c'
        flags {isSigned}
        modifiers {}
        frame {offset = 4, offset adjust = 0, size = 4, size adjust = -3}
        memory {offset = 0, size = 1}
    argument 2: -------- -------- -------- --------
        type encoding (@) '@'
        flags {isObject}
        modifiers {}
        frame {offset = 8, offset adjust = 0, size = 4, size adjust = 0}
        memory {offset = 0, size = 4}
*/
```

License
============================
MIT

Thanks goes to the [Block Implementation Specification](http://clang.llvm.org/docs/Block-ABI-Apple.txt) and the [A2DynamicDelegate](https://github.com/pandamonia/A2DynamicDelegate) project for some good libffi samples and convertion from encodings to libffi types.
