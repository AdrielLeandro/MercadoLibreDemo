//
//  ProductCell.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 8/29/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import UIKit
import SDWebImage

class ProductCell: UITableViewCell, CellProtocol {
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.robotoRegularFontSize14()
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoRegularFontSize12()
        label.textColor = .anchor
        return label
    }()

    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoRegularFontSize12()
        label.textColor = .anchor
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupImageView()
        setupTitleLabel()
        setupPriceLabel()
        setupAddressLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: 5).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }

    private func setupImageView() {
        addSubview(productImageView)
        productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        productImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        productImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }

    private func setupPriceLabel() {
        addSubview(priceLabel)
        priceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10).isActive = true
        priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }

    private func setupAddressLabel() {
        addSubview(addressLabel)
        addressLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10).isActive = true
        addressLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }

    func configure(with viewModel: ProductCellViewModel) {
        titleLabel.text = viewModel.title
        priceLabel.text = viewModel.price
        addressLabel.text = viewModel.address
        productImageView.sd_setImage(with: URL(string: viewModel.imagePath), placeholderImage: UIImage(named: "placeholder"), options: [], context: nil)
    }
}
