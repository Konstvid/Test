//
//  NetworkService.swift
//  TestMamleev
//
//  Created by Andrey on 16.02.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    
    func getListOffices(completion: @escaping OfficesCompletion)
}

class NetworkService: NetworkServiceProtocol {
    
    func getListOffices(completion: @escaping OfficesCompletion) {
        getRequest(URLString: Constants.baseURL) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                do {
                    let jsonData = try JSONDecoder().decode([Office].self, from: data)
                    completion(.success(jsonData))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}

extension NetworkService {
    
    private func getRequest(URLString: String, completion: @escaping ResultCompletion) {
        guard let url = URL(string: URLString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
    }
}
