//
//  APICaller.swift
//  MyStocks
//
//  Created by Eric Grant on 07.07.2022.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private struct Constants {
        static let apiKey = ""
        static let sendboxApiKey = ""
        static let baseUrl = ""
    }
    
    private init() {}
    
    // MARK: - Public
    
    // get stock info
    
    // search stock
    
    // MARK: - Private
    private enum Endpoint: String {
        case search
    }
    
    private enum APIError: Error {
        case noDataReturned
        case invalideUrl
    }
    
    private func url(for endpoint: Endpoint,
                     queryParams: [String: String] = [:]
    ) -> URL? {
        return nil
    }
    
    private func request<T: Codable>(
        url: URL?,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = url else {
            // invalid url
            completion(.failure(APIError.invalideUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(APIError.invalideUrl))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
