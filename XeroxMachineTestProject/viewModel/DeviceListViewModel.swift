//
//  DeviceListViewModel.swift
//  XeroxMachineTestProject
//
//  Created by Karan on 20/09/24.
//

import Foundation
import UIKit
import CoreData

protocol FindedNetworks{
    func reloadData()
}

class DeviceListViewModel: NSObject,NetServiceBrowserDelegate, NetServiceDelegate {
    var services = [NetService]()
    var netServiceBrowser: NetServiceBrowser
    var availableDevices = [DeviceListModel]()
    var delegate: FindedNetworks?
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override init() {
        self.netServiceBrowser = NetServiceBrowser()
        super.init()
        self.netServiceBrowser.delegate = self
    }
    
    func startMonitor() {
        self.netServiceBrowser.searchForServices(ofType: "_airplay._tcp.", inDomain: "")
    }
    
    func fetchData(){
        do{
            self.availableDevices = try appDelegate.fetch(DeviceListModel.fetchRequest())
            self.delegate?.reloadData()
        }
        catch{
            print("error")
        }
    }
    
    func saveData(devices: DeviceListModel){
        do{
            try appDelegate.save()
            self.fetchData()
        }
        catch{
            print("error")
        }
    }
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        services.append(service)
        service.delegate = self
        service.resolve(withTimeout: 10.0)
    }
    
    func netServiceDidResolveAddress(_ sender: NetService) {
        let ipAddress = getIpAddress(sender)
        let deviceName = sender.name
        if ipAddress != ""{
            let deviceDetails = DeviceListModel(context: appDelegate)
            deviceDetails.name = "Device name: \(deviceName)"
            deviceDetails.ipaddreess = "iP Address : \(ipAddress ?? "")"
            deviceDetails.status = "Rechable"
            self.saveData(devices: deviceDetails)
        }
    }
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didRemove service: NetService, moreComing: Bool) {
        let fetchRequest: NSFetchRequest<DeviceListModel> = DeviceListModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "deviceName == %@", service.name)
        
        do {
            let fetchedDevices = try appDelegate.fetch(fetchRequest)
            if let device = fetchedDevices.first {
                device.status = "UnRechable"
                saveData(devices: device)
            }
        } catch {
            print("Failed to save device: \(error)")
        }
    }
    
    func getIpAddress(_ service: NetService) -> String?{
        if let addresses = service.addresses, !addresses.isEmpty {
            let data = addresses[0]
            var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
            data.withUnsafeBytes { ptr in
                guard let addr = ptr.baseAddress?.assumingMemoryBound(to: sockaddr.self) else { return }
                getnameinfo(addr, socklen_t(data.count), &hostname, socklen_t(hostname.count), nil, 0, NI_NUMERICHOST)
            }
            let ipAddress = String(cString: hostname)
            return ipAddress
        }
        return ""
    }

}
