//
//  ZHCButton.m
//  HungryTools
//
//  Created by 张海川 on 2021/1/11.
//

#import "ZHCButton.h"

@interface ZHCButton()

@property (nonatomic, assign) CGSize fixedIntrinsicContentSize;
@property (nonatomic, assign) CGRect fixedImageRect;
@property (nonatomic, assign) CGRect fixedTitleRect;

@end

@implementation ZHCButton

+ (instancetype)buttonwithAlignment:(ZHCButtonAlignment)alignment {
    ZHCButton *button = [self buttonWithType:UIButtonTypeCustom];
    button.zhc_alignment = alignment;
    
    return button;
}

#pragma mark - Overwrite

- (void)dealloc {
    [self.titleLabel removeObserver:self forKeyPath:@"font"];
    [self.titleLabel removeObserver:self forKeyPath:@"text"];
    [self.imageView removeObserver:self forKeyPath:@"image"];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.titleLabel addObserver:self forKeyPath:@"font" options:NSKeyValueObservingOptionNew context:nil];
        [self.titleLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        [self.imageView addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    if (CGSizeEqualToSize(self.fixedIntrinsicContentSize, CGSizeZero)) {
        return [super intrinsicContentSize];
    } else {
        return self.fixedIntrinsicContentSize;
    }
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    if (CGRectIsEmpty(self.fixedImageRect)) {
        return [super imageRectForContentRect:contentRect];
    } else {
        return self.fixedImageRect;
    }
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    if (CGRectIsEmpty(self.fixedTitleRect)) {
        return [super titleRectForContentRect:contentRect];
    } else {
        return self.fixedTitleRect;
    }
}

#pragma mark - Helper

- (void)updateImageAndTitleLayout {
    [self calculateIntrinsicContentSize];
    CGRect contentRect = CGRectMake(0, 0, self.fixedIntrinsicContentSize.width, self.fixedIntrinsicContentSize.height);
    [self calculateImageRectAndTitleRectForContentRect:contentRect];
}

- (void)calculateIntrinsicContentSize {
    CGFloat width, height;
    CGSize imageSize = self.currentImage.size;
    CGSize titleSize = [self sizeForTitle];
    
    if (_zhc_alignment < 2) {       // 水平布局
        width = _zhc_padding.left + imageSize.width + _zhc_spacing + titleSize.width + _zhc_padding.right;
        height = _zhc_padding.top + MAX(imageSize.height, titleSize.height) + _zhc_padding.bottom;
    } else {
        width = _zhc_padding.left + MAX(imageSize.width, titleSize.width) + _zhc_padding.right;
        height = _zhc_padding.top + imageSize.height + _zhc_spacing + titleSize.height + _zhc_padding.bottom;
    }

    self.fixedIntrinsicContentSize = CGSizeMake(width, height);
}

- (void)calculateImageRectAndTitleRectForContentRect:(CGRect)contentRect {
    if (CGRectIsEmpty(contentRect)) {
        return;
    }

    CGRect imageRect = [super imageRectForContentRect:contentRect];
    CGRect titleRect = [super titleRectForContentRect:contentRect];
    // 还原真实的title尺寸
    titleRect.size = [self sizeForTitle];
    
    if (_zhc_alignment < 2) {   // 水平布局
        // 加间隔
        imageRect.origin.x -= _zhc_spacing / 2;
        titleRect.origin.x += _zhc_spacing / 2;
        
        // 调整边距
        if (_zhc_padding.left != _zhc_padding.right) {
            CGFloat step = (_zhc_padding.left - _zhc_padding.right) / 2;
            imageRect.origin.x += step;
            titleRect.origin.x += step;
        }
        if (_zhc_padding.top != _zhc_padding.bottom) {
            CGFloat step = (_zhc_padding.top - _zhc_padding.bottom) / 2;
            imageRect.origin.y += step;
            titleRect.origin.y += step;
        }
        
        if (_zhc_alignment == ZHCButtonAlignmentHorizontalReversal) {
            // 交换图片文字位置
            titleRect.origin.x = imageRect.origin.x;
            imageRect.origin.x = CGRectGetMaxX(titleRect) + _zhc_spacing;
        }
        if (CGRectGetMaxX(titleRect) > contentRect.size.width) {
            // X轴超出范围处理
            CGFloat difference = CGRectGetMaxX(titleRect) - contentRect.size.width;
            titleRect.size.width -= difference;
        }
    } else {                    // 垂直布局
        CGFloat imageHeight = CGRectGetHeight(imageRect);
        CGFloat titleHeight = CGRectGetHeight(titleRect);
        CGFloat imageAndTitleHeight = imageHeight + _zhc_spacing + titleHeight;
        
        imageRect.origin.x = CGRectGetMidX(contentRect) - CGRectGetWidth(imageRect) / 2;
        imageRect.origin.y = CGRectGetMidY(contentRect) - imageAndTitleHeight / 2;
        
        titleRect.origin.x = CGRectGetMidX(contentRect) - CGRectGetWidth(titleRect) / 2;
        titleRect.origin.y = CGRectGetMaxY(imageRect) + _zhc_spacing;
        
        // 调整边距
        if (_zhc_padding.left != _zhc_padding.right) {
            CGFloat step = (_zhc_padding.left - _zhc_padding.right) / 2;
            imageRect.origin.x += step;
            titleRect.origin.x += step;
        }
        if (_zhc_padding.top != _zhc_padding.bottom) {
            CGFloat step = (_zhc_padding.top - _zhc_padding.bottom) / 2;
            imageRect.origin.y += step;
            titleRect.origin.y += step;
        }
        
        if (_zhc_alignment == ZHCButtonAlignmentVerticalReversal) {
            // 交换图片文字位置
            titleRect.origin.y = imageRect.origin.y;
            imageRect.origin.y = CGRectGetMaxY(titleRect) + _zhc_spacing;
        }
        titleRect = [self fixTitleRect:titleRect ForContentRect:contentRect];
    }
    
    _fixedImageRect = imageRect;
    _fixedTitleRect = titleRect;
}

- (CGSize)sizeForTitle {
    return [self.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName : self.titleLabel.font}
                                           context:nil].size;
}

- (CGRect)fixTitleRect:(CGRect)titleRect ForContentRect:(CGRect)contentRect {
    if (titleRect.origin.x < 0) {
        titleRect.origin.x = 0;
        titleRect.size.width = contentRect.size.width;
    }
    
    if (CGRectGetMaxY(titleRect) > contentRect.size.height) {
        CGFloat difference = CGRectGetMaxY(titleRect) - contentRect.size.height;
        titleRect.size.height -= difference;
    }
    return titleRect;
}

#pragma mark - 触发调整布局

// KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"font"] || [keyPath isEqualToString:@"text"] || [keyPath isEqualToString:@"image"]) {
        [self updateImageAndTitleLayout];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

// Setter

- (void)setZhc_alignment:(ZHCButtonAlignment)zhc_alignment {
    _zhc_alignment = zhc_alignment;
    
    [self updateImageAndTitleLayout];
}

- (void)setZhc_spacing:(CGFloat)zhc_spacing {
    _zhc_spacing = zhc_spacing;
    
    [self updateImageAndTitleLayout];
}

- (void)setZhc_padding:(UIEdgeInsets)zhc_padding {
    _zhc_padding = zhc_padding;
    
    [self updateImageAndTitleLayout];
}

@end
