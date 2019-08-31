//
//  UILabel+Size.m
//  HungryTools
//
//  Created by 张海川 on 2019/7/25.
//

#import "UILabel+Size.h"

@implementation UILabel (Size)

- (float)textWidth {
    
    if (self.numberOfLines == 0) {
        return self.frame.size.width;
    }
    
    return [self.text sizeWithAttributes:@{NSFontAttributeName : self.font}].width;
}

- (float)textHeightWithWidth:(float)width {
    
    return [self.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                   options:NSStringDrawingUsesLineFragmentOrigin
                                attributes:@{NSFontAttributeName : self.font}
                                   context:nil].size.height;
}

- (float)attributedTextHeightWithWidth:(float)width {
    
    return [self.attributedText boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                             options:NSStringDrawingUsesLineFragmentOrigin |
                                                     NSStringDrawingUsesFontLeading
                                             context:nil].size.height;
}

@end
