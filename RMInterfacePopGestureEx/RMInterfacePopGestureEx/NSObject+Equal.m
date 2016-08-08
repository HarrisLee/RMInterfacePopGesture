//
//  NSObject+Equal.m
//  RMInterfacePopGestureEx
//
//  Created by JianRongCao on 6/29/16.
//  Copyright © 2016 JianRongCao. All rights reserved.
//

#import "NSObject+Equal.h"
#import <objc/runtime.h>

@implementation NSObject (Equal)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSString *sel = NSStringFromSelector(aSelector);
    if ([sel rangeOfString:@"isEqualToString"].location == 0) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    else {
        Method method = class_getInstanceMethod([self class], aSelector);
        struct objc_method_description *desc = method_getDescription(method);
        if (desc == NULL || desc->name == NULL){
            return nil;
        }
        NSLog(@"method name is %@",NSStringFromSelector(desc->name));
        return [NSMethodSignature signatureWithObjCTypes:desc->types];
    }
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if ([self respondsToSelector:[anInvocation selector]]) {
        [anInvocation invokeWithTarget:self];
        NSLog(@"invocation %@",NSStringFromSelector([anInvocation selector]));
    }
    else {
        NSLog(@"%@  not invocation %@",[[self class] description],NSStringFromSelector([anInvocation selector]));
    }
}
#pragma clang diagnostic pop

@end
