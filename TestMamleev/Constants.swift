//
//  Constants.swift
//  TestMamleev
//
//  Created by Andrey on 17.02.2023.
//

import Foundation

typealias OfficesCompletion = (Result<[Office]?, Error>) -> ()
typealias ResultCompletion = (Result<Data, Error>) -> ()
typealias VoidCompletion = (() -> Void)

struct Constants {
    static let baseURL = "https://mobile.reso.ru/free/v2/agencies/77"
    static let errorTitle = "Ошибка"
    static let listOfficeTitle = "Получить список \n офисов"
    static let okActionTitle = "Oк"
    static let workTime = "Режим работы"
    static let callButtonTitle = "Позвонить"
    static let title = "Вы тута"
}
