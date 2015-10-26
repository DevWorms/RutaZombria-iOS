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
        
        self.Map.delegate = self
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: "handleLongPress:")
        longPressGesture.minimumPressDuration = 2.0
        self.Map.addGestureRecognizer(longPressGesture)
        
    }
    
    func handleLongPress(getstureRecognizer : UIGestureRecognizer){
        
        print("handleLongPress:")
        
        if getstureRecognizer.state != .Began { return }
        
        let touchPoint = getstureRecognizer.locationInView(self.Map)
        let touchMapCoordinate = self.Map.convertPoint(touchPoint, toCoordinateFromView: self.Map)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = touchMapCoordinate
        annotation.title = "vida"
        
        self.Map.addAnnotation(annotation)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Current location: \(locations.last?.coordinate)")
        
        locationManager.stopUpdatingLocation()
        
        let region = MKCoordinateRegion(center: (locations.last?.coordinate)!, span: span)
        Map.setRegion(region, animated: true)
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error finding location: " + error.localizedDescription)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        var pin: MKAnnotationView!
        
        if annotation.title! == "vida" {
            let reuseId = "vida"
            
            pin = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as MKAnnotationView!
            
            if pin == nil {
                pin = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pin.image = UIImage(named:"corazon")
                pin.canShowCallout = true
                
            }
            else {
                pin.annotation = annotation
            }
            
        } else {
            let reuseId = "personaje"
            
            self.pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as MKAnnotationView!
            
            if self.pinView == nil {
                self.pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                self.pinView.image = UIImage(named:"personaje04")
                self.pinView.canShowCallout = true
                
            }
            else {
                self.pinView.annotation = annotation
            }
            
            //Map.addAnnotation(self.pinView.annotation!)
            
            pin = self.pinView
            startChangingImage = true
        
        }
        
        return pin
        
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        
        
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        
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

