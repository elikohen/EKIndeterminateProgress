//
//  ViewController.m
//  IndeterminateProgressSample
//
//  Created by Eli Kohen Gomez on 23/03/14.
//  Copyright (c) 2014 Eli Kohen Gomez. All rights reserved.
//

#import "ViewController.h"
#import "EKIndeterminateProgressView.h"

@interface ViewController ()

@property (nonatomic, strong) EKIndeterminateProgressView *mProgressView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.mProgressView = [[EKIndeterminateProgressView alloc] initWithFrame:CGRectMake(10, 50, 300, 60) background:[UIImage imageNamed:@"background"] andProgresses:[NSArray arrayWithObjects:[UIImage imageNamed:@"heart1"],[UIImage imageNamed:@"heart2"], nil]];
    self.mProgressView.edgeInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
    self.mProgressView.animations = EKIndeterminateProgressAnimationRotate|EKIndeterminateProgressAnimationTranslate;
    self.mProgressView.hidesWhenStopped = YES;
    self.mProgressView.hidden = YES;
    
    [self.view addSubview:self.mProgressView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onShowHideProgress:(id)sender {
    if([self.mProgressView animating]){
        [self.mProgressView stopAnimating];
    }
    else{
        [self.mProgressView startAnimating];
    }
}

@end
