//
//  ViewController.swift
//  CharacterViewer
//
//  Created by Admin on 6/13/23.
//

import UIKit

class ListViewController: UIViewController {
    let viewModel: ListViewModel
    let contentView: ListView

    init() {
        viewModel = ListViewModel()
        contentView = ListView(viewModel: self.viewModel)
        super.init(nibName: nil, bundle: nil)
    }

    required init? (coder aDecoder: NSCoder) {
        viewModel = ListViewModel()
        contentView = ListView(viewModel: self.viewModel)
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        contentView.searchBar.delegate = self
        setupUI()
        viewModel.populateData {
            DispatchQueue.main.async {
                self.contentView.tableView.reloadData()
            }
        }
    }

    private func setupTableView() {
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CharacterCell")
    }

    private func setupUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func updateTableView(with data: [CharacterListData]) {
        viewModel.filteredCharacterList = data
        contentView.tableView.reloadData()
    }

}

// MARK: TableView Delegate

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(
                CharacterDetailViewController(characterData: self.viewModel.filteredCharacterList[indexPath.row]), animated: true)
        }
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredCharacterList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath)
        cell.textLabel?.text = viewModel.filteredCharacterList[indexPath.row].name
        return cell
    }
}

// MARK: Search Bar Delegate

extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            updateTableView(with: viewModel.characterList)
        } else {
            let filteredCharacterList = viewModel.characterList.filter { character in
                return character.fullDescription.lowercased().contains(searchText.lowercased())
            }
            updateTableView(with: filteredCharacterList)
        }
    }
}
