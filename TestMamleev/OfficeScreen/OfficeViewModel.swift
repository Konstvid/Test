//
//  OfficeViewModel.swift
//  TestMamleev
//
//  Created by Andrey on 17.02.2023.
//

import Foundation

protocol IOfficeViewModel {
    
    var office: Office { get }
    func getPhoneNumber()
}

class OfficeViewModel: IOfficeViewModel {
    
    let office: Office
    private let router: IOfficeRouter
    
    func getPhoneNumber() {
        self.router.calling(phone: office.SPHONE)
    }
    
    init(router: IOfficeRouter, office: Office) {
        self.router = router
        self.office = office
    }
}
