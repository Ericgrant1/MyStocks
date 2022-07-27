//
//  PersistenceManager.swift
//  MyStocks
//
//  Created by Eric Grant on 07.07.2022.
//

import Foundation

// ["AAPL", "AMZN", "GOOG", "META", "NFLX", "MSFT", "TSLA", "NVDA", "ORCL", "ADBE"]
// [AAPL: Apple Inc.]

final class PersistenceManager {
    static let shared = PersistenceManager()
    
    private let userDefaults: UserDefaults = .standard
    
    private struct Constants {
        static let onboardedKey = "hasOnBoarded"
        static let watchListKey = "watchlist"
    }
    
    private init() {}
    
    // MARK: - Public
    public var watchlist: [String] {
        if !hasOnBoarded {
            userDefaults.set(true, forKey: Constants.onboardedKey)
            setUpDefaults()
        }
        return userDefaults.stringArray(forKey: Constants.watchListKey) ?? []
    }
    
    public func addToWatchlist() {
        
    }
    
    public func removeToWatchlist(symbol: String) {
        var newList = [String]()
        
        print("Deleting: \(symbol)")
        
        userDefaults.set(nil, forKey: symbol)
        for item in watchlist where item != symbol {
            print("\n\(item)")
            newList.append(item)
        }
        
        userDefaults.set(newList, forKey: Constants.watchListKey)
    }
    
    // MARK: - Private
    private var hasOnBoarded: Bool {
        return userDefaults.bool(forKey: Constants.onboardedKey)
    }
    
    private func setUpDefaults() {
        let map: [String: String] = [
            "AAPL": "Apple Inc.",
            "AMZN": "Amazon.com, Inc.",
            "GOOG": "Alphabet Inc.",
            "META": "Meta Platforms, Inc.",
            "NFLX": "Netflix, Inc.",
            "MSFT": "Microsoft Corporation",
            "TSLA": "Tesla, Inc.",
            "NVDA": "NVIDIA Corporation",
            "ORCL": "Oracle Corporation",
            "ADBE": "Adobe Inc."
        ]
        
        let symbols = map.keys.map { $0 }
        userDefaults.set(symbols, forKey: Constants.watchListKey)
        
        for (symbol, name) in map {
            userDefaults.set(name, forKey: symbol)
        }
    }
    
}
