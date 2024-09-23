//
//  LoginViewModel.swift
//  XeroxMachineTestProject
//
//  Created by Karan on 20/09/24.
//

import GoogleSignIn
import Foundation
import UIKit

class LoginViewModel{
    
    var onLogout: (() -> Void)?
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.networkNotReachable), name: .networkNotReachable, object: nil)
    }
    
    @objc private func networkNotReachable(){
        self.logout()
    }
    
    func logout(){
        GIDSignIn.sharedInstance.signOut()
        self.onLogout?()
    }
    
    func googleSinginAction(viewController: UIViewController, completionHandler: @escaping (GIDGoogleUser?,Error?) -> ()){
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { user, error in
            guard error == nil else{
                completionHandler(nil, error)
                return
            }
            guard let users = user?.user else{
                return
            }
            completionHandler(users, nil)
        }
    }
   
    func isAlreadyUsedSignedIn(completion: @escaping(Bool) -> ()){
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil {
                completion(false)
            }else{
                completion(true)
            }
        }
    }
}
