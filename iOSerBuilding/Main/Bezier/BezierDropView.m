//
//  BezierDropView.m
//  iOSerBuilding
//
//  Created by 张海川 on 2019/2/13.
//

#import "BezierDropView.h"

@implementation BezierDropView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addQuadCurveToPoint:CGPointMake(ScreenWidth, 0) controlPoint:CGPointMake(ScreenWidth / 2, -_offsetY * 2)];
    [[UIColor orangeColor] set];
    [path closePath];
    [path fill];
}

#pragma mark --因为这一层view在tableview的上面，所以要把触摸事件给tableview
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (![self pointInside:point withEvent:event]) {
        return nil;
    }
    else {
        for (UIView *view in self.superview.subviews) {
            if ([view isKindOfClass:[UITableView class]]) {
                return view;
            }
        }
    }
    return nil;
}

@end
