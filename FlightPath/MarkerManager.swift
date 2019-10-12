//
//  MarkerManager.swift
//  FlightPath
//
//  Created by Bryant Gunaman on 10/11/19.
//  Copyright © 2019 Bryant Gunaman. All rights reserved.
//

import GoogleMaps


class MarkerManager {
    private static var markerArray: [GMSMarker] = []
    
    // Appends a marker to the the end of the markerArray
    public static func appendToMarkerArray(marker: GMSMarker) {
        MarkerManager.markerArray.append(marker)
    }
    
    // Removes a marker at a specified index
    public static func removeMarker(index: Int) {
        MarkerManager.markerArray.remove(at: index)
    }
    
    // Checks if a marker with a certain coordinate already exists and returns true or false with the
    // index of the marker on the markerArray
    public static func checkExistingMarker(marker: GMSMarker?) -> (Bool,Int) {
        var count: Int = 0
        guard marker != nil else {return (false, count)}
        
        for m in MarkerManager.markerArray {
            if m == marker {
                return (true,count)
            }
            count += 1
        }
        return (false,count)
    }
    
    public static func getCoordinateArray() -> [CLLocationCoordinate2D]{
        return MarkerManager.markerArray.map({$0.position})
    }
    
}
