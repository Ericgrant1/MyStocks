//
//  PersistenceManager.swift
//  MyStocks
//
//  Created by Eric Grant on 07.07.2022.
//

import Foundation

final class PersistenceManager {
    static let shared = PersistenceManager()
    
    private let userDefaults: UserDefaults = .standard
    
    private struct Constants {
        
    }
    
    private init() {}
    
    // MARK: - Public
    public var watchlist: [String] {
        return []
    }
    
    public func addToWatchlist() {
        
    }
    
    public func removeToWatchlist() {
        
    }
    
    // MARK: - Private
    private var hasOnBoarded: Bool {
        return false
    }
    
}
