//
//  HotWaterShutoffHotWaterShutoffViewController.swift
//  GovermentServices
//
//  Created by Holyberry on 20/09/2020.
//  Copyright © 2020 Gulnaz Almukhametova. All rights reserved.
//

import UIKit

class HotWaterShutoffViewController: UIViewController, UITableViewDataSource {
    
    var output: HotWaterShutoffViewOutput!
   
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.register(AddressCell.self, forCellReuseIdentifier: AddressCell.reuseIdentifier)
        table.refreshControl = refreshControl
        table.estimatedRowHeight = 200
        table.rowHeight = UITableView.automaticDimension
        table.tableFooterView = UIView()
        return table
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        return control
    }()
    
    private lazy var errorView = ErrorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView, constraints: .pin)
       
        if #available(iOS 11.0, *) {
            navigationItem.searchController = UISearchController()
            navigationItem.searchController?.searchBar.delegate = self
        }
        
        title = L10n.HotWaterShutoff.title
        output.viewIsReady()
    }
    
    @objc func handleRefreshControl() {
       output.startRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.getViewModels().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressCell.reuseIdentifier, for: indexPath)
        
        guard let addressCell = cell as? AddressCell else {
            assertionFailure("Cell data is not correct")
            return cell
        }
        
        let model = output.getViewModels()[indexPath.row]
        addressCell.render(model)
        
        return addressCell
    }
    
    @objc func retry() {
        UIView.animate(withDuration: 0.3, animations: {
            self.errorView.alpha = 0
        }, completion: { _ in
            self.errorView.removeFromSuperview()
        })
            
        output.didTapRetry()
    }
}



extension HotWaterShutoffViewController: HotWaterShutoffViewInput {
    func reloadData() {
        tableView.reloadData()
    }
    
    func showError(_ error: String) {
        errorView.render(text: error)
        errorView.retryButton.addTarget(self, action: #selector(retry), for: .touchUpInside)
        view.addSubview(errorView, constraints: .pin)
    }
    
    func startLoading() {
        refreshControl.endRefreshing()
        LoadingIndicatorView.show(loadingText: L10n.HotWaterShutoff.downloading)
    }
    
    func stopLoading() {
        LoadingIndicatorView.hide()
    }
}



extension HotWaterShutoffViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        output.didSearch(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        output.didCancelSearch()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        output.getViewModels().count > 0
    }
}
