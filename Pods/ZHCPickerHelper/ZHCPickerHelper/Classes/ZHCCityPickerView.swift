//
//  ZHCCityPickerView.swift
//  ZHCPickerHelper
//
//  Created by cy on 2019/12/23.
//  Copyright © 2019 cy. All rights reserved.
//

import UIKit

public class ZHCCityPickerView: ZHCBasePickerView {
    
    public typealias CityConfirmAction = ((_ province: RegionModel, _ city: RegionModel, _ district: RegionModel) -> Void)
    
    var confirmAction: CityConfirmAction!
    
    let sourceArray: [ProvinceModel]
    
    var dataArrayWithModel: [[RegionModel]] {
        didSet {
            setBaseDataArray(dataArrayWithModel)
        }
    }
    
    var selectedProvinceRow = 0
    var selectedCityRow     = 0
    var selectedDistrictRow = 0
    
    public override init(frame: CGRect) {
        
        // https://www.jianshu.com/p/4188b6447d56
        let bundleURL = Bundle.main.url(forResource: "ZHCPickerHelper", withExtension: "bundle")!
        let bundle = Bundle(url: bundleURL)!
        let path = bundle.path(forResource: "city", ofType: "json")!
        let dataString = try! String(contentsOfFile: path, encoding: .utf8)
        let data = dataString.data(using: .utf8)!
        
        sourceArray = try! JSONDecoder().decode([ProvinceModel].self, from: data)
        let cityArray = sourceArray[0].cityList
        let districtArray = cityArray[0].areaList
        
        dataArrayWithModel = [sourceArray, cityArray, districtArray]
        
        super.init(frame: UIScreen.main.bounds)
        
        setBaseDataArray(dataArrayWithModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func show(withConfirmAction action: @escaping CityConfirmAction) {
        confirmAction = action
        addSelfToKeyWindow()
    }
    
    override public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        36
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let title = dataArrayWithModel[component][row].name
        
        if let label = view as? UILabel {
            label.text = title
            return label
        } else {
            let label = UILabel()
            label.font = .systemFont(ofSize: 16)
            label.text = title
            label.textAlignment = .center
            return label
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let row0 = pickerView.selectedRow(inComponent: 0)
        let row1 = pickerView.selectedRow(inComponent: 1)
        let row2 = pickerView.selectedRow(inComponent: 2)
        
        if row0 != selectedProvinceRow {
            dataArrayWithModel[1] = sourceArray[row0].cityList
            dataArrayWithModel[2] = sourceArray[row0].cityList[0].areaList
            pickerView.reloadComponent(1)
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 1, animated: true)
            pickerView.selectRow(0, inComponent: 2, animated: true)
            selectedProvinceRow = row0
        }
        if row1 != selectedCityRow {
            dataArrayWithModel[2] = sourceArray[row0].cityList[row1].areaList
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)
            selectedCityRow = row1
        }
        if row2 != selectedDistrictRow {
            selectedDistrictRow = row2
        }
    }
    
    override func confirmEvent() {
        
        let provinceModel = dataArrayWithModel[0][selectedProvinceRow]
        let cityModel = dataArrayWithModel[1][selectedCityRow]
        
        let provinceRegion = RegionModel(code: provinceModel.code, name: provinceModel.name)
        let cityRegion     = RegionModel(code: cityModel.code, name: cityModel.name)
        let districtRegion = dataArrayWithModel[2][selectedDistrictRow]

        confirmAction(provinceRegion, cityRegion, districtRegion)
    }
}
