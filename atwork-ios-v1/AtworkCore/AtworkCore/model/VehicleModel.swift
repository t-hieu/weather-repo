//
//  VehicleModel.swift
//  AtworkCore
//
//  Created by CuongNV on 10/10/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import ObjectMapper

public class VehicleModel: ATBaseModel {
    var key: Int!
    var value: String!
    var number: Int! = 0
    
    
    override init() {
        super.init()
    }
//
    public required init?(map: Map) {
        super.init(map: map)
//        self.mapping(map: map)
//        fatalError("init(map:) has not been implemented")
    }
    override public func mapping(map: Map) {
        self.key <- map["vehicleId"]
        self.value <- map["vehicleName"]
        self.number <- map["quantity"]
    }
    
    public required init?(key : String, value : String) {
        super.init()
        self.key = Int(key)
        self.value = value
    }

    public func setValue(key: String, value: String){
        self.value = value
        self.key = Int(key)
    }
    
    public func copyOther(vehicle: VehicleModel) -> VehicleModel{
        self.key = vehicle.key
        self.value = vehicle.value
        self.number = vehicle.number
        return self
    }
}
