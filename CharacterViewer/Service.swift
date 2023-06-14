//
//  Service.swift
//  Simpsons
//
//  Created by Admin on 6/13/23.
//

import Foundation

enum ServiceError: Error {
    case serverError(Error)
    case urlError
    case jsonParsingError(Error)
}

class Service {
    static let shared = Service()
    private let apiUrl = Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String ?? ""

    func fetchData(completion: @escaping (Result<CharacterListDataModel, ServiceError>) -> Void) {
        // Need to create custom error... for failed url
        guard let url = URL(string: apiUrl) else {
            completion(.failure(.urlError))
            return
        }
        let requst = URLRequest(url: url)
        URLSession.shared.dataTask(with: requst) { (data, response, error) in
            if let error = error {
                completion(.failure(.serverError(error)))
                return
            }

            if let characterListDataJSON = data {
                do {
                    let characterListData = try JSONDecoder().decode(CharacterListDataModel.self, from: characterListDataJSON)
                    completion(.success(characterListData))
                } catch let error {
                    completion(.failure(.jsonParsingError(error)))
                }
            }
        }.resume()
    }

}
