//
//  markerInputViewController.swift
//  Run-for-Water-iOS
//
//  Created by Kieran Halliday on 2018-04-26.
//  Copyright © 2018 Kieran Halliday. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces
import GoogleMaps
import Firebase

class MarkerInputViewController: UIViewController {

	@IBOutlet weak var wellInfo: UILabel!
	
	var listOfWells: [Int: [String: Any]] = [:]
	override func viewDidLoad() {
        super.viewDidLoad()
		
		self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
		self.wellInfo.text = listOfWells[0]!["contactEmail"] as? String

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

	@IBAction func closePopUp(_ sender: Any) {
		self.view.removeFromSuperview()
	}
}
