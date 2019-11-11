//
//  Place.swift
//  SkyApiFramework
//
//  Created by Эмиль Шалаумов on 11.11.2019.
//  Copyright © 2019 Emil Shalaumov. All rights reserved.
//

import Foundation

class Place {
    
    let parentPlace: Place?
    let code: String
    let type: String
    let name: String
    
    init(parentPlace: Place? = nil, code: String, type: String, name: String) {
        self.parentPlace = parentPlace
        self.code = code
        self.type = type
        self.name = name
    }
    
    init() {
        self.parentPlace = nil
        self.code = ""
        self.type = ""
        self.name = ""
    }
    
    static func getPlaces(from data: [Any]) -> [UInt: Place] {
        var places: [UInt: Place] = [:]
        
        for i in stride(from: data.count - 1, to: 0, by: -1) {
            if let placeData = data[i] as? Dictionary<String, Any> {
                let placeId = placeData["Id"] as? UInt ?? 0
                let parentId = placeData["ParentId"] as? UInt
                let code = placeData["Code"] as? String ?? ""
                let type = placeData["Type"] as? String ?? ""
                let name = placeData["Name"] as? String ?? ""
                
                var parent: Place? = nil
                if let id = parentId {
                    parent = places[id]
                }
                
                places[placeId] = Place(parentPlace: parent, code: code, type: type, name: name)
            }
        }
        
        return places
    }
}
