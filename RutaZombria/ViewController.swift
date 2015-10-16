//
//  ViewController.swift
//  RutaZombria
//
//  Created by Emmanuel Valentín Granados López on 15/10/15.
//  Copyright © 2015 DevWorms. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var Map: MKMapView!
    var annotation = MKPointAnnotation()
    let locationManager = CLLocationManager()
    var span = MKCoordinateSpanMake(0.02, 0.02)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization() //requestWhenInUseAuthorization() NSLocationWhenInUseUsageDescription in .plist
        locationManager.startUpdatingLocation()
        
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Current location lon: \(locations.last?.coordinate.longitude)")
        print("Current location lat: \(locations.last?.coordinate.latitude)")
        
        locationManager.stopUpdatingLocation()
        
        let region = MKCoordinateRegion(center: (locations.last?.coordinate)!, span: span)
        
        Map.setRegion(region, animated: true)
        
        annotation.coordinate = CLLocationCoordinate2DMake(
                                        (locations.last?.coordinate.latitude)!,
                                        (locations.last?.coordinate.longitude)!   )
        annotation.title = "Me"
        annotation.subtitle = "vale me"
        
        Map.addAnnotation(annotation)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error finding location: " + error.localizedDescription)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

