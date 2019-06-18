//
//  ZHCTextField.h
//  FCHCL
//
//  Created by 张海川 on 2019/4/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ZHCFieldTypeDefault,
    ZHCFieldTypeNumber,
    ZHCFieldTypePhoneNumber,
    ZHCFieldTypePhoneNumberWithoutSpacing,
    ZHCFieldTypePassword,
    ZHCFieldTypeMoney,
    ZHCFieldTypeIDCardNumber,
    ZHCFieldTypeChinese,
    ZHCFieldTypeBankCardNumber,
} ZHCFieldType;

@interface ZHCTextField : UITextField

@property (nonatomic, assign) ZHCFieldType  fieldType;

/// 长度限制
@property (nonatomic, assign) int           maxLength;

/// 左视图文字颜色，需在leftText之前赋值
@property (nonatomic, strong) UIColor *     leftTextColor;
/// 左视图文字颜色，需在leftText之前赋值
@property (nonatomic, assign) float         leftTextFontSize;

@property (nonatomic, copy) NSString *      leftText;

@property (nonatomic, copy) NSString *      leftImageName;

/// 密码明暗文切换图片数组，需传入两个UIImage，第一个代表明文，第二个暗文。
@property (nonatomic, strong) NSArray *     secureButtonImages;

@property (nonatomic, assign) BOOL          showBottomLine;

@end

NS_ASSUME_NONNULL_END
