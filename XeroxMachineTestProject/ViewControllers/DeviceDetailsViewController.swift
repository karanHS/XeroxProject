//
//  DeviceDetailsViewController.swift
//  XeroxMachineTestProject
//
//  Created by Karan on 20/09/24.

import UIKit

class DeviceDetailsViewController: UIViewController {
    
    @IBOutlet weak var cityText: UILabel!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var ipText: UILabel!
    @IBOutlet weak var TimeZoneLabel: UILabel!
    @IBOutlet weak var CountryText: UILabel!
    @IBOutlet weak var PostalCodeText: UILabel!
    @IBOutlet weak var stacksList: UIStackView!
    @IBOutlet weak var regionText: UILabel!

    let deviceDetailViewModel = DeviceDetailsViewModel()
    var activityIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoader()
        self.stacksList.isHidden = true
        NetworkManager.shared.startMonitor()
        self.callIPDetailAPI()
    }
    
    func setActivityView(){
        activityIndicator = UIActivityIndicatorView(style: .large)
        if let activityIndicator = activityIndicator {
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.color = .gray
            self.view.addSubview(activityIndicator)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
     func callIPDetailAPI(){
        self.deviceDetailViewModel.currentIpApi { [weak self] result in
            switch result {
            case .success(let success):
                self?.getiPDetails(ipAddress: success.ip ?? "")
            case .failure(let failure):
                self?.alertController(message: failure.localizationError)
            }
        }
    }
    
     func getiPDetails(ipAddress: String){
        self.deviceDetailViewModel.getIpDetails(ipAddress: ipAddress) { [weak self] result in
            switch result {
            case .success(let success):
                self?.setUpData(details: success)
            case .failure(let failure):
                self?.alertController(message: failure.localizationError)
            }
        }
    }
    
    func alertController(message: String){
        DispatchQueue.main.async {
            self.hideLoader()
            let uialerControlelr = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            uialerControlelr.addAction(UIAlertAction(title: "Done", style: .default))
            self.present(uialerControlelr, animated: true, completion: nil)
        }
    }
    
    func setUpData(details: IpdetailsModel){
        DispatchQueue.main.async {
            self.hideLoader()
            self.stacksList.isHidden = false
            self.CountryText.text = "Country : \(details.country ?? "")"
            self.nameText.text = "Host Name : \(details.hostname ?? "")"
            self.regionText.text = "Region : \(details.region ?? "")"
            self.PostalCodeText.text = "Postal Code : \(details.postal ?? "")"
            self.cityText.text = "City : \(details.city ?? "")"
            self.TimeZoneLabel.text = "Time Zone : \(details.timezone ?? "")"
            self.ipText.text = "IP Address :  \(details.ip ?? "")"
        }
    }
    
    func showLoader() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator?.startAnimating()
            self?.view.isUserInteractionEnabled = false
        }
    }

    func hideLoader() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator?.stopAnimating()
            self?.view.isUserInteractionEnabled = true
        }
    }
}
