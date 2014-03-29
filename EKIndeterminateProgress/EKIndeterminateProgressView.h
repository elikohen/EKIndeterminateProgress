//
//  EKIndeterminateProgressView.h
//  animationtest
//
//  Created by Eli Kohen Gomez on 23/03/14.
//  Copyright (c) 2014 Eli Kohen Gomez. All rights reserved.
//

#import <UIKit/UIKit.h>

/** Animations to be applied */
typedef NS_OPTIONS(NSInteger, EKIndeterminateProgressAnimation){
    /** Horizontal translation */
    EKIndeterminateProgressAnimationTranslate = 1 << 0,
    /** Clockwise rotation */
    EKIndeterminateProgressAnimationRotate
};

/**
 *  Indeterminate progress View, alternative to UIActivityIndicator
 */
@interface EKIndeterminateProgressView : UIView

/**
 *  Determines wether to hide entire view then stopped and wether to unhide when started.
 */
@property (nonatomic) BOOL hidesWhenStopped;
/**
 *  Determines the paddings to the edges of the view where the progresses will be moving.
 */
@property (nonatomic) UIEdgeInsets edgeInsets;
/**
 *  Animation duration (each loop)
 */
@property (nonatomic) CGFloat duration;
/**
 *  Animations to be applied (i.e: EKIndeterminateProgressAnimationTranslate|EKIndeterminateProgressAnimationRotate)
 */
@property (nonatomic) NSInteger animations;

/**
 *  Initializes view using the background as size and starting at point 0,0
 *
 *  @param background UIImage to be set as View background
 *  @param progresses Array of progresses that will be randomly used as progress when progress started
 *
 *  @return EKIndeterminateProgressView
 */
- (instancetype) initWithBackground: (UIImage*) background andProgress: (NSArray*) progresses;
/**
 *  Initializes view with frame, setting the background (expanding to the frame) and progresses array
 *
 *  @param frame View frame
 *  @param background UIImage to be set as View background
 *  @param progresses Array of progresses that will be randomly used as progress when progress started
 *
 *  @return EKIndeterminateProgressView
 */
- (instancetype) initWithFrame:(CGRect)frame background: (UIImage*) background andProgresses: (NSArray*) progresses;
/**
 *  Starts animating, and unhides if hidesWhenStopped
 */
- (void) startAnimating;
/**
 *  Stops animating, and hides if hidesWhenStopped
 */
- (void) stopAnimating;
/**
 *  Retuns YES if animating
 */
- (BOOL) animating;
@end
