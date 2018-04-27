//
//  GoogleMapViewController.swift
//  Run-for-Water-iOS
//
//  Created by Halliday, Kieran on 2018-03-23.
//  Copyright © 2018 Kieran Halliday. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces
import GoogleMaps
import Firebase

class GoogleMapsViewController : UIViewController, GMSMapViewDelegate {
	
	var ref: DatabaseReference!
	var dict: Dictionary<String, Any>!
	var mapView = GMSMapView.map(withFrame: CGRect.zero, camera: GMSCameraPosition.camera(withLatitude: 0, longitude: 30, zoom: 1.0))
	
    override func viewDidLoad() {
        super.viewDidLoad()
		ref = Database.database().reference()
		ref.child("Wells").observe(DataEventType.value, with: { (snapshot) in
			if let snapshotValue = snapshot.value as? NSArray{
				//then I iterate over the values
				for snapDict in snapshotValue{
					//and I cast the objects to swift Dictionaries
					self.dict = snapDict as? Dictionary<String, Any>
					if self.dict != nil{
					let marker = GMSMarker()
					marker.position = CLLocationCoordinate2D(latitude:self.dict?["wellLatitude"] as! CLLocationDegrees, longitude:self.dict?["wellLongitude"] as! CLLocationDegrees)
					marker.title = self.dict?["contactEmail"] as? String
					marker.snippet = self.dict?["wellId"] as? String
					marker.map = self.mapView
					}
				}
			}
			
		}) { (error) in
			print(error.localizedDescription)
		}
		
		mapView.delegate = self
		self.view = mapView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	override func loadView() {
            mapView.settings.compassButton = true
            mapView.settings.myLocationButton = true
            mapView.settings.setAllGesturesEnabled(true)
            mapView.settings.zoomGestures = true
            view = mapView
	}
	
	// MARK: GMSMapViewDelegate
	
	func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
		print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
	}
	
	func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
		print("You tapped at \(marker.position.latitude), \(marker.position.longitude)")
		
		// Display pop-up
		let popUpViewController = UIStoryboard(name: "LoggedIn", bundle: nil).instantiateViewController(withIdentifier: "inputMapDataID") as! MarkerInputViewController
		self.addChildViewController(popUpViewController)
		popUpViewController.view.frame = self.view.frame
		self.view.addSubview(popUpViewController.view)
		popUpViewController.didMove(toParentViewController: self)
		
		
		if(self.dict?["contactEmail"] as? String == Auth.auth().currentUser?.email) {
			print("MATCH")
		}
		print("NO MATCH")
		return true
	}
	
	func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
		print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
		let marker = GMSMarker(position: coordinate)
		marker.title = "Hello World"
		marker.map = mapView

	}
}
