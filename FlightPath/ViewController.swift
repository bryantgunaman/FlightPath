//
//  ViewController.swift
//  FlightPath
//
//  Created by Bryant Gunaman on 10/11/19.
//  Copyright © 2019 Bryant Gunaman. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON

class MainViewController: UIViewController, ViewControllerTemplate, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    // API key for iOS SDK
    private let mapAPIKey: String = {
        return ""
    }()
    
  
    // Constant camera zoom level
    private let cameraZoom: Float = {
        return 17.0
    }()
    
    // Location manager
    private var locationManager: CLLocationManager = {
       return CLLocationManager()
    }()
    
    // Select Button
    private let drawButton: UIButton = {
        let button = UIButton()
        button.setTitle("Draw", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    // Camera of view
    private var camera: GMSCameraPosition?
    
    // Mapview of view 
    private var mapView: GMSMapView?

    // MainViewController's viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.provideAPIKey(apiKey: self.mapAPIKey)
        self.setupLocationManager()
        self.setCameraToCurrentLocation()
        self.setupMapView()
        self.setupTargets()
        self.addSubViews()
        self.setupSubviews()
    }
    
    
    private func provideAPIKey(apiKey: String) {
        GMSServices.provideAPIKey(self.mapAPIKey)
    }
    
    // Get the current lattitude, make sure that it is not nil
    private func getCurrentLattitude() -> CLLocationDegrees {
        return (self.locationManager.location?.coordinate.latitude)!
    }
    
    // Get the current longtitude, make sure that it is not nil
    private func getCurrentLongtitude() -> CLLocationDegrees {
        return (self.locationManager.location?.coordinate.longitude)!
    }
    
    // Sets the locationManager's delegate to self and starts updating location
    private func setupLocationManager() {
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }
    
    // Sets the mapview and enables the user's location
    private func setupMapView() {
        self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: self.camera!)
        self.mapView?.delegate = self
        self.view = mapView
        self.mapView!.isMyLocationEnabled = true
        
    }
    
    // Sets the camera to the current location
    private func setCameraToCurrentLocation() {
        self.camera = GMSCameraPosition.camera(withLatitude:self.getCurrentLattitude(), longitude: self.getCurrentLongtitude(), zoom: 17.0)
    }
    
    func setupTargets() {
        self.drawButton.addTarget(self, action: #selector(handleDrawButton), for: .touchUpInside)
    }
    
    @objc func handleDrawButton() {
        let coordinatesArray = MarkerManager.getCoordinateArray()
        guard coordinatesArray.count > 1 else {return}
        print("coordinates array:" , coordinatesArray)
        self.drawpath(positions: coordinatesArray)
    }
    
    func addSubViews() {
        self.view.addSubview(self.drawButton)
    }
    
    func setupSubviews() {
        self.drawButton.anchorBounds(top: self.view.topAnchor, leading: nil, trailing: self.view.trailingAnchor, bottom: nil,  padding: Padding(top: 60, right: 15))
        
    }
    
    // Handles detecting current location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last

        self.camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)

        self.mapView!.animate(to: self.camera!)

        //Stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
    }
    
    // Handles long tap by placing a marker on the map
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        marker.title = "Marker Name"
        marker.map = mapView
        MarkerManager.appendToMarkerArray(marker: marker)
    }
    
    
    func drawpath(positions: [CLLocationCoordinate2D]) {
        let origin = positions.first!
        let destination = positions.last!
        var wayPoints = ""
        for point in positions {
            wayPoints = wayPoints.count == 0 ? "\(point.latitude),\(point.longitude)" : "\(wayPoints)%7C\(point.latitude),\(point.longitude)"
        }
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin.latitude),\(origin.longitude)&destination=\(destination.latitude),\(destination.longitude)&mode=driving&waypoints=\(wayPoints)&key=\(self.mapAPIKey)"
        AF.request(url).responseJSON { response in
            
            print(response.request as Any)  // original URL request
            print(response.response as Any) // HTTP URL response
            print(response.data as Any)     // server data
            print(response.result as Any)   // result of response serialization
            
            let json = try!  JSON(data: response.data!)
            let routes = json["routes"][0]["overview_polyline"]["points"].stringValue
            
            let path = GMSPath.init(fromEncodedPath: routes)
            let polyline = GMSPolyline.init(path: path)
            polyline.strokeWidth = 4
            polyline.strokeColor = UIColor.red
            polyline.map = self.mapView
        }
    }

}

