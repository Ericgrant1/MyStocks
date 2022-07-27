//
//  StockDetailsViewController.swift
//  MyStocks
//
//  Created by Eric Grant on 07.07.2022.
//

import UIKit

class StockDetailsViewController: UIViewController {
    // MARK: - Properties
    
    private let symbol: String
    private let companyName: String
    private let candleStickData: [CandleStick]
    
    // MARK: - Init
    
    init(
        symbol: String,
        companyName: String,
        candleStickData: [CandleStick] = []
    ) {
        self.symbol = symbol
        self.companyName = companyName
        self.candleStickData = candleStickData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }

}
