//
//  WebViewController.swift
//  Run-for-Water-iOS
//
//  Created by Kieran Halliday on 2018-03-25.
//  Copyright © 2018 Kieran Halliday. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class myWebViewController :  UIViewController, WKUIDelegate{
	
	var webView: WKWebView!
	
	override func loadView() {
		let webConfiguration = WKWebViewConfiguration()
		webView = WKWebView(frame: .zero, configuration: webConfiguration)
		webView.uiDelegate = self
		view = webView
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let myURL = URL(string: "https://riftvalleymarathon.com/sponsor-a-well/sponsor/")
		let myRequest = URLRequest(url: myURL!)
		webView.load(myRequest)
	}
}
