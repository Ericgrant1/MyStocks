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
        static let apiKey = "cb63ng2ad3i70tu5tuc0"
        static let sendboxApiKey = "sandbox_cb63ng2ad3i70tu5tucg"
        static let baseUrl = "https://finnhub.io/api/v1/"
        static let day: TimeInterval = 3600 * 24
    }
    
    private init() {}
    
    // MARK: - Public
    public func search(
        query: String,
        completion: @escaping (Result<SearchResponse, Error>) -> Void
    ) {
        guard let safeQuery = query.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
        ) else {
            return
        }
        request(
            url: url(
                for: .search, queryParams: ["q": safeQuery]),
                expecting: SearchResponse.self,
                completion: completion
        )
    }
    
    public func news(
        for type: NewsViewController.`Type`,
        completion: @escaping (Result<[NewsStory], Error>) -> Void
    ) {
        switch type {
            case .topStories:
                request(
                    url: url(for: .topStories, queryParams: ["category": "general"]),
                    expecting: [NewsStory].self,
                    completion: completion)
            case .company(let symbol):
                let today = Date()
                let oneMonthBack = today.addingTimeInterval(-(Constants.day * 7))
                request(
                    url: url(
                        for: .companyNews,
                        queryParams: [
                            "symbol": symbol,
                            "from": DateFormatter.newsDateFormatter.string(from: oneMonthBack),
                            "to": DateFormatter.newsDateFormatter.string(from: today)
                        ]
                    ),
                    expecting: [NewsStory].self,
                    completion: completion)
        }
    }
    
    public func marketData(
        for symbol: String,
        numberOfdays: TimeInterval = 7,
        comletion: @escaping (Result<String, Error>) -> Void
    ) {
        let today = Date()
        let prior = today.addingTimeInterval(-(Constants.day * numberOfdays))
        
        request(
            url:  url(
                for: .marketData,
                   queryParams: [
                    "symbol": symbol,
                    "resolution": "1",
                    "from": DateFormatter.newsDateFormatter.string(from: prior),
                    "to": DateFormatter.newsDateFormatter.string(from: today)
                   ]
            ),
            expecting: String.self,
            completion: comletion)
        
    }
    
    // MARK: - Private
    private enum Endpoint: String {
        case search
        case topStories = "news"
        case companyNews = "company-news"
        case marketData = "stock/candle"
    }
    
    private enum APIError: Error {
        case noDataReturned
        case invalideUrl
    }
    
    private func url(for endpoint: Endpoint,
                     queryParams: [String: String] = [:]
    ) -> URL? {
        var urlString = Constants.baseUrl + endpoint.rawValue
        
        var queryItems = [URLQueryItem]()
        // Add any parameters
        for (name, value) in queryParams {
            queryItems.append(.init(name: name, value: value))
        }
        
        // Add token
        queryItems.append(.init(name: "token", value: Constants.apiKey))
        
        // Convert query items to suffix string
        urlString += "?" + queryItems.map { "\($0.name)=\($0.value ?? "")" }.joined(separator: "&")
        
        print("\n\(urlString)\n")
        
        return URL(string: urlString)
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
                    completion(.failure(APIError.noDataReturned))
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
