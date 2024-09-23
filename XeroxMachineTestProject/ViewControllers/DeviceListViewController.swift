//
//  DeviceListViewController.swift
//  XeroxMachineTestProject
//
//  Created by Karan on 20/09/24.
//

import UIKit

class DeviceListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, FindedNetworks {
   
    let deviceListViewModel: DeviceListViewModel! = DeviceListViewModel()
    
    @IBOutlet weak var deviceListTableViewCell: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.startMonitor()
        self.loadData()
    }
    
    private func loadData(){
        self.deviceListViewModel.delegate = self
        self.deviceListViewModel.fetchData()
        if self.deviceListViewModel.availableDevices.count == 0{
            self.deviceListViewModel.startMonitor()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.deviceListViewModel.availableDevices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceListTableViewCell", for: indexPath) as! DeviceListTableViewCell
        cell.selectionStyle = .none
        cell.setDeviceDatas(avalilableDevices: self.deviceListViewModel.availableDevices[indexPath.row])
        return cell
    }
    
    func reloadData() {
        self.deviceListTableViewCell.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigateToDetails()
    }
    
    func navigateToDetails(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DeviceDetailsViewController") as! DeviceDetailsViewController
        self.navigationController?.pushViewController(vc, animated: true)

    }
}
