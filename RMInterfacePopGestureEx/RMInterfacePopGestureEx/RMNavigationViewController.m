//
//  RMNavigationViewController.m
//  RMInterfacePopGestureEx
//
//  Created by JianRongCao on 6/28/16.
//  Copyright © 2016 JianRongCao. All rights reserved.
//

#import "RMNavigationViewController.h"

@interface RMNavigationViewController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation RMNavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    __weak RMNavigationViewController *ws = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        self.interactivePopGestureRecognizer.delegate = ws;
        self.delegate = ws;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIViewController *topViewController = self.topViewController;
    topViewController.hidesBottomBarWhenPushed = YES;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = NO;
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count == 2) {
        topViewController.hidesBottomBarWhenPushed = NO;
    }
}

#pragma mark UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}


#pragma mark UINavigationControllerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [super popViewControllerAnimated:YES];
}

#pragma mark UINavigationControllerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self.childViewControllers count] == 1) {
        return NO;
    }
    return YES;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.delegate = self;
        [self.navigationBar setBackgroundImage:[self imageWithColor:[UIColor clearColor]
                                                                  size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 64)]
                                 forBarMetrics:UIBarMetricsDefault];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:20.0f],NSFontAttributeName,
                              [UIColor whiteColor],NSForegroundColorAttributeName,nil];
        self.navigationBar.titleTextAttributes = dict;
        
    }
    return self;
}

#pragma mark 横竖屏控制
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}

- (BOOL)shouldAutorotate
{
    UIViewController *viewController = [self topViewController];
    NSArray *array = @[@"DHPhotoAlbumViewController",@"EzvizVedioListViewController"];
    if ([array containsObject:[[viewController class] description]] != NSNotFound) {
        return YES;
    }
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [[self topViewController] preferredInterfaceOrientationForPresentation];
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, 8, 4 * size.width, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIImage *image = [UIImage imageWithCGImage:imageMasked];
    
    CGImageRelease(imageMasked);
    
    return image;
}

@end
