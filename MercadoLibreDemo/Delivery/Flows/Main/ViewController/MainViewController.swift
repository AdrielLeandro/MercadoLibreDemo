//
//  MainViewController.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 8/29/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, StateProtocol, LoadingProtocol {
    private let viewModel: MainViewModel
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 130
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
        return tableView
    }()

    private lazy var searchBarView: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect.zero)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.barTintColor = .lightYellow
        searchBar.searchTextField.backgroundColor = .white
        searchBar.backgroundColor = .white
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.lightYellow.cgColor
        searchBar.delegate = self
        return searchBar
    }()
    var loadingView = LoadingView()
    var stateView = StateView()

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = LocalizableStrings.search.localized
        setupSearchBar()
        setupTableView()
        binding()
        setupNavigationItem()
    }

    private func setupNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Categories", style: .plain, target: self, action: #selector(didTouchCategories))
    }

    @objc private func didTouchCategories() {
        viewModel.didTouchCategories()
    }

    private func setupSearchBar() {
        view.addSubview(searchBarView)
        searchBarView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        searchBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func binding() {
        start(messageTitle: LocalizableStrings.searchMessage.localized, stateImage: Assets.searchImage, isShowReload: false)
        viewModel.updateState = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .success:
                self.tableView.reloadData()
                self.stopLoading()
            case .loading:
                self.stopState()
                self.stopLoading()
            case .empty:
                self.stopLoading()
                self.start(messageTitle: LocalizableStrings.emptyMessage.localized, stateImage: Assets.emptyImage, isShowReload: false)
            case .search:
                self.stopLoading()
                self.start(messageTitle: LocalizableStrings.searchMessage.localized, stateImage: Assets.searchImage, isShowReload: false)
            case .error:
                self.stopLoading()
                self.start(messageTitle: LocalizableStrings.errorMessage.localized, stateImage: Assets.errorImage, isShowReload: false)
            }
        }

        viewModel.actionFromCategories = { [weak self] category in
            guard let self = self else { return }
            self.title = category.name
            self.changeRightBarItem()
        }
    }

    private func changeRightBarItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: LocalizableStrings.restoreTitle.localized, style: .plain, target: self, action: #selector(didTouchRestore))
    }

    @objc private func didTouchRestore() {
        title = LocalizableStrings.search.localized
        setupNavigationItem()
        viewModel.didTouchRestore()
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRow
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(with: viewModel.cellForRow(at: indexPath))
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(indexPath: indexPath)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(item: searchText)
    }

}
