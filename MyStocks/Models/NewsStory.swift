//
//  NewsStory.swift
//  MyStocks
//
//  Created by Eric Grant on 18.07.2022.
//

import Foundation

/// Represent news story
struct NewsStory: Codable {
    let category: String
    let datetime: TimeInterval
    let headline: String
    let image: String
    let related: String
    let source: String
    let summary: String
    let url: String
}
