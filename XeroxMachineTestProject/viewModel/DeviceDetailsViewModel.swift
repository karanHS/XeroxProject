//
//  DeviceDetailsViewModel.swift
//  XeroxMachineTestProject
//
//  Created by Karan on 20/09/24.
//

import Foundation

class DeviceDetailsViewModel: NSObject{
    
    override init() {
        super.init()
    }
        
    func getIpDetails(ipAddress: String,completionHandler: @escaping(Result<IpdetailsModel, NetowrkError>) -> ()){
                
        let request = APIRequestService.getCurrentIpInfo(ipAddress: ipAddress)
        Webservice.shareInstance.webRequest(apiRequestBuilder: request) { res in
            switch res {
            case .success(let success):
                completionHandler(.success(success))
            case .failure(let failure):
                completionHandler(.failure(failure))
            }
        }
    }
    
    func currentIpApi(completionHandler: @escaping (Result<IPResponseModel,NetowrkError>) -> ()){
        let request = APIRequestService.getIpAddress
        Webservice.shareInstance.webRequest(apiRequestBuilder: request) { result in
            switch result {
            case .success(let success):
                completionHandler(.success(success))
            case .failure(let failure):
                completionHandler(.failure(failure))
            }
        }
    }
}

