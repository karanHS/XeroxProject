//
//  IPDeatailsModel.swift
//  XeroxMachineTestProject
//
//  Created by Karan on 22/09/24.
//

import Foundation

struct IpdetailsModel : Codable {
    let ip : String?
    let hostname : String?
    let city : String?
    let region : String?
    let country : String?
    let loc : String?
    let org : String?
    let postal : String?
    let timezone : String?
    let readme : String?

    enum CodingKeys: String, CodingKey {
        case ip = "ip"
        case hostname = "hostname"
        case city = "city"
        case region = "region"
        case country = "country"
        case loc = "loc"
        case org = "org"
        case postal = "postal"
        case timezone = "timezone"
        case readme = "readme"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ip = try values.decodeIfPresent(String.self, forKey: .ip)
        hostname = try values.decodeIfPresent(String.self, forKey: .hostname)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        region = try values.decodeIfPresent(String.self, forKey: .region)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        loc = try values.decodeIfPresent(String.self, forKey: .loc)
        org = try values.decodeIfPresent(String.self, forKey: .org)
        postal = try values.decodeIfPresent(String.self, forKey: .postal)
        timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
        readme = try values.decodeIfPresent(String.self, forKey: .readme)
    }
}


struct IPResponseModel : Codable {
    
    let ip : String?
    
    enum CodingKeys: String, CodingKey {
        case ip = "ip"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ip = try values.decodeIfPresent(String.self, forKey: .ip)
    }
}
