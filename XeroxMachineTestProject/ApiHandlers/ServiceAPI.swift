//
//  ServiceAPI.swift
//  XeroxMachineTestProject
//
//  Created by Karan on 22/09/24.
//

import Foundation

struct APIService{
    
    static func getCurrentIpInfo(ipAddress: String) -> APIBuilder<IpdetailsModel>{
        var urlString = APIEndPoint.getipInfo.rawValue
        urlString = urlString.replacingOccurrences(of: "{ipAddress}", with: ipAddress)
               return APIBuilder(baseUrl:urlString)
    }
    
    static var getIpAddress:APIBuilder<IPResponseModel>{
        return APIBuilder(baseUrl: APIEndPoint.getCurrentIP.rawValue)
    }
}
