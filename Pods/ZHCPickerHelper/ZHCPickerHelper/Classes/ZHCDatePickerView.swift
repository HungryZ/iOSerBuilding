//
//  ZHCDatePickerView.swift
//  ZHCPickerHelper
//
//  Created by cy on 2019/12/27.
//

import UIKit

public class ZHCDatePickerView: ZHCBasePickerView {
    
    public typealias DateConfirmAction = (_ year: Int, _ month: Int, _ day: Int) -> Void
    
    var confirmAction: DateConfirmAction!
    
    var isFutureEnabled = false {
        didSet {
            if isFutureEnabled {
                latestDate = Calendar.current.dateComponents([.year, .month, .day], from: Date())
            } else {
                latestDate = DateComponents()
                latestDate.year = Calendar.current.component(.year, from: Date()) + 100
                latestDate.month = 1
                latestDate.day = 1
            }
        }
    }
    
    var earliestDate: DateComponents = {
        var com = DateComponents()
        com.year = 1949
        com.month = 10
        com.day = 1
        
        return com
    }()
    
    var latestDate = Calendar.current.dateComponents([.year, .month, .day], from: Date())
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    func show(withConfirmAction action: @escaping DateConfirmAction) {
        confirmAction = action
        addSelfToKeyWindow()
        
        defaultSelectedRows = [45, 4, 0]
    }
    
    override func confirmEvent() {
        let selectedYear = (earliestDate.year ?? 1949) + pickerView.selectedRow(inComponent: 0)
        let selectedMonth = pickerView.selectedRow(inComponent: 1) + 1
        let selectedDay = pickerView.selectedRow(inComponent: 2) + 1
        confirmAction(selectedYear, selectedMonth, selectedDay)
    }
    
    override public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3
    }
    
    override public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return (latestDate.year ?? 2222) - (earliestDate.year ?? 1949) + 1
        case 1:
            let selectedYear = (earliestDate.year ?? 1949) + pickerView.selectedRow(inComponent: 0)
            if selectedYear == latestDate.year {
                return latestDate.month ?? 1
            }
            return 12
        default:
            if pickerView.selectedRow(inComponent: 1) + 1 == latestDate.month {
                return latestDate.day ?? 1
            }
            let year = (earliestDate.year ?? 1949) + pickerView.selectedRow(inComponent: 0)
            let month = pickerView.selectedRow(inComponent: 1) + 1
            return daysCount(ofYear: year, month: month)
        }
    }
    
    override public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(row + (earliestDate.year ?? 1949))"
        default:
            return "\(row + 1)"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedYear = (earliestDate.year ?? 1949) + pickerView.selectedRow(inComponent: 0)
        if selectedYear == latestDate.year {
            pickerView.reloadComponent(1)
        }
        pickerView.reloadComponent(2)
    }
    
    func daysCount(ofYear year: Int, month: Int) -> Int {
        let bigMonths = [1, 3, 5, 7, 8, 10, 12]
        let smallMonths = [4, 6, 9, 11]
        
        if bigMonths.contains(month) {
            return 31
        } else if smallMonths.contains(month) {
            return 30
        } else {
            // 2月
            return isLeapYear(year) ? 29 : 28
        }
    }
    
    /// 是否是闰年
    func isLeapYear(_ year: Int) -> Bool {
        year % 400 == 0 || (year % 4 == 0 && (year % 100 != 0))
    }
    
}
