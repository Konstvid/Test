//
//  MainViewModel.swift
//  TestMamleev
//
//  Created by Andrey on 18.02.2023.
//

import Foundation

protocol IMaimViewModel {
    
    func getListOffice()
}

class MainViewModel: IMaimViewModel {
    
    private let router: IMainRouter
    private let networkService = NetworkService()
    
    init(router: IMainRouter) {
        self.router = router
    }
    
    func getListOffice() {
        networkService.getListOffices { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let offices):
                    guard let offices = offices else { return }
                    self?.router.showListOfficesViewController(offices: offices)
                case .failure(let error):
                    self?.router.show(error: error)
                }
            }
        }
    }
}
