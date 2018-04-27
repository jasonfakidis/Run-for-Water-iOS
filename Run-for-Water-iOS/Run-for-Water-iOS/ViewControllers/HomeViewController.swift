//
//  HomeViewController.swift

import UIKit
import Firebase
import FirebaseAuthUI
import FirebasePhoneAuthUI
import FirebaseGoogleAuthUI
import FirebaseFacebookAuthUI

class HomeViewController: UIViewController, FUIAuthDelegate {
    
    @IBAction func DisplayLogin(_ sender: UIButton) {
//        print("Button clicked");
        do {
            try authUI?.signOut()
        } catch is NSError {
            print("do it error")
        }
	
        self.authStateListenerHandle = self.auth?.addStateDidChangeListener { (auth, user) in
            guard user != nil else {
                self.loginAction(sender: self)
                return
            }
        }
        
        if(auth?.currentUser != nil){
            print("Current user is: " + (auth?.currentUser!.email)!)
            // Go to signed in page
            let storyboard = UIStoryboard(name: "LoggedIn", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LoggedInViewController") as UIViewController
            present(vc, animated: true, completion: nil)
        }
    }
    
    fileprivate(set) var auth:Auth?
    fileprivate(set) var authUI: FUIAuth? //only set internally but get externally
    fileprivate(set) var authStateListenerHandle: AuthStateDidChangeListenerHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        do {
//            try authUI?.signOut()
//        } catch is NSError {
//            print("do it error")
//        }
        self.auth = Auth.auth()
        self.authUI = FUIAuth.defaultAuthUI()
        self.authUI?.delegate = self
//        self.authUI?.providers = [FUIPhoneAuth(authUI: self.authUI!), FUIGoogleAuth(), FUIFacebookAuth() ]
		self.authUI?.providers = [FUIGoogleAuth(), FUIFacebookAuth() ]
		let phoneauth = FUIPhoneAuth(authUI: self.authUI!)
		phoneauth.signIn(withPresenting: self)
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
}

///MARK: Login Extensions
extension HomeViewController{
    @IBAction func loginAction(sender: AnyObject) {
        // Present the default login view controller provided by authUI
        let authViewController = authUI?.authViewController();
        self.present(authViewController!, animated: true, completion: nil)
    }
    
    // Implement the required protocol method for FIRAuthUIDelegate
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        guard let authError = error else {
            
            let storyboard = UIStoryboard(name: "LoggedIn", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LoggedInViewController") as UIViewController
            present(vc, animated: true, completion: nil)
            return
            
        }
        
        let errorCode = UInt((authError as NSError).code)
        
        switch errorCode {
        case FUIAuthErrorCode.userCancelledSignIn.rawValue:
            print("User cancelled sign-in");
            break
        default:
            let detailedError = (authError as NSError).userInfo[NSUnderlyingErrorKey] ?? authError
            print("Login error: \((detailedError as! NSError).localizedDescription)");
        }
    }
    
}



