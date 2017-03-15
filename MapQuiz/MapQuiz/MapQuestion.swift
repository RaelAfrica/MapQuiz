//
//  MapQuestion.swift
//  MapQuiz
//
//  Created by Rael Kenny on 2/16/17.
//  Copyright © 2017 Rael Kenny. All rights reserved.
//



//DATA MODEL


import Foundation
import CoreLocation

class MapQuestion {
    let location:CLLocationCoordinate2D
    let regionSizeInMeters: Double
    var answers = [String:Bool]()
    
    init(location: CLLocationCoordinate2D, regionSizeInMeters:Double) {
        self.location = location
        self.regionSizeInMeters = regionSizeInMeters
    }
    
    func addAnswer(_ place: String, isCorrect:Bool) {
        answers[place] = isCorrect
    }
    
}
