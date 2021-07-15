//
//  ZHCSinglePickerView.swift
//  ZHCPickerHelper
//
//  Created by cy on 2019/12/27.
//  Copyright © 2019 cy. All rights reserved.
//

import UIKit

public class ZHCSinglePickerView: ZHCBasePickerView {
    
    public typealias SingleConfirmAction = (_ index: Int, _ value: String) -> Void
    
    var confirmAction: SingleConfirmAction!
    
    @discardableResult
    func setDataArray(_ array: [String]) -> ZHCSinglePickerView {
        setBaseDataArray([array])
        return self
    }
    
    func show(withConfirmAction action: @escaping SingleConfirmAction) {
        confirmAction = action
        addSelfToKeyWindow()
    }
    
    override func confirmEvent() {
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        confirmAction(selectedRow, dataArray[0][selectedRow] as! String)
    }
}
