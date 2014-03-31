//
//  EKIndeterminateProgressView.m
//  animationtest
//
//  Created by Eli Kohen Gomez on 23/03/14.
//  Copyright (c) 2014 Eli Kohen Gomez. All rights reserved.
//

#import "EKIndeterminateProgressView.h"
#import <QuartzCore/QuartzCore.h>

#define RANDOM_INT(__MIN__, __MAX__) ((arc4random() % __MAX__) + __MIN__)
#define DEFAULT_DURATION 1.0f
#define DEFAULT_ANIMATIONS (EKIndeterminateProgressAnimationTranslate)

@interface EKIndeterminateProgressView (){
    CFTimeInterval mPauseTime;
}

@property (nonatomic, strong) NSArray *mProgresses;
@property (nonatomic, weak) UIImageView *mAnimatingProgress;

@end

@implementation EKIndeterminateProgressView

#pragma mark - Public methods

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.duration = DEFAULT_DURATION;
        self.animations = DEFAULT_ANIMATIONS;
    }
    return self;
}

- (instancetype) initWithBackground: (UIImage*) background andProgress: (NSArray*) progresses{
    CGRect frame = CGRectMake(0, 0, background.size.width, background.size.height);
    self = [self initWithFrame:frame];
    if(self){
        self.mProgresses = progresses;
        [self setupBackground:background];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame background: (UIImage*) background andProgresses: (NSArray*) progresses{
    self = [self initWithFrame:frame];
    if(self){
        self.mProgresses = progresses;
        [self setupBackground:background];
    }
    return self;
}

- (void) startAnimating{
    if (self.mProgresses.count == 0) {
        @throw [NSException exceptionWithName:@"Invalid data"
                                       reason:@"Empty progresses"
                                     userInfo:nil];
    }
    
    if(self.mAnimatingProgress){
        NSArray *animations = [self.mAnimatingProgress.layer animationKeys];
        if(animations.count == 0){
            [self setupAnimationsAndVisiblity];
        }
        return;
    }
    
    //Cactus random get
    NSInteger progressIndex = RANDOM_INT(0, self.mProgresses.count);
    UIImage *progress = [self.mProgresses objectAtIndex:progressIndex];
    CGRect imageFrame = CGRectMake(self.edgeInsets.left, self.edgeInsets.top, progress.size.width, progress.size.height);
    UIImageView *progressImg = [[UIImageView alloc] initWithFrame:imageFrame];
    progressImg.image = progress;
    [self addSubview:progressImg];
    self.mAnimatingProgress = progressImg;
    
    [self setupAnimationsAndVisiblity];
}

- (void) setupAnimationsAndVisiblity{
    NSLog(@"setupAnimationsAndVisiblity");
    if(self.animations & EKIndeterminateProgressAnimationTranslate){
        [self addMoveXAnimationForLayer:self.mAnimatingProgress.layer];
    }
    if(self.animations & EKIndeterminateProgressAnimationRotate){
        [self addRotateZAnimationForLayer:self.mAnimatingProgress.layer];
    }
    
    if(self.hidesWhenStopped){
        self.hidden = NO;
    }
}

- (void) stopAnimating{
    
    if(!self.mAnimatingProgress) return;
    
    UIView *temp = self.mAnimatingProgress;
    self.mAnimatingProgress = nil;
    [temp.layer removeAllAnimations];
    [temp removeFromSuperview];
    
    if(self.hidesWhenStopped){
        self.hidden = YES;
    }
}

- (BOOL) animating{
    return (self.mAnimatingProgress != nil);
}

#pragma mark - Private methods
- (void) setupBackground: (UIImage*) background{
    UIImageView *bckgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    bckgImage.image = background;
    [self addSubview:bckgImage];
}

- (void)addMoveXAnimationForLayer:(CALayer *)layer{
    
    // The keyPath to animate
    NSString *keyPath = @"transform.translation.x";
    
    // Allocate a CAKeyFrameAnimation for the specified keyPath.
    CAKeyframeAnimation *translation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    
    // Set animation duration and repeat
    translation.duration = self.duration;
    translation.repeatCount = HUGE_VAL;
    translation.autoreverses = YES;
    translation.delegate = self;
    
    // Allocate array to hold the values to interpolate
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    // Add the start value
    // The animation starts at a x offset of padding left
    [values addObject:[NSNumber numberWithFloat:0.0]];
    
    // Add the end value
    // The animation finishes when the image would contact the right of the view
    // This point is calculated by finding the width of the view frame
    // and subtracting the width of the image.
    CGFloat width = self.frame.size.width - layer.frame.size.width - self.edgeInsets.left - self.edgeInsets.right;
    [values addObject:[NSNumber numberWithFloat:width]];
    
    // Set the values that should be interpolated during the animation
    translation.values = values;
    
    // Allocate array to hold the timing functions
    NSMutableArray *timingFunctions = [[NSMutableArray alloc] init];
    
    // add a timing function for the first animation step to ease in the animation
    // this step crudely simulates gravity by easing in the effects of y offset
    [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    // Set the timing functions that should be used to calculate interpolation between the first two keyframes
    translation.timingFunctions = timingFunctions;

    //TODO: FIX
//    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - mPauseTime;
//    translation.beginTime = timeSincePause;
    
    [layer addAnimation:translation forKey:keyPath];
}

- (void)addRotateZAnimationForLayer:(CALayer *)layer{
    NSString *keyPath = @"transform.rotation.z";
    CGFloat duration = self.duration;
    CAKeyframeAnimation *rotation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    rotation.values = [NSArray arrayWithObjects:   	// Rotation values for the 4 keyframes, in RADIANS
                       [NSNumber numberWithFloat:0.0 * M_PI],
                       [NSNumber numberWithFloat:0.75 * M_PI],
                       [NSNumber numberWithFloat:1.5 * M_PI],
                       [NSNumber numberWithFloat:2.0 * M_PI],nil];
    rotation.keyTimes = [NSArray arrayWithObjects:     // Relative timing values for the 4 keyframes
                         [NSNumber numberWithFloat:0],
                         [NSNumber numberWithFloat:self.duration/3],
                         [NSNumber numberWithFloat:(self.duration/3)*2],
                         [NSNumber numberWithFloat:self.duration],nil];
	
	rotation.duration = duration;
    rotation.repeatCount = HUGE_VAL;
    rotation.autoreverses = YES;
    rotation.delegate = self;
    
    //TODO: FIX
//    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - mPauseTime;
//    rotation.beginTime = timeSincePause;
    
	[layer addAnimation:rotation forKey:keyPath];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    //TODO: FIX
    /*if(!self.mAnimatingProgress) return;
    
    NSArray *animations = [self.mAnimatingProgress.layer animationKeys];
    if(animations.count == 0){
        mPauseTime = [self.mAnimatingProgress.layer convertTime:CACurrentMediaTime() fromLayer:nil];
        [self setupAnimationsAndVisiblity];
    }*/
}
@end
