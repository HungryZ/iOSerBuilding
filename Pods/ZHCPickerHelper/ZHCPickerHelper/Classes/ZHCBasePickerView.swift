//
//  ZHCBasePickerView.swift
//  ZHCPickerHelper
//
//  Created by cy on 2019/12/27.
//  Copyright © 2019 cy. All rights reserved.
//

import UIKit

public class ZHCBasePickerView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let kStatusHeight = UIApplication.shared.statusBarFrame.size.height
    let kScreenWidth = UIScreen.main.bounds.width
    let kScreenHeight = UIScreen.main.bounds.height
    lazy var kNaviHeight = kStatusHeight + 44
    lazy var kBottomSafeHeight: CGFloat = kStatusHeight > 21 ? 34 : 0
    
    var defaultSelectedRows = [0]
    
    var defaultRowHeight: CGFloat = 44
    
    private(set) var dataArray = [[Any]]()
    
    let baseView = UIView()
    
    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        picker.backgroundColor = .white
        
        return picker
    }()
    
    lazy var confirmButton = button(title: "确定", titleColor: .white, font: 18, backgroundColor: .cyan, target: self, action: #selector(confirmBtnClicked))
    
    lazy var cancelButton = button(title: "取消", titleColor: .white, font: 18, backgroundColor: .cyan, target: self, action: #selector(cancelBtnClicked))
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        addSubview(baseView)
        baseView.addSubview(pickerView)
        baseView.addSubview(cancelButton)
        baseView.addSubview(confirmButton)
        
        baseView.frame = CGRect(x: 0, y: kScreenHeight - kBottomSafeHeight - (48 + 216), width: kScreenWidth, height: 48 + 216)
        cancelButton.frame = CGRect(x: 0, y: 0, width: kScreenWidth / 2, height: 48)
        confirmButton.frame = CGRect(x: kScreenWidth / 2, y: 0, width: kScreenWidth / 2, height: 48)
        pickerView.frame = CGRect(x: 0, y: 48, width: kScreenWidth, height: 216)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        for (index, row) in defaultSelectedRows.enumerated() {
            if index > pickerView.numberOfComponents - 1 {
                return
            }
            pickerView.selectRow(row, inComponent: index, animated: false)
        }
    }
    
    // MARK: - UIPickerViewProtocol
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        dataArray.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        dataArray[component].count
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        defaultRowHeight
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        dataArray[component][row] as? String
    }
    
    // MARK: - Button Action
    
    @objc func confirmBtnClicked() {
        confirmEvent()
        removeSelf()
    }
    
    @objc func cancelBtnClicked() {
        cancelEvent()
        removeSelf()
    }
    
    func confirmEvent() {}
    
    func cancelEvent() {}
    
    // MARK: - Methods
    
    func setBaseDataArray(_ array: [[Any]]) {
        dataArray = array
    }
    
    func addSelfToKeyWindow() {
        if let view = UIApplication.shared.keyWindow {
            addSelf(to: view)
        }
    }
    
    func addSelf(to view: UIView) {
        view.addSubview(self)
        alpha = 0
        
        let orginalTop = baseView.top
        baseView.top = kScreenHeight
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
            self.baseView.top = orginalTop
        }
    }
    
    func removeSelf() {
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0
            self.baseView.top = self.kScreenHeight
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    private func button(title: String? = nil,
                        titleColor: UIColor? = nil,
                        font: Any? = nil,
                        cornerRadius: CGFloat? = nil,
                        backgroundColor: UIColor? = nil,
                        target: Any? = nil,
                        action: Selector? = nil) -> UIButton {
        
        let button = UIButton(type: .custom)
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        
        if font is Int {
            button.titleLabel?.font = .systemFont(ofSize: CGFloat(font as! Int))
        } else if font is Double {
            button.titleLabel?.font = .systemFont(ofSize: CGFloat(font as! Double))
        } else if font is CGFloat {
            button.titleLabel?.font = .systemFont(ofSize: font as! CGFloat)
        } else if font is UIFont {
            button.titleLabel?.font = font as? UIFont
        }
        
        if let radius = cornerRadius, radius > 0 {
            layer.cornerRadius = radius
        }
        button.backgroundColor = backgroundColor
        
        if target != nil && action != nil {
            button.addTarget(target, action: action!, for: .touchUpInside)
        }
        
        return button
    }
}

fileprivate extension UIView {

    var top: CGFloat {
        get {
            frame.origin.y
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
}
