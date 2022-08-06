//
//  HapticsManager.swift
//  MyStocks
//
//  Created by Eric Grant on 07.07.2022.
//

import Foundation
import UIKit

/// Object to manage haptics
final class HapticsManager {
    /// Singleton
    static let shared = HapticsManager()
    
    /// Private constructor
    private init() {}
    
    // MARK: - Public
    
    /// Vibrate slightly for selection
    public func vibrateForSelection() {
        // Vibrate lightly for a selection tap interaction
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
    
    /// Play haptic for given type interection
    /// - Parameter type: Type to vibrate for
    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(type)
    }
}
