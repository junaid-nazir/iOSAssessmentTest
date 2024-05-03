//
//  ServiceManger.swift
//  iOSAssessmentTest
//
//  Created by Junaid Nazir on 02/05/24.
//

import Foundation

enum ApiError: Error {
    case apiOperationFailed(String)
    case decodingError(String)
}

final class ServiceManager {
    
    let session = URLSession.shared
    
    func fetchRecords(page: Int, limit: Int, completion: @escaping (Result<[JsonResponseModel], ApiError>) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/posts?_page=\(page)&_limit=\(limit)"
        guard let url = URL(string: urlString) else {
            completion(.failure(.apiOperationFailed("Unable to perform the operation")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.apiOperationFailed("Unable to perform the operation")))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode([JsonResponseModel].self, from: data)
                completion(.success(response))
            } catch {
                print("Error decoding tasks: \(error)")
                completion(.failure(ApiError.decodingError("Error decoding tasks: \(error)")))
            }
        }.resume()
    }
}
