//
//  StockChartView.swift
//  MyStocks
//
//  Created by Eric Grant on 24.07.2022.
//

import UIKit

class StockChartView: UIView {
    
    struct ViewModel {
        let data: [Double]
        let showLegend: Bool
        let showAxis: Bool
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    /// Reset the chart view
    func reset() {
        
    }
    
    func configure(with viewModel: ViewModel) {
        
    }
}
