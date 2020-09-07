//
//  CategoryViewController.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 9/1/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, LoadingProtocol, StateProtocol {
    private let viewModel: CategoryViewModel
    private lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.identifier)
        tableview.dataSource = self
        tableview.delegate = self
        return tableview
    }()
    var loadingView = LoadingView()
    var stateView = StateView()

    init(viewModel: CategoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizableStrings.selectCategoryTitle.localized
        view.backgroundColor = .white
        binding()
        setupTableView()
    }

    private func binding() {
        startLoading()
        viewModel.getCategories()
        viewModel.updateState = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .success:
                self.tableView.reloadData()
                self.stopLoading()
                self.stopState()
            case .error:
                self.start(messageTitle: LocalizableStrings.errorMessage.localized,
                           stateImage: Assets.errorImage,
                           isShowReload: true)
                self.stopLoading()
            case .empty:
                self.start(messageTitle: LocalizableStrings.emptyMessage.localized,
                           stateImage: Assets.emptyImage,
                           isShowReload: false)
                self.stopLoading()
            case .loading:
                self.startLoading()
            default:
                break
            }
        }
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRow
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CategoryCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(with: viewModel.cellForRow(at: indexPath))
        return cell
    }
}

extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}
