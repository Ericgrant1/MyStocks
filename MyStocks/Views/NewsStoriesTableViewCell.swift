//
//  NewsStoriesTableViewCell.swift
//  MyStocks
//
//  Created by Eric Grant on 19.07.2022.
//

import UIKit

class NewsStoriesTableViewCell: UITableViewCell {
    static let identifier = "NewsStoriesTableViewCell"
    
    struct ViewModel {
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with viewModel: ViewModel) {
        
    }
    
}
