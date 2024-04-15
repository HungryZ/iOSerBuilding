//
//  ZHUIWatermarkHelper.m
//  LR35_ZhaoHuOASDK
//
//  Created by cmb on 2023/11/8.
//

#import "ZHUIWatermarkHelper.h"
#import "Aspects.h"
//#import <ZA25_ZhaoHuSDKFoundation/NSDate+ZHExtension.h>

static NSInteger const WatermarkTag = 20231108;
static CGFloat const AccountFontSize = 14;
static CGFloat const DateFontSize = AccountFontSize - 3;
static CGFloat const HorzontalSpacing = 70;
static CGFloat const VerticalSpacing = 85;
static CGFloat const WatermarkColorAlpha = 0.05;
static NSString * const WatermarkHexColor = @"#000000";
static NSString * const DateFormat = @"yyyy-MM-dd HH:mm:ss";

@interface ZHUIWatermarkHelper ()

@property (nonatomic, copy) NSString *content;

@end

@implementation ZHUIWatermarkHelper

+ (void)configWatermarkContent:(NSString *)content {
    [self sharedHelper].content = content;
}

+ (void)addWatermarkToView:(UIView *)view {
    if (!view) {
        return;
    }
    
    if ([view viewWithTag:WatermarkTag]) {
        // 已经添加过水印
        return;
    }
    
    CGSize size = view.bounds.size;
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        return;
    }
    
    UIView *watermarkView = [self zh_generateWatermarkViewWithSize:size];
    [view addSubview:watermarkView];
    watermarkView.tag = WatermarkTag;
    // 监听子视图变化
    [self zh_hookSubviewChangesForView:view watermarkView:watermarkView];
}

+ (void)removeViewWatermark:(UIView *)view {
    [[view viewWithTag:WatermarkTag] removeFromSuperview];
}

#pragma mark - Private Methods

+ (instancetype)sharedHelper {
    static ZHUIWatermarkHelper *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[super allocWithZone:NULL] init];
        helper.content = @"招乎";
    });
    return helper;
}

/// 监听子视图变化
+ (void)zh_hookSubviewChangesForView:(UIView *)view watermarkView:(UIView *)watermarkView {
    __weak __typeof__(view)weakView = view;
    __weak __typeof__(watermarkView)weakWatermarkView = watermarkView;
    // 新增子视图，保持水印在最上层
    __weak id<AspectToken> token0 = [view aspect_hookSelector:@selector(didAddSubview:)
                                                  withOptions:AspectPositionAfter
                                                   usingBlock:^(id<AspectInfo> info, UIView *subview) {
        NSLog(@"zhclog %@", info.arguments);
        __strong __typeof(weakView)strongView = weakView;
        __strong __typeof(weakWatermarkView)strongWatermarkView = weakWatermarkView;
        if (strongWatermarkView && strongWatermarkView.superview && subview != strongWatermarkView) {
            [strongView bringSubviewToFront:strongWatermarkView];
        } else {
            [token0 remove];
        }
    } error:nil];
    // 没有添加子视图，但是改变了视图层级，也要处理
    [view aspect_hookSelector:@selector(bringSubviewToFront:)
                  withOptions:AspectPositionAfter
                   usingBlock:^(id<AspectInfo> info, UIView *subview) {
        if (subview != watermarkView && watermarkView.superview) {
            [view bringSubviewToFront:watermarkView];
        }
    } error:nil];
    [view aspect_hookSelector:@selector(exchangeSubviewAtIndex:withSubviewAtIndex:)
                  withOptions:AspectPositionAfter
                   usingBlock:^(id<AspectInfo> info, NSInteger idx1, NSInteger idx2) {
        if (watermarkView.superview) {
            [view bringSubviewToFront:watermarkView];
        }
    } error:nil];
}

/// 生成最终的水印视图
+ (UIView *)zh_generateWatermarkViewWithSize:(CGSize)size {
    NSString *dateStr = @"2023-11-22";
    NSString *fullContent = [NSString stringWithFormat:@"%@\n%@", [self sharedHelper].content, dateStr];
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:fullContent];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    paragraphStyle.alignment = NSTextAlignmentRight;
    [attriStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attriStr.length)];
    [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, attriStr.length)];
    [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:AccountFontSize] range:NSMakeRange(0, [self sharedHelper].content.length)];
    [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:DateFontSize] range:NSMakeRange(attriStr.length - dateStr.length, dateStr.length)];
    
    CGSize markSize = [attriStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                             options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                             context:nil].size;
    
    UIView *contentView = [[UIView alloc] initWithFrame:[self zh_realFrameWithSize:size]];
    // 从中心开始布局
    CGFloat nextX = contentView.bounds.size.width / 2 - markSize.width / 2;
    CGFloat nextY = contentView.bounds.size.height / 2 - markSize.height / 2;
    // 找到最左上方的点
    do {
        nextX -= HorzontalSpacing + markSize.width;
    } while (nextX + markSize.width > 0);
    do {
        nextY -= VerticalSpacing + markSize.height;
    } while (nextY + markSize.height > 0);
    // 标记x轴起点，用于换行
    CGFloat minX = nextX;
    do {
        CATextLayer *textLayer = [CATextLayer layer];
        textLayer.backgroundColor = UIColor.redColor.CGColor;
        textLayer.string = attriStr;
        textLayer.contentsScale = [UIScreen mainScreen].scale;
        textLayer.frame = CGRectMake(nextX, nextY, markSize.width, markSize.height);
        //                textLayer.transform = CATransform3DMakeRotation(-M_PI_4, 0, 0, 1);
        [contentView.layer addSublayer:textLayer];
        
        // 先水平方向平铺
        nextX += markSize.width + HorzontalSpacing;
        if (nextX >= contentView.bounds.size.width) {
            // 水平方向铺满，换行
            nextX = minX;
            nextY += markSize.height + VerticalSpacing;
            if (nextY >= contentView.bounds.size.height) {
                // 水平和垂直方向都超出，说明铺满了，此时结束循环
                break;
            }
        }
    } while (YES);
    contentView.transform = CGAffineTransformMakeRotation(-M_PI_4);
    
    UIView *watermarkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    // 截掉多余水印
    watermarkView.clipsToBounds = YES;
    watermarkView.userInteractionEnabled = NO;
    [watermarkView addSubview:contentView];
    
    return watermarkView;
}

/// 计算旋转之后能够覆盖水印视图的rect
+ (CGRect)zh_realFrameWithSize:(CGSize)size {
    CGFloat midX = size.width / 2;
    CGFloat midY = size.height / 2;
    CGFloat newSquareHalfWidth = (midX + midY) / sqrt(2);
    
    return CGRectMake(midX - newSquareHalfWidth, midY - newSquareHalfWidth, newSquareHalfWidth * 2, newSquareHalfWidth * 2);
}

@end



/*
 public class WaterMarkView: UIView {
     /// 水平间距
     private let horzontalSpacing: CGFloat = 70
     /// 竖直间距
     private let verticalSpacing: CGFloat = 85
     /// 旋转角度(正旋45度 || 反旋45度)
     private let rotationAngle = -(CGFloat.pi / 4.0)
     /// 水印字体大小
     private let markSize: CGFloat = 14.0
     /// 水印字体颜色
     private let markColor = UIColor(hex: "000000").withAlphaComponent(0.05)
     /// 记录第一次show时的参数
     private weak var view: UIView?
     /// 添加水印的时间
     private var time: String?
     /// 水印内容
     private var content: String?

     public private(set) lazy var waterMarkImgView: UIImageView = {
         return UIImageView(frame: self.bounds)
     }()

     public static let shared = WaterMarkView(frame: UIScreen.main.bounds)

     private override init(frame: CGRect) {
         super.init(frame: frame)
         self.addSubview(waterMarkImgView)
         waterMarkImgView.frame = frame
         // 注册通知，监听屏幕旋转
         NotificationCenter.default.addObserver(self, selector: #selector(onDidChangeStatusBarOrientation), name: UIApplication.didChangeStatusBarOrientationNotification, object: nil)
     }

     deinit {
         NotificationCenter.default.removeObserver(self)
     }
     
     @objc func onDidChangeStatusBarOrientation() {
         let frame = UIScreen.main.compatibleBounds
         self.frame = frame
         waterMarkImgView.frame = frame
         if let view = self.view, let content = self.content, let time = time {
             self.show(view: view, content: content, time: time)
         }
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

     
     /// 显示固定水印内容: name,sapId以及时间
     /// - Parameters:
     ///   - view: 待添加水印的view
     ///   - name: 姓名
     ///   - sapId: sapId
     ///   - time: 时间
     public func show(view: UIView, name: String, sapId: String, time: String) {
         self.view = view
         self.content = sapId.isEmpty ? name : "\(name)/\(sapId)"
         self.time = time
         Self.shared.waterMarkImgView.image = self.waterImage(size: view.bounds.size, content: content!, time: time)
         view.addSubview(Self.shared)
         view.bringSubviewToFront(Self.shared)
     }
     
     
     /// 显示定制水印内容+时间
     /// - Parameters:
     ///   - view: 待添加水印的view
     ///   - content: 定制水印文字
     ///   - time: 添加水印时的时间
     public func show(view: UIView, content: String, time: String) {
         self.view = view
         self.content = content
         self.time = time
         Self.shared.waterMarkImgView.image = self.waterImage(size: view.bounds.size, content: content, time: time)
         view.addSubview(Self.shared)
         view.bringSubviewToFront(Self.shared)
     }

     /// 隐藏当前水印
     public func hide() {
         // 隐藏水印时重置数据，以免出现didChangeStatusBarOrientationNotification通知时出现水印
         // 在iPad上编译，点击某人的资料页，然后点击返回，再横竖屏切换一下
         self.view = nil
         self.content = nil
         self.time = nil
         Self.shared.removeFromSuperview()
     }

     /// 生成水印图片
     private func waterImage(size: CGSize, content: String, time: String) -> UIImage? {
         let imgW: CGFloat = size.width
         let imgH: CGFloat = size.height
         // 开启上下文
         UIGraphicsBeginImageContextWithOptions(size, false, 0)

         // 文字内容
         let string1 = content
         let string2 = time
         // 绘制文字的样式
         let paragraphStyle = NSParagraphStyle.default.mutableCopy() as? NSMutableParagraphStyle
         paragraphStyle?.alignment = NSTextAlignment.center
         paragraphStyle?.lineBreakMode = .byClipping

         let attributes1 = [NSAttributedString.Key.foregroundColor: markColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: markSize), NSAttributedString.Key.paragraphStyle: paragraphStyle]
         let attributes2 = [NSAttributedString.Key.foregroundColor: markColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: markSize - 3), NSAttributedString.Key.paragraphStyle: paragraphStyle]

         let attrStr1 = NSAttributedString(string: string1, attributes: attributes1)
         let attrStr2 = NSAttributedString(string: string2, attributes: attributes2)

         // 绘制文字的宽高
         let str1Width = attrStr1.size().width
         let str1Height = attrStr1.size().height
         let str2Width = attrStr2.size().width
         let str2Height = attrStr2.size().height

         // 获取当前上下文
         guard let context = UIGraphicsGetCurrentContext() else {
             return nil
         }
         // 调整矩阵锚点到中心
         context.concatenate(CGAffineTransform(translationX: imgW * 0.5, y: imgH * 0.5))
         // 旋转矩阵
         context.concatenate(CGAffineTransform(rotationAngle: rotationAngle))
         // 恢复锚点位置到左上角
         context.concatenate(CGAffineTransform(translationX: -imgW * 0.5, y: -imgH * 0.5))

         // 对角线长度（实际绘制范围是对角线长度的正方形）
         let sqrtLength: CGFloat = sqrt(pow(imgW, 2) + pow(imgH, 2))

         // 绘制的行数和列数
         let horCount: Int = Int(sqrtLength / CGFloat(max(str1Width, str2Width) + horzontalSpacing)) + 1
         let verCount: Int = Int(sqrtLength / CGFloat((str1Height + str2Height + 5) + verticalSpacing)) + 1
         // 此处计算出需要绘制水印文字的起始点，由于水印区域要大于图片区域所以起点在原有基础上移
         let orignX: CGFloat = -(sqrtLength - imgW) / 2
         let orignY: CGFloat = -(sqrtLength - imgH) / 2
         // 在每列绘制时X坐标叠加
         var tempOrignX: CGFloat = orignX
         // 在每行绘制时Y坐标叠加
         var tempOrignY: CGFloat = orignY

         for i in 0..<horCount * verCount {
             string1.draw(in: CGRect(x: tempOrignX, y: tempOrignY, width: str1Width, height: str1Height), withAttributes: attributes1)
             string2.draw(in: CGRect(x: tempOrignX, y: tempOrignY + str2Height + 5, width: str2Width, height: str2Height), withAttributes: attributes2)
             if i % horCount == 0 {
                 // 列
                 let margin: CGFloat = (i / horCount) % 2 == 0 ? 0.0 : 60.0
                 tempOrignX = orignX + margin
                 tempOrignY += str1Height + verticalSpacing
             } else {
                 // 行
                 tempOrignX += str1Width + horzontalSpacing
             }
         }
         // 上下文获取新图片
         let newImage = UIGraphicsGetImageFromCurrentImageContext()
         // 关闭上下文
         UIGraphicsEndImageContext()

         return newImage
     }

     override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
         // 水印view不响应触摸事件
         nil
     }

 }
 
 */
