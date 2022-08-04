//
//  PersistenceManager.swift
//  MyStocks
//
//  Created by Eric Grant on 07.07.2022.
//

import Foundation

/// Object to manage saved caches
final class PersistenceManager {
    ///  Singleton
    static let shared = PersistenceManager()
    
    /// Reference to user defaults
    private let userDefaults: UserDefaults = .standard
    
    /// Constants
    private struct Constants {
        static let onboardedKey = "hasOnBoarded"
        static let watchListKey = "watchlist"
    }
    
    /// Privatized constructor
    private init() {}
    
    // MARK: - Public
    
    /// Get user watch list
    public var watchlist: [String] {
        if !hasOnBoarded {
            userDefaults.set(true, forKey: Constants.onboardedKey)
            setUpDefaults()
        }
        return userDefaults.stringArray(forKey: Constants.watchListKey) ?? []
    }
    
    /// Check if watchlist contains item
    /// - Parameter symbol: Symbol to check
    /// - Returns: Boolean
    public func watchlistContains(symbol: String) -> Bool {
        return watchlist.contains(symbol)
    }
    
    /// Add a symbol to watchlist
    /// - Parameters:
    ///   - symbol: Symbol to add
    ///   - companyName: Company name for symbol being added
    public func addToWatchlist(symbol: String, companyName: String) {
        var current = watchlist
        current.append(symbol)
        userDefaults.set(current, forKey: Constants.watchListKey)
        userDefaults.set(companyName, forKey: symbol)
        
        NotificationCenter.default.post(name: .didAddToWatchList, object: nil)
    }
    
    /// Remove item from watchlist
    /// - Parameter symbol: Symbol to remove
    public func removeToWatchlist(symbol: String) {
        var newList = [String]()
        
        userDefaults.set(nil, forKey: symbol)
        for item in watchlist where item != symbol {
            newList.append(item)
        }
        
        userDefaults.set(newList, forKey: Constants.watchListKey)
    }
    
    // MARK: - Private
    
    /// Check if user has been onboarded
    private var hasOnBoarded: Bool {
        return userDefaults.bool(forKey: Constants.onboardedKey)
    }
    
    /// Set up default watchlist items
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
