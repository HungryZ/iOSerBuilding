//
//  ZHCPickerHelper.swift
//  ZHCPickerHelper
//
//  Created by cy on 2019/11/9.
//

public class ZHCPickerHelper {
    
    public enum PickerType {
        case single(dataArray: [String], confirmAction: ZHCSinglePickerView.SingleConfirmAction)
        case date(confirmAction: ZHCDatePickerView.DateConfirmAction)
        case city(confirmAction: ZHCCityPickerView.CityConfirmAction)
    }
    
    public class func show(type: PickerType) {
        switch type {
        case .single(let dataArray, let confirmAction):
            ZHCSinglePickerView().setDataArray(dataArray).show(withConfirmAction: confirmAction)
        case .date(let confirmAction):
            ZHCDatePickerView().show(withConfirmAction: confirmAction)
        case .city(let confirmAction):
            ZHCCityPickerView().show(withConfirmAction: confirmAction)
        }
    }
}
