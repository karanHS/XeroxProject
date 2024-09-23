//
//  LoginViewController.swift
//  XeroxMachineTestProject
//
//  Created by Karan on 19/09/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    var loginViewModel = LoginViewModel()
    
    @IBOutlet weak var signInOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
    func setUpUI(){
        self.signInOutlet.layer.cornerRadius = self.signInOutlet.layer.frame.height/2
    }
    
    @IBAction func signInAction(_ sender: Any) {
        self.loginViewModel.googleSinginAction(viewController: self) { user, error in
            if error == nil && user != nil{
                print(user!)
                self.navigateToDeviceListDashBoardScreen()
            }
            else{
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    func navigateToDeviceListDashBoardScreen(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DeviceListViewController") as? DeviceListViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
