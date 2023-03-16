//
//  MainRouter.swift
//  TestMamleev
//
//  Created by Andrey on 18.02.2023.
//

import UIKit

protocol IMainRouter {
    func showListOfficesViewController(offices: [Office])
    func show(error: Error)
}

class MainRouter: IMainRouter {
    
    weak var moduleController: UIViewController?
    
    func showListOfficesViewController(offices: [Office]) {
        let router = ListOfficesRouter()
        let viewModel = ListOfficesViewModel(offices: offices, router: router)
        let vc = ListOfficesViewController(viewModel: viewModel)
        router.moduleController = vc
        moduleController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func show(error: Error) {
        let alert = UIAlertController(
            title: Constants.errorTitle,
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: Constants.okActionTitle, style: .default, handler: nil)
        alert.addAction(okAction)
        moduleController?.present(alert, animated: true, completion: nil)
    }
}
