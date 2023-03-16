//
//  ListOfficesRouter.swift
//  TestMamleev
//
//  Created by Andrey on 18.02.2023.
//

import UIKit

protocol IListOfficesRouter {
    
    func showOfficeViewController(office: Office)
    func popViewController()
}

class ListOfficesRouter: IListOfficesRouter {
    
    weak var moduleController: UIViewController?
    
    func showOfficeViewController(office: Office) {
        let router = OfficeRouter()
        let viewModel = OfficeViewModel(router: router, office: office)
        let vc = OfficeViewController(viewModel: viewModel)
        moduleController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func popViewController() {
        moduleController?.navigationController?.popViewController(animated: true)
    }
}
