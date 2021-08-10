//
//  ImageImproveViewController.swift
//  iOSerBuilding
//
//  Created by 张海川 on 2021/8/6.
//

import UIKit
import Kingfisher

class ImageImproveViewController: UIViewController {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 50, y: 200, width: 60, height: 60))
        
        let path = Bundle.main.path(forResource: "IMG_5851", ofType: "HEIC")!
        let url = URL(fileURLWithPath: path)
        imageView.image = downsample(imageAt: url, to: CGSize(width: 60, height: 60), scale: 1)
//        // http://pic.jj20.com/up/allimg/tp09/210H51RQ4Nb-0.jpg
//        imageView.kf.setImage(with: URL(string: "http://pic.jj20.com/up/allimg/tp09/210H51RQ4Nb-0.jpg"))
//        imageView.image = UIImage(named: "IMG_5851.HEIC")
        
        return imageView
    }()
    
    lazy var imageView2: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 120, y: 200, width: 60, height: 60))
        
//        let path = Bundle.main.path(forResource: "IMG_5851", ofType: "HEIC")!
        let url = URL(string: "http://pic.jj20.com/up/allimg/tp09/210H51RQ4Nb-0.jpg")!
        imageView.image = downsample(imageAt: url, to: CGSize(width: 60, height: 60), scale: 1)
        
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
//        view.addSubview(imageView2)
    }
    
    func downsample(imageAt imageURL: URL, to pointSize: CGSize, scale: CGFloat) -> UIImage {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, imageSourceOptions)!
        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
        let downsampleOptions = [kCGImageSourceCreateThumbnailFromImageAlways: true,
                                 kCGImageSourceShouldCacheImmediately: true,
                                 kCGImageSourceCreateThumbnailWithTransform: true,
                                 kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels] as CFDictionary
        let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions)!
        return UIImage(cgImage: downsampledImage)
    }
}
