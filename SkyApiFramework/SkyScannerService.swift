//
//  SkyScannerService.swift
//  SkyApiFramework
//
//  Created by Эмиль Шалаумов on 11.11.2019.
//  Copyright © 2019 Emil Shalaumov. All rights reserved.
//

import Foundation

public class SkyScannerService {
    
    //static let url = "https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/pricing/v1.0"
    static let headers = [
        "x-rapidapi-host": "skyscanner-skyscanner-flight-search-v1.p.rapidapi.com",
        "x-rapidapi-key": "0473c91308msh4e9f4a3e9566377p171c62jsnbfb50d0badbb",
        "content-type": "application/x-www-form-urlencoded"
    ]
    
    public static func getTicketList(searchParams: FlightSearchParams) {
        createSession(searchParams: searchParams) { sessionKey in
            guard let sessionKey = sessionKey else {
                return
            }
            
            let url = "https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/pricing/uk2/v1.0/" + sessionKey
            guard let serviceUrl = URL(string: url) else {
                return
            }
            
            var request = URLRequest(url: serviceUrl)
            request.allHTTPHeaderFields = self.headers
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                //print(error ?? "no error")
                //print(response ?? "no response")
                if let data = data {
                    //print(String(data: data, encoding: .utf8) ?? "no data")
                    let responseDictionary = try? JSONSerialization.jsonObject(with: data, options: .init()) as? Dictionary<String, Any>
                    
                    guard let response = responseDictionary else {
                        return
                    }
                    
                    //print(response["Query"] as? Any)
                    
                    let legs = Leg.getLegs(from: response)
                    
                    for i in legs {
                        print("\(i.key) :")
                        print("\t\(i.value.originStation.name)")
                        print("\t\(i.value.destinationStation.name)")
                        print("\t\(i.value.departure)")
                        print("\t\(i.value.arrival)")
                        print("\t\(i.value.duration)")
                        print("\t\(i.value.journeyMode)")
                        print("\t\(i.value.directionality)")
                    }
                    
                }
                }.resume()
        }
    }
    
    static func createSession(searchParams: FlightSearchParams,
                              completion: @escaping (String?) -> Void) {
        
        let url = "https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/pricing/v1.0"
        
        guard let serviceUrl = URL(string: url) else {
            return
        }
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        
        request.httpBody = searchParams.getHttpBody()
        request.allHTTPHeaderFields = self.headers
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            print(data ?? "no data")
            if let httpResponse = response as? HTTPURLResponse, let contentType = httpResponse.allHeaderFields["Location"] as? String {
                print(contentType)
                guard let range = contentType.lastIndex(of: "/") else {
                    return
                }
                
                let sessionKey = contentType[contentType.index(after:range)...]
                completion(String(sessionKey))
                return
            }
            
            print(error ?? "no error")
            completion(nil)
            }.resume()
    }
}
