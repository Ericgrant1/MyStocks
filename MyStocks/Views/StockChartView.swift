//
//  StockChartView.swift
//  MyStocks
//
//  Created by Eric Grant on 24.07.2022.
//

import UIKit
import Charts

/// View viewModel
final class StockChartView: UIView {
    /// Chart View ViewModel
    struct ViewModel {
        let data: [Double]
        let showLegend: Bool
        let showAxis: Bool
        let fillColor: UIColor
    }
    
    /// Chart View
    private let chartView: LineChartView = {
        let chartView = LineChartView()
        chartView.pinchZoomEnabled = false
        chartView.setScaleEnabled(true)
        chartView.xAxis.enabled = false
        chartView.drawGridBackgroundEnabled = false
        chartView.legend.enabled = false
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        return chartView
    }()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(chartView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        chartView.frame = bounds
    }
    
    /// Reset the chart view
    func reset() {
        chartView.data = nil
    }
    
    /// Configure View
    /// - Parameter viewModel: View ViewModel
    func configure(with viewModel: ViewModel) {
        var entries = [ChartDataEntry]()
        
        for (index, value) in viewModel.data.enumerated() {
            entries.append(
                .init(
                    x: Double(index),
                    y: value
                )
            )
        }
        
        chartView.rightAxis.enabled = viewModel.showAxis
        chartView.legend.enabled = viewModel.showLegend
        
        let dataSet = LineChartDataSet(entries: entries, label: "7 Days")
        dataSet.fillColor = viewModel.fillColor
        dataSet.drawFilledEnabled = true
        dataSet.drawIconsEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.drawCirclesEnabled = false
        let data = LineChartData(dataSet: dataSet)
        chartView.data = data
    }
}
