//
//  Reso.swift
//  TestMamleev
//
//  Created by Andrey on 17.02.2023.
//

import Foundation

struct Office: Codable {
    let SSTATUS: String?
    let NDISTANSE: Double?
    let SSHORTNAME: String?
    let SSHORTADDRESS: String?
    let SDISTANCE: String?
    let SPHONE: String?
    let SGRAF: String?
    let GRAF: [Graf]?
}

struct Graf: Codable {
    let SBEGIN: String?
    let SEND: String?
    
    func getBeginTime() -> WorkingHours {
        let hours = String(SBEGIN?.split(separator: ".").first ?? "")
        let minutes = String(SBEGIN?.split(separator: ".").last ?? "")
        return WorkingHours(hours: Int(hours) ?? 0, minutes: Int(minutes) ?? 0)
    }
    
    func getSendTime() -> WorkingHours {
        let hours = String(SEND?.split(separator: ".").first ?? "")
        let minutes = String(SEND?.split(separator: ".").last ?? "")
        return WorkingHours(hours: Int(hours) ?? 0, minutes: Int(minutes) ?? 0)
    }
}
