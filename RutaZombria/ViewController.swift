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

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var Map: MKMapView!
    //var annotation = MKPointAnnotation()
    let locationManager = CLLocationManager()
    var span = MKCoordinateSpanMake(0.02, 0.02)
    var pinView: MKAnnotationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //locationManager.requestAlwaysAuthorization() //requestWhenInUseAuthorization() NSLocationWhenInUseUsageDescription in .plist
        locationManager.startUpdatingLocation()
        
        Map.delegate = self
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Current location lon: \(locations.last?.coordinate.longitude)")
        print("Current location lat: \(locations.last?.coordinate.latitude)")
        
        locationManager.stopUpdatingLocation()
        
        let region = MKCoordinateRegion(center: (locations.last?.coordinate)!, span: span)
        
        Map.setRegion(region, animated: true)
        
        /*annotation.coordinate = CLLocationCoordinate2DMake(
                                        (locations.last?.coordinate.latitude)!,
                                        (locations.last?.coordinate.longitude)!   )
        annotation.title = "Me"
        annotation.subtitle = "vale me"
        
        Map.addAnnotation(annotation)*/
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error finding location: " + error.localizedDescription)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "zombie"
        
        pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as MKAnnotationView!
        
        if pinView == nil {
            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView.image = UIImage(named:"zombie")
            pinView.canShowCallout = true
           
        }
        else {
            pinView.annotation = annotation
        }
        
        //Map.addAnnotation(pinView.annotation!)
        
        return pinView
        
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        
        
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

