//
//  ImageTableViewCell.swift
//  iOSerBuilding
//
//  Created by 张海川 on 2021/8/6.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    lazy var imageView1: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 50))
        view.layer.cornerRadius = 6;
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var imageView2: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 90, y: 0, width: 80, height: 50))
        view.layer.cornerRadius = 6;
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var imageView3: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 180, y: 0, width: 80, height: 50))
        view.layer.cornerRadius = 6;
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var imageView4: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 270, y: 0, width: 80, height: 50))
        view.layer.cornerRadius = 6;
        view.clipsToBounds = true
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(imageView1)
        contentView.addSubview(imageView2)
        contentView.addSubview(imageView3)
        contentView.addSubview(imageView4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
