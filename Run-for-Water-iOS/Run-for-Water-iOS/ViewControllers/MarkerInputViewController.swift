//
//  markerInputViewController.swift
//  Run-for-Water-iOS
//
//  Created by Kieran Halliday on 2018-04-26.
//  Copyright © 2018 Kieran Halliday. All rights reserved.
//

import UIKit

class MarkerInputViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)

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
