//
//  HeaderInsetTableView.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/29.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "HeaderInsetTableView.h"


@interface HeaderInsetTableView ()

@property (nonatomic, assign) BOOL shouldManuallyLayoutHeaderViews;
- (void)layoutHeaderViews;

@end

@implementation HeaderInsetTableView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.shouldManuallyLayoutHeaderViews) {
        [self layoutHeaderViews];
    }
}

- (void)setHeaderViewInsets:(UIEdgeInsets)headerViewInsets {
    _headerViewInsets = headerViewInsets;
    
    self.shouldManuallyLayoutHeaderViews = !UIEdgeInsetsEqualToEdgeInsets(headerViewInsets, UIEdgeInsetsZero);
    
    [self setNeedsLayout];
}

- (void)layoutHeaderViews {
    const NSUInteger numberOfSections = self.numberOfSections;
    const UIEdgeInsets contentInset = self.contentInset;
    const CGPoint contentOffset = self.contentOffset;
    
    const CGFloat sectionViewMinimumOriginY =
    contentOffset.y + contentInset.top + self.headerViewInsets.top;
    
    //	Layout each header view
    for (NSUInteger section = 0;section < numberOfSections;section++) {
        UIView *sectionView = [self headerViewForSection:section];
        
        if (sectionView == nil)
            continue;
        
        const CGRect sectionFrame = [self rectForSection:section];
        
        CGRect sectionViewFrame = sectionView.frame;
        
        sectionViewFrame.origin.y =
        ((sectionFrame.origin.y < sectionViewMinimumOriginY)
         ?sectionViewMinimumOriginY
         : sectionFrame.origin.y);
        
        //	If it's not last section, manually 'stick' it to the below section if
        //needed
        if (section < numberOfSections - 1) {
            const CGRect nextSectionFrame = [self rectForSection:section + 1];
            
            if (CGRectGetMaxY(sectionViewFrame) > CGRectGetMinY(nextSectionFrame))
                sectionViewFrame.origin.y =
                nextSectionFrame.origin.y - sectionViewFrame.size.height;
        }
        
        [sectionView setFrame:sectionViewFrame];
    }
}

@end
