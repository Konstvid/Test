//
//  ListOfficesViewModel.swift
//  TestMamleev
//
//  Created by Andrey on 18.02.2023.
//

import Foundation
import MapKit

protocol IListOfficesViewModel {
    
    var offices: [Office] { get }
    
    func showOfficeViewController()
    func popViewController()
}

class ListOfficesViewModel {
    
    let offices: [Office]
    private let router: IListOfficesRouter
    
    init(offices: [Office], router: IListOfficesRouter) {
        self.offices = offices
        self.router = router
    }
    
    func showOfficeViewController(office: Office) {
        router.showOfficeViewController(office: office)
    }
    
    func popViewController() {
        router.popViewController()
    }
}
