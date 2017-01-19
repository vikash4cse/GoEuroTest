//
//  HorizontalMenu.m
//  GoEuroTest
//
//  Created by Nagarro on 18/01/17.
//  Copyright © 2017 KV. All rights reserved.
//

#import "HorizontalMenu.h"

@interface HorizontalMenu()

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *sliderLeadingConstraint;

@end

@implementation HorizontalMenu

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
      
        [self configureMenuView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self configureMenuView];
    }
    return self;
}

- (void)configureMenuView {
    
    NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"HorizontalMenu" owner:self options:nil];
    [self addSubview:[nibArray objectAtIndex:0]];
}

- (IBAction)trainButtonAction:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    [self animateSliderToLeadingValue:button.frame.origin.x];
    
    if ([self.delegate respondsToSelector:@selector(didSelectTravelType:)]) {
        
        [self.delegate didSelectTravelType:TravelTypeTrain];
    }
}

- (IBAction)busButtonAction:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    [self animateSliderToLeadingValue:button.frame.origin.x];
    
    if ([self.delegate respondsToSelector:@selector(didSelectTravelType:)]) {
        
        [self.delegate didSelectTravelType:TravelTypeBus];
    }
}

- (IBAction)flightButtonAction:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    [self animateSliderToLeadingValue:button.frame.origin.x];
    
    if ([self.delegate respondsToSelector:@selector(didSelectTravelType:)]) {
        
        [self.delegate didSelectTravelType:TravelTypeFlight];
    }
}

- (void)animateSliderToLeadingValue:(CGFloat)leadingValue {
    
    self.sliderLeadingConstraint.constant = leadingValue;
    [UIView animateWithDuration:0.375 animations:^{
        
        [self layoutIfNeeded];
    }];
}

@end
