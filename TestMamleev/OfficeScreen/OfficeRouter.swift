//
//  OfficeRouter.swift
//  TestMamleev
//
//  Created by Andrey on 17.02.2023.
//

import Foundation
import UIKit

protocol IOfficeRouter {
    func calling(phone: String?)
}

class OfficeRouter: IOfficeRouter {
    weak var moduleController: UIViewController?
    
    func calling(phone: String?) {
        print(phone)
    }
}
