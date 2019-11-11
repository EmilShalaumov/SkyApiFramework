//
//  Leg.swift
//  SkyApiFramework
//
//  Created by Эмиль Шалаумов on 11.11.2019.
//  Copyright © 2019 Emil Shalaumov. All rights reserved.
//

import Foundation

class Leg {
    
    let originStation: Place
    let destinationStation: Place
    let departure: Date
    let arrival: Date
    let duration: UInt
    let journeyMode: String
    let directionality: String
    
    init(originStation: Place,
         destinationStation: Place,
         departure: Date,
         arrival: Date,
         duration: UInt,
         journeyMode: String,
         directionality: String) {
        self.originStation = originStation
        self.destinationStation = destinationStation
        self.departure = departure
        self.arrival = arrival
        self.duration = duration
        self.journeyMode = journeyMode
        self.directionality = directionality
    }
    
    static func getLegs(from data: Dictionary<String, Any>) -> [String: Leg] {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        var legs: [String: Leg] = [:]
        
        if let placesDictionary = data["Places"] as? [Any], let legsDictionary = data["Legs"] as? [Any] {
            let places = Place.getPlaces(from: placesDictionary)
            
            for legData in legsDictionary {
                if let legData = legData as? Dictionary<String, Any>,
                    let origin = legData["OriginStation"] as? UInt,
                    let originStation = places[origin],
                    let destination = legData["DestinationStation"] as? UInt,
                    let destinationStation = places[destination] {
                    
                    let legId = legData["Id"] as? String ?? ""
                    let departure = dateFormatter.date(from: legData["Departure"] as? String ?? "") ?? Date()
                    let arrival = dateFormatter.date(from: legData["Arrival"] as? String ?? "") ?? Date()
                    let duration = legData["Duration"] as? UInt ?? 0
                    let journeyMode = legData["JourneyMode"] as? String ?? ""
                    let directionality = legData["Directionality"] as? String ?? ""
                    
                    legs[legId] = Leg(originStation: originStation,
                                      destinationStation: destinationStation,
                                      departure: departure,
                                      arrival: arrival,
                                      duration: duration,
                                      journeyMode: journeyMode,
                                      directionality: directionality)
                }
            }
        }
        
        return legs
    }
}
