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
    var startChangingImage: Bool!
    var coord1: CLLocation!
    var imagesPersonaje = ["personaje01","personaje02","personaje03","personaje04"]
    var numOfImage = 0
    var ladoRecorrerArray: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //locationManager.requestAlwaysAuthorization() //requestWhenInUseAuthorization() NSLocationWhenInUseUsageDescription in .plist
        locationManager.startUpdatingLocation()
        
        startChangingImage = false
        coord1 = CLLocation(latitude: 0.0, longitude: 0.0)
        self.ladoRecorrerArray = false
        
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
        
        let reuseId = "personaje"
        
        pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as MKAnnotationView!
        
        if pinView == nil {
            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView.image = UIImage(named:"personaje04")
            pinView.canShowCallout = true
           
        }
        else {
            pinView.annotation = annotation
        }
        
        //Map.addAnnotation(pinView.annotation!)
        print("holajaja")
        startChangingImage = true
        
        return pinView
        
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        
        
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        /*
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
        [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
        
        // Add an annotation
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = userLocation.coordinate;
        point.title = @"Where am I?";
        point.subtitle = @"I'm here!!!";
        
        [self.mapView addAnnotation:point];
        
        */
        
        let coord = userLocation.location
        
        if self.startChangingImage == true {
            if coord!.distanceFromLocation(coord1) > 0.01 {
                print ("hola 0,01: \(numOfImage)")
                
                self.pinView.image = UIImage(named: imagesPersonaje[numOfImage])
                self.coord1 = coord
                
                //recorrer de izq a der, y de der a izq spriteSheet
                if (self.numOfImage < 3) && (self.ladoRecorrerArray == false) {
                    self.numOfImage++
                    
                    if self.numOfImage == 3 {
                        self.ladoRecorrerArray = true
                    }
                }else{
                    self.numOfImage--
                    
                    if self.numOfImage == 0 {
                        self.ladoRecorrerArray = false
                    }
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

