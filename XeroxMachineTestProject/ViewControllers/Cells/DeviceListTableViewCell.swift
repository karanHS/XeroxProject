//
//  DeviceListTableViewCell.swift
//  XeroxMachineTestProject
//
//  Created by Karan on 20/09/24.
//

import UIKit

class DeviceListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var ipAddressText: UILabel!
    @IBOutlet weak var statusText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setDeviceDatas(avalilableDevices:DeviceListModel){
        self.nameText.text = avalilableDevices.name
        self.ipAddressText.text = avalilableDevices.ipaddreess
        self.statusText.text = "Status : \(avalilableDevices.status ?? "")"
    }
}
