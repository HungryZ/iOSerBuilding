//
//  ZHCTextField.h
//  FCHCL
//
//  Created by 张海川 on 2019/4/25.
//  Copyright © 2019 封建. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ZHCFieldTypeDefault,
    ZHCFieldTypeNumber,
    ZHCFieldTypePhoneNumber,
    ZHCFieldTypePassword,
    ZHCFieldTypeMoney,
    ZHCFieldTypeIDNumber,
    ZHCFieldTypeChinese,
} ZHCFieldType;

@interface ZHCTextField : UITextField

@property (nonatomic, assign) ZHCFieldType  fieldType;

/// 长度限制
@property (nonatomic, assign) int           maxLength;

@property (nonatomic, copy) NSString *      leftText;
@property (nonatomic, copy) NSString *      leftImageString;

@property (nonatomic, assign) BOOL          isShowBottomLine;

@end

NS_ASSUME_NONNULL_END
