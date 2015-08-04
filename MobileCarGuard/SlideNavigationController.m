//
//  SlideNavigationController.m
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//
// https://github.com/aryaxt/iOS-Slide-Menu
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "SlideNavigationController.h"

typedef enum {
	PopTypeAll,
	PopTypeRoot
} PopType;

@interface SlideNavigationController()

@property (nonatomic, assign) CGPoint draggingPoint;
@property (nonatomic, assign) Menu lastRevealedMenu;
@property (nonatomic, assign) BOOL menuNeedsLayout;

@end

@implementation SlideNavigationController

NSString * const SlideNavigationControllerDidOpen = @"SlideNavigationControllerDidOpen";
NSString * const SlideNavigationControllerDidClose = @"SlideNavigationControllerDidClose";
NSString  *const SlideNavigationControllerDidReveal = @"SlideNavigationControllerDidReveal";

#define MENU_SLIDE_ANIMATION_DURATION .3
#define MENU_SLIDE_ANIMATION_OPTION UIViewAnimationOptionCurveEaseOut
#define MENU_QUICK_SLIDE_ANIMATION_DURATION .18
#define MENU_IMAGE @"menu-button"
#define MENU_SHADOW_RADIUS 10
#define MENU_SHADOW_OPACITY 1
#define MENU_DEFAULT_SLIDE_OFFSET 60
#define MENU_FAST_VELOCITY_FOR_SWIPE_FOLLOW_DIRECTION 1200
#define STATUS_BAR_HEIGHT 20
#define NOTIFICATION_USER_INFO_MENU_LEFT @"left"
#define NOTIFICATION_USER_INFO_MENU_RIGHT @"right"
#define NOTIFICATION_USER_INFO_MENU @"menu"

static SlideNavigationController *singletonInstance;

#pragma mark - Initialization -

+ (SlideNavigationController *)sharedInstance
{
	if (!singletonInstance)
		NSLog(@"SlideNavigationController has not been initialized. Either place one in your storyboard or initialize one in code");
	
	return singletonInstance;
}

- (id)init
{
	if (self = [super init])
	{
		[self setup];
	}
	
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder])
	{
		[self setup];
	}
	
	return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
	if (self = [super initWithRootViewController:rootViewController])
	{
		[self setup];
	}
	
	return self;
}

- (id)initWithNavigationBarClass:(Class)navigationBarClass toolbarClass:(Class)toolbarClass
{
	if (self = [super initWithNavigationBarClass:navigationBarClass toolbarClass:toolbarClass])
	{
		[self setup];
	}
	
	return self;
}

- (void)setup
{
	if (singletonInstance)
		NSLog(@"Singleton instance already exists. You can only instantiate one instance of SlideNavigationController. This could cause major issues");
	
	singletonInstance = self;
	
	self.menuRevealAnimationDuration = MENU_SLIDE_ANIMATION_DURATION;
	self.menuRevealAnimationOption = MENU_SLIDE_ANIMATION_OPTION;
	self.landscapeSlideOffset = MENU_DEFAULT_SLIDE_OFFSET;
	self.portraitSlideOffset = MENU_DEFAULT_SLIDE_OFFSET;
	self.panGestureSideOffset = 0;
	self.avoidSwitchingToSameClassViewController = YES;
	self.enableShadow = YES;
	self.enableSwipeGesture = YES;
	self.delegate = self;
}

- (void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];
	
	// Update shadow size of enabled
	if (self.enableShadow)
		self.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.view.bounds].CGPath;

    if (self.menuNeedsLayout)
    {
        [self updateMenuFrameAndTransformAccordingToOrientation];
        
        // Handle different horizontal/vertical slideOffset during rotation
        // On iOS below 8 we just close the menu, iOS8 handles rotation better so we support keepiong the menu open
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0") && [self isMenuOpen])
        {
            Menu menu = (self.horizontalLocation > 0) ? MenuLeft : MenuRight;
            [self openMenu:menu withDuration:0 andCompletion:nil];
        }
        
        self.menuNeedsLayout = NO;
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

    self.menuNeedsLayout = YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];

    self.menuNeedsLayout = YES;
}

#pragma mark - Public Methods -

- (void)switchToViewController:(UIViewController *)viewController
		 withSlideOutAnimation:(BOOL)slideOutAnimation
					   popType:(PopType)poptype
				 andCompletion:(void (^)())completion
{
	if (self.avoidSwitchingToSameClassViewController && [self.topViewController isKindOfClass:viewController.class])
	{
		[self closeMenuWithCompletion:completion];
		return;
	}
	
	void (^switchAndCallCompletion)(BOOL) = ^(BOOL closeMenuBeforeCallingCompletion) {
		if (poptype == PopTypeAll) {
			[self setViewControllers:@[viewController]];
		}
		else {
			[super popToRootViewControllerAnimated:NO];
			[super pushViewController:viewController animated:NO];
		}
		
		if (closeMenuBeforeCallingCompletion)
		{
			[self closeMenuWithCompletion:^{
				if (completion)
					completion();
			}];
		}
		else
		{
			if (completion)
				completion();
		}
	};
	
	if ([self isMenuOpen])
	{
		if (slideOutAnimation)
		{
			[UIView animateWithDuration:(slideOutAnimation) ? self.menuRevealAnimationDuration : 0
								  delay:0
								options:self.menuRevealAnimationOption
							 animations:^{
								 CGFloat width = self.horizontalSize;
								 CGFloat moveLocation = (self.horizontalLocation> 0) ? width : -1*width;
								 [self moveHorizontallyToLocation:moveLocation];
							 } completion:^(BOOL finished) {
								 switchAndCallCompletion(YES);
							 }];
		}
		else
		{
			switchAndCallCompletion(YES);
		}
	}
	else
	{
		switchAndCallCompletion(NO);
	}
}

- (void)switchToViewController:(UIViewController *)viewController withCompletion:(void (^)())completion
{
	[self switchToViewController:viewController withSlideOutAnimation:YES popType:PopTypeRoot andCompletion:completion];
}

- (void)popToRootAndSwitchToViewController:(UIViewController *)viewController
				  withSlideOutAnimation:(BOOL)slideOutAnimation
						  andCompletion:(void (^)())completion
{
	[self switchToViewController:viewController withSlideOutAnimation:slideOutAnimation popType:PopTypeRoot andCompletion:completion];
}

- (void)popToRootAndSwitchToViewController:(UIViewController *)viewController
						 withCompletion:(void (^)())completion
{
	[self switchToViewController:viewController withSlideOutAnimation:YES popType:PopTypeRoot andCompletion:completion];
}

- (void)popAllAndSwitchToViewController:(UIViewController *)viewController
		 withSlideOutAnimation:(BOOL)slideOutAnimation
				 andCompletion:(void (^)())completion
{
	[self switchToViewController:viewController withSlideOutAnimation:slideOutAnimation popType:PopTypeAll andCompletion:completion];
}

- (void)popAllAndSwitchToViewController:(UIViewController *)viewController
						 withCompletion:(void (^)())completion
{
	[self switchToViewController:viewController withSlideOutAnimation:YES popType:PopTypeAll andCompletion:completion];
}

- (void)closeMenuWithCompletion:(void (^)())completion
{
	[self closeMenuWithDuration:self.menuRevealAnimationDuration andCompletion:completion];
}

- (void)openMenu:(Menu)menu withCompletion:(void (^)())completion
{
	[self openMenu:menu withDuration:self.menuRevealAnimationDuration andCompletion:completion];
}

- (void)toggleLeftMenu
{
	[self toggleMenu:MenuLeft withCompletion:nil];
}

- (void)toggleRightMenu
{
	[self toggleMenu:MenuRight withCompletion:nil];
}

- (BOOL)isMenuOpen
{
	return (self.horizontalLocation == 0) ? NO : YES;
}

- (void)setEnableShadow:(BOOL)enable
{
	_enableShadow = enable;
	
	if (enable)
	{
		self.view.layer.shadowColor = [UIColor darkGrayColor].CGColor;
		self.view.layer.shadowRadius = MENU_SHADOW_RADIUS;
		self.view.layer.shadowOpacity = MENU_SHADOW_OPACITY;
		self.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.view.bounds].CGPath;
		self.view.layer.shouldRasterize = YES;
		self.view.layer.rasterizationScale = [UIScreen mainScreen].scale;
	}
	else
	{
		self.view.layer.shadowOpacity = 0;
		self.view.layer.shadowRadius = 0;
	}
}

#pragma mark - Override Methods -

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
	if ([self isMenuOpen])
	{
		[self closeMenuWithCompletion:^{
			[super popToRootViewControllerAnimated:animated];
		}];
	}
	else
	{
		return [super popToRootViewControllerAnimated:animated];
	}
	
	return nil;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	if ([self isMenuOpen])
	{
		[self closeMenuWithCompletion:^{
			[super pushViewController:viewController animated:animated];
		}];
	}
	else
	{
		[super pushViewController:viewController animated:animated];
	}
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	if ([self isMenuOpen])
	{
		[self closeMenuWithCompletion:^{
			[super popToViewController:viewController animated:animated];
		}];
	}
	else
	{
		return [super popToViewController:viewController animated:animated];
	}
	
	return nil;
}

#pragma mark - Private Methods -

- (void)updateMenuFrameAndTransformAccordingToOrientation
{
	// Animate rotatation when menu is open and device rotates
	CGAffineTransform transform = self.view.transform;
	self.leftMenu.view.transform = transform;
	self.rightMenu.view.transform = transform;
	
	self.leftMenu.view.frame = [self initialRectForMenu];
	self.rightMenu.view.frame = [self initialRectForMenu];
}


- (void)toggleMenu:(Menu)menu withCompletion:(void (^)())completion
{
	if ([self isMenuOpen])
		[self closeMenuWithCompletion:completion];
	else
		[self openMenu:menu withCompletion:completion];
}

- (UIBarButtonItem *)barButtonItemForMenu:(Menu)menu
{
	SEL selector = (menu == MenuLeft) ? @selector(leftMenuSelected:) : @selector(righttMenuSelected:);
	UIBarButtonItem *customButton = (menu == MenuLeft) ? self.leftBarButtonItem : self.rightBarButtonItem;
	
	if (customButton)
	{
		customButton.action = selector;
		customButton.target = self;
		return customButton;
	}
	else
	{
		UIImage *image = [UIImage imageNamed:MENU_IMAGE];
        return [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:selector];
	}
}

- (BOOL)shouldDisplayMenu:(Menu)menu forViewController:(UIViewController *)vc
{
	if (menu == MenuRight)
	{
		if ([vc respondsToSelector:@selector(slideNavigationControllerShouldDisplayRightMenu)] &&
			[(UIViewController<SlideNavigationControllerDelegate> *)vc slideNavigationControllerShouldDisplayRightMenu])
		{
			return YES;
		}
	}
	if (menu == MenuLeft)
	{
		if ([vc respondsToSelector:@selector(slideNavigationControllerShouldDisplayLeftMenu)] &&
			[(UIViewController<SlideNavigationControllerDelegate> *)vc slideNavigationControllerShouldDisplayLeftMenu])
		{
			return YES;
		}
	}
	
	return NO;
}

- (void)openMenu:(Menu)menu withDuration:(float)duration andCompletion:(void (^)())completion
{
//	[self enableTapGestureToCloseMenu:YES];

	[self prepareMenuForReveal:menu];
	
	[UIView animateWithDuration:duration
						  delay:0
						options:self.menuRevealAnimationOption
					 animations:^{
						 CGRect rect = self.view.frame;
						 CGFloat width = self.horizontalSize;
						 rect.origin.x = (menu == MenuLeft) ? (width - self.slideOffset) : ((width - self.slideOffset )* -1);
						 [self moveHorizontallyToLocation:rect.origin.x];
					 }
					 completion:^(BOOL finished) {
						 if (completion)
							 completion();
                         
                         [self postNotificationWithName:SlideNavigationControllerDidOpen forMenu:menu];
					 }];
}

- (void)closeMenuWithDuration:(float)duration andCompletion:(void (^)())completion
{
//	[self enableTapGestureToCloseMenu:NO];
    
     Menu menu = (self.horizontalLocation > 0) ? MenuLeft : MenuRight;
	
	[UIView animateWithDuration:duration
						  delay:0
						options:self.menuRevealAnimationOption
					 animations:^{
						 CGRect rect = self.view.frame;
						 rect.origin.x = 0;
						 [self moveHorizontallyToLocation:rect.origin.x];
					 }
					 completion:^(BOOL finished) {
						 if (completion)
							 completion();
                         
                         [self postNotificationWithName:SlideNavigationControllerDidClose forMenu:menu];
					 }];
}

- (void)moveHorizontallyToLocation:(CGFloat)location
{
	CGRect rect = self.view.frame;
	UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
	//Menu menu = (self.horizontalLocation >= 0 && location >= 0) ? MenuLeft : MenuRight;
    
    if ((location > 0 && self.horizontalLocation <= 0) || (location < 0 && self.horizontalLocation >= 0)) {
        [self postNotificationWithName:SlideNavigationControllerDidReveal forMenu:(location > 0) ? MenuLeft : MenuRight];
    }
    
	//系统版本为8.0或以上
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        rect.origin.x = location;
        rect.origin.y = 0;
    }
    else
    {
        //设备横向
        if (UIDeviceOrientationIsLandscape(orientation))
        {
            rect.origin.x = 0;
            rect.origin.y = (orientation == UIDeviceOrientationLandscapeRight) ? location : location*-1;
        }
        else
        {
            rect.origin.x = (orientation == UIDeviceOrientationPortrait) ? location : location*-1;
            rect.origin.y = 0;
        }
    }
	
	self.view.frame = rect;
}

- (CGRect)initialRectForMenu
{
	CGRect rect = self.view.frame;
	rect.origin.x = 0;
	rect.origin.y = 0;
	
	if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        return rect;
    }
	
	UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
	//Portrait 表示纵向，Landscape 表示横向
	if (UIDeviceOrientationIsLandscape(orientation))
	{
        // For some reasons in landscape below the status bar is considered y=0, but in portrait it's considered y=20
        rect.origin.x = (orientation == UIDeviceOrientationLandscapeRight) ? 0 : STATUS_BAR_HEIGHT;
        rect.size.width = self.view.frame.size.width-STATUS_BAR_HEIGHT;
	}
	else
	{
        // For some reasons in landscape below the status bar is considered y=0, but in portrait it's considered y=20
        rect.origin.y = (orientation == UIDeviceOrientationPortrait) ? STATUS_BAR_HEIGHT : 0;
        rect.size.height = self.view.frame.size.height-STATUS_BAR_HEIGHT;
	}
	
	return rect;
}

- (void)prepareMenuForReveal:(Menu)menu
{
	// Only prepare menu if it has changed (ex: from MenuLeft to MenuRight or vice versa)
    if (self.lastRevealedMenu && menu == self.lastRevealedMenu)
        return;
    
    UIViewController *menuViewController = (menu == MenuLeft) ? self.leftMenu : self.rightMenu;
	UIViewController *removingMenuViewController = (menu == MenuLeft) ? self.rightMenu : self.leftMenu;

    self.lastRevealedMenu = menu;
	
	[removingMenuViewController.view removeFromSuperview];
	[self.view.superview insertSubview:menuViewController.view atIndex:0];

	[self updateMenuFrameAndTransformAccordingToOrientation];
}

- (CGFloat)horizontalLocation
{
	CGRect rect = self.view.frame;
	UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
	
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        return rect.origin.x;
    }
    else
    {
        if (UIDeviceOrientationIsLandscape(orientation))
        {
            return (orientation == UIDeviceOrientationLandscapeRight)
            ? rect.origin.y
            : rect.origin.y*-1;
        }
        else
        {
            return (orientation == UIDeviceOrientationPortrait)
            ? rect.origin.x
            : rect.origin.x*-1;
        }
    }
}

- (CGFloat)horizontalSize
{
	CGRect rect = self.view.frame;
	UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
	
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        return rect.size.width;
    }
    else
    {
        if (UIDeviceOrientationIsLandscape(orientation))
        {
            return rect.size.height;
        }
        else
        {
            return rect.size.width;
        }
    }
}

- (void)postNotificationWithName:(NSString *)name forMenu:(Menu)menu
{
    NSString *menuString = (menu == MenuLeft) ? NOTIFICATION_USER_INFO_MENU_LEFT : NOTIFICATION_USER_INFO_MENU_RIGHT;
    NSDictionary *userInfo = @{ NOTIFICATION_USER_INFO_MENU : menuString };
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:userInfo];
}

#pragma mark - UINavigationControllerDelegate Methods -

- (void)navigationController:(UINavigationController *)navigationController
	  willShowViewController:(UIViewController *)viewController
					animated:(BOOL)animated
{
	if ([self shouldDisplayMenu:MenuLeft forViewController:viewController])
		viewController.navigationItem.leftBarButtonItem = [self barButtonItemForMenu:MenuLeft];
	
	if ([self shouldDisplayMenu:MenuRight forViewController:viewController])
		viewController.navigationItem.rightBarButtonItem = [self barButtonItemForMenu:MenuRight];
}

- (CGFloat)slideOffset
{
	return (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
		? self.landscapeSlideOffset
		: self.portraitSlideOffset;
}

#pragma mark - IBActions -

- (void)leftMenuSelected:(id)sender
{
	if ([self isMenuOpen])
		[self closeMenuWithCompletion:nil];
	else
		[self openMenu:MenuLeft withCompletion:nil];
}

- (void)righttMenuSelected:(id)sender
{
	if ([self isMenuOpen])
		[self closeMenuWithCompletion:nil];
	else
		[self openMenu:MenuRight withCompletion:nil];
}


@end
