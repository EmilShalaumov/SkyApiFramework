//
//  FlightSearchparams.swift
//  SkyApiFramework
//
//  Created by Эмиль Шалаумов on 11.11.2019.
//  Copyright © 2019 Emil Shalaumov. All rights reserved.
//

import Foundation

public struct FlightSearchParams {
    
    private let country: String
    private let currency: String
    private let locale: String
    private let originPlace: String
    private let destinationPlace: String
    private let outboundDate: String
    private let adults: UInt
    
    private let inboundDate: String?
    private let cabinClass: String?
    private let children: UInt?
    private let infants: UInt?
    private let includeCarriers: String?
    private let excludeCarriers: String?
    private let groupPricing: String?
    
    init(country: String,
         currency: String,
         locale: String,
         originPlace: String,
         destinationPlace: String,
         outboundDate: String,
         adults: UInt,
         inboundDate: String? = nil,
         cabinClass: String? = nil,
         children: UInt? = nil,
         infants: UInt? = nil,
         includeCarriers: String? = nil,
         excludeCarriers: String? = nil,
         groupPricing: String? = nil) {
        
        self.country = country
        self.currency = currency
        self.locale = locale
        self.originPlace = originPlace
        self.destinationPlace = destinationPlace
        self.outboundDate = outboundDate
        self.adults = adults
        self.inboundDate = inboundDate
        self.cabinClass = cabinClass
        self.children = children
        self.infants = infants
        self.includeCarriers = includeCarriers
        self.excludeCarriers = excludeCarriers
        self.groupPricing = groupPricing
    }
    
    func getHttpBody() -> Data {
        let postData = NSMutableData(data: "country=\(country)".data(using: String.Encoding.utf8)!)
        
        postData.append("&currency=\(currency)".data(using: String.Encoding.utf8)!)
        postData.append("&locale=\(locale)".data(using: String.Encoding.utf8)!)
        postData.append("&originPlace=\(originPlace)".data(using: String.Encoding.utf8)!)
        postData.append("&destinationPlace=\(destinationPlace)".data(using: String.Encoding.utf8)!)
        postData.append("&outboundDate=\(outboundDate)".data(using: String.Encoding.utf8)!)
        postData.append("&adults=\(adults)".data(using: String.Encoding.utf8)!)
        
        if let inboundDate = inboundDate {
            postData.append("&inboundDate=\(inboundDate)".data(using: .utf8)!)
        }
        if let cabinClass = cabinClass {
            postData.append("&cabinClass=\(cabinClass)".data(using: .utf8)!)
        }
        if let children = children {
            postData.append("&children=\(children)".data(using: .utf8)!)
        }
        if let infants = infants {
            postData.append("&infants=\(infants)".data(using: .utf8)!)
        }
        if let includeCarriers = includeCarriers {
            postData.append("&includeCarriers=\(includeCarriers)".data(using: .utf8)!)
        }
        if let excludeCarriers = excludeCarriers {
            postData.append("&excludeCarriers=\(excludeCarriers)".data(using: .utf8)!)
        }
        if let groupPricing = groupPricing {
            postData.append("&groupPricing=\(groupPricing)".data(using: .utf8)!)
        }
        
        return postData as Data
    }
}
