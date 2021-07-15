//
//  RegionModel.swift
//  ZHCPickerHelper
//
//  Created by cy on 2019/12/23.
//  Copyright © 2019 cy. All rights reserved.
//

public class RegionModel: Codable {

    let code: String
    let name: String
    
    init(code: String, name: String) {
        self.code = code
        self.name = name
    }
}

class CityModel: RegionModel {
    
    let areaList: [RegionModel]
    
    enum CodingKeys: String, CodingKey {
        case code
        case name
        case areaList
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        areaList = try container.decode([RegionModel].self, forKey: .areaList)
        
        try super.init(from: decoder)
    }
}

class ProvinceModel: RegionModel {
    
    let cityList: [CityModel]
    
    enum CodingKeys: String, CodingKey {
        case code
        case name
        case cityList
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cityList = try container.decode([CityModel].self, forKey: .cityList)
        
        try super.init(from: decoder)
    }
}
