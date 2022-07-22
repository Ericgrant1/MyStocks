//
//  WatchListViewController.swift
//  MyStocks
//
//  Created by Eric Grant on 06.07.2022.
//

import UIKit
import FloatingPanel

class WatchListViewController: UIViewController {
    private var searchTimer: Timer?
    
    private var panel: FloatingPanelController?
    
    /// Model
    private var watchlistMap: [String: [String]] = [:]
    
    /// ViewModels
    private var viewmodels: [String] = []
    
    private let tableView: UITableView = {
        let table = UITableView()
        
        return table
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpSearchController()
        setUpTableView()
        setUpWatchListData()
        setUpFloatingPanel()
        setUpTitleView()
    }

    // MARK: - Private
    
    private func setUpWatchListData() {
        let symbols = PersistenceManager.shared.watchlist
        
        for symbol in symbols {
            // Fetch market data per symbol
            watchlistMap[symbol] = ["some string"]
        }
        
        tableView.reloadData()
    }
    
    private func setUpTableView() {
        view.addSubviews(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    private func setUpFloatingPanel() {
        let vc = NewsViewController(type: .topStories)
        let panel = FloatingPanelController(delegate: self)
        panel.surfaceView.backgroundColor = .secondarySystemBackground
        panel.set(contentViewController: vc)
        panel.addPanel(toParent: self)
        panel.track(scrollView: vc.tableView)
    }
    
    private func setUpTitleView() {
        let titleView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.width,
                height: navigationController?.navigationBar.height ?? 100)
        )
        
        let label = UILabel(
            frame: CGRect(
                x: 10,
                y: 0,
                width: titleView.width - 20,
                height: titleView.height)
        )
        label.text = "Stocks"
        label.font = .systemFont(ofSize: 40, weight: .medium)
        titleView.addSubview(label)
        navigationItem.titleView = titleView
    }
    
    private func setUpSearchController() {
        let resultVC = SearchResultsViewController()
        resultVC.delegate = self
        let searchVC = UISearchController(searchResultsController: resultVC)
        searchVC.searchResultsUpdater = self
        navigationItem.searchController = searchVC
    }
}

extension WatchListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              let resultsVC = searchController.searchResultsController as? SearchResultsViewController,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
                  return
              }
        
        // Reset timer
        searchTimer?.invalidate()
        
        // Kick off new timer
        // Optimise to reduce number of searches for when user stops typing
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { _ in
            // Call API to search
            APICaller.shared.search(query: query) { result in
                switch result {
                    case .success(let response):
                        DispatchQueue.main.async {
                            resultsVC.update(with: response.result)
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            resultsVC.update(with: [])
                        }
                        print(error)
                }
            }
        })
    }
}

extension WatchListViewController: SearchResultsViewControllerDelegate {
    func searchResultsViewControllerDidSelect(searchResult: SearchResult) {
        navigationItem.searchController?.searchBar.resignFirstResponder()
        
        let vc = StockDetailsViewController()
        let navVC = UINavigationController(rootViewController: vc)
        vc.title = searchResult.description
        present(navVC, animated: true)
    }
}

extension WatchListViewController: FloatingPanelControllerDelegate {
    func floatingPanelDidChangeState(_ fpc: FloatingPanelController) {
        navigationItem.titleView?.isHidden = fpc.state == .full
    }
}

extension WatchListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watchlistMap.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Open Details for selection
        
    }
    
    
}
