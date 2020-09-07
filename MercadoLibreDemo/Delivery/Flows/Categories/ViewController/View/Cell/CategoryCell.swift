//
//  CategoryCell.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 9/1/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell, CellProtocol {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoRegularFontSize20()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupTitle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTitle() {
        addSubview(titleLabel)
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
    }

    func configure(with viewModel: CategoryCellViewModel) {
        titleLabel.text = viewModel.name
    }
}
