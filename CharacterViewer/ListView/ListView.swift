//
//  ListView.swift
//  Simpsons
//
//  Created by Admin on 6/13/23.
//

import UIKit

class ListView: UIView {
    private let viewModel: ListViewModel
    private typealias ViewModel = ListViewModel

    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = ViewModel.searchBarPlaceHolderText
        return searchBar
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
    }

    @available (*, unavailable) required init? (coder aDecoder: NSCoder) { nil }

    private func setupUI() {
        addSubview(searchBar)
        searchBar.constrain(to: self, constraints: [.top(.zero), .leading(.zero), .trailing(.zero)])

        addSubview(tableView)
        tableView.constrain(to: self, constraints: [.leading(.zero), .trailing(.zero), .bottom(.zero)])
        tableView.constrain(to: searchBar, constraints: [.topToBottom(10)])
    }
}
