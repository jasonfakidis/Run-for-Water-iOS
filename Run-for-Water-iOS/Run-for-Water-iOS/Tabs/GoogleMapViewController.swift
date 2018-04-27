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

class GoogleMapsViewController : UIViewController {
	
	var ref: DatabaseReference!
	var mapView = GMSMapView.map(withFrame: CGRect.zero, camera: GMSCameraPosition.camera(withLatitude: 0, longitude: 30, zoom: 1.0))
	
    override func viewDidLoad() {
        super.viewDidLoad()
		ref = Database.database().reference()
		ref.child("Wells").observe(DataEventType.value, with: { (snapshot) in
			if let snapshotValue = snapshot.value as? NSArray{
				//then I iterate over the values
				for snapDict in snapshotValue{
					//and I cast the objects to swift Dictionaries
					let dict = snapDict as? Dictionary<String, Any>
					if dict != nil{
					let marker = GMSMarker()
					marker.position = CLLocationCoordinate2D(latitude:dict?["wellLatitude"] as! CLLocationDegrees, longitude:dict?["wellLongitude"] as! CLLocationDegrees)
					marker.title = dict?["contactEmail"] as? String
					marker.snippet = dict?["wellId"] as? String
					marker.map = self.mapView
					}
				}
			}
			
		}) { (error) in
			print(error.localizedDescription)
		}
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
}
