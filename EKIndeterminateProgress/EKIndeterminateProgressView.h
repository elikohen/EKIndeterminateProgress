//
//  EKIndeterminateProgressView.h
//  animationtest
//
//  Created by Eli Kohen Gomez on 23/03/14.
//  Copyright (c) 2014 Eli Kohen Gomez. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, EKIndeterminateProgressAnimation){
    EKIndeterminateProgressAnimationTranslate = 1 << 0,
    EKIndeterminateProgressAnimationRotate
};

@interface EKIndeterminateProgressView : UIView

@property (nonatomic) BOOL hidesWhenStopped;
@property (nonatomic) UIEdgeInsets edgeInsets;
@property (nonatomic) CGFloat duration;
@property (nonatomic) NSInteger animations;

- (instancetype) initWithBackground: (UIImage*) background andProgress: (NSArray*) progresses;
- (instancetype) initWithFrame:(CGRect)frame background: (UIImage*) background andProgresses: (NSArray*) progresses;

- (void) startAnimating;
- (void) stopAnimating;
- (BOOL) animating;
@end
