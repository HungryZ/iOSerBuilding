//
//  OffScreenRenderedController.swift
//  iOSerBuilding
//
//  Created by 张海川 on 2020/7/27.
//

import UIKit

class OffScreenRenderedController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         关于圆角，iOS 9及之后的系统版本，苹果进行了一些优化。

         layer.contents/imageView.image
         我们只设置contents或者UIImageView的image，并加上圆角+裁剪，是不会产生离屏渲染的。但如果加上了背景色、边框或其他有图像内容的图层，还是会产生离屏渲染。
         */

        // Do any additional setup after loading the view.
//        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: 200.0, height: 200.0))
//        // 设置背景色
////        view1.backgroundColor = UIColor.red
//        // 设置边框宽度和颜色
////        view1.layer.borderWidth = 2.0
////        view1.layer.borderColor = UIColor.black.cgColor
//        //设置图片
//        view1.layer.contents = UIImage(named: "minions")?.cgImage
//        // 设置圆角
//        view1.layer.cornerRadius = 100.0
//
//        // 设置裁剪
//        view1.clipsToBounds = true;
//
//        view1.center = view.center
//        view.addSubview(view1)
        

        view.backgroundColor = UIColor.white
        // 创建一个button视图
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200.0, height: 200.0))
        //设置图片
        button.setImage(UIImage(named: "minions"), for: .normal)
//        // 设置圆角
//        button.layer.cornerRadius = 100.0
//        // 设置裁剪
//        button.clipsToBounds = true
        // 设置圆角
        button.imageView?.layer.cornerRadius = 100.0
        // 设置裁剪
        button.imageView?.clipsToBounds = true
        
        button.center = view.center
        view.addSubview(button)
    }

}
