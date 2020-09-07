//
//  DetailViewController.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 8/30/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController, LoadingProtocol, StateProtocol {
    private let viewModel: DetailViewModel
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var detailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoBoldFontSize20()
        label.textColor = .anchor
        label.numberOfLines = 2
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoRegularFontSize16()
        label.textColor = .anchor
        return label
    }()

    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoRegularFontSize16()
        label.textColor = .anchor
        return label
    }()

    private lazy var warrantyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoRegularFontSize16()
        label.textColor = .anchor
        return label
    }()

    private lazy var stockLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoRegularFontSize16()
        label.textColor = .cobalt
        return label
    }()

    private lazy var acceptsMPLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoRegularFontSize16()
        label.textColor = .forest
        return label
    }()

    private lazy var imageContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var detailContainerView: UIView = {
         let view = UIView()
         view.translatesAutoresizingMaskIntoConstraints = false
         return view
     }()

    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    private var isPortrait: Bool {
        let size = UIScreen.main.bounds.size
        return size.width < size.height
    }
    var loadingView = LoadingView()
    var stateView = StateView()

    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = LocalizableStrings.detailTitle.localized
        NotificationCenter.default.addObserver(self, selector: #selector(updateLayout), name: UIDevice.orientationDidChangeNotification, object: nil)
        binding()
        setupLayout()
        setupImageView()
        setupDetailStackView()
        setupErrorView()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func updateLayout() {
        if isPortrait {
            containerStackView.axis = .vertical
        } else {
            containerStackView.axis = .horizontal
        }
    }

    private func binding() {
        startLoading()
        viewModel.getProductDetail()
        viewModel.updateState = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading:
                self.stopLoading()
            case .error:
                self.stopLoading()
                self.start(messageTitle: LocalizableStrings.errorMessage.localized,
                           stateImage: Assets.errorImage,
                           isShowReload: true)
            case .success:
                self.setupProduct()
                self.stopLoading()
            default:
                break
            }

        }
    }

    private func setupProduct() {
        guard let product = viewModel.product else { return }
        productImageView.sd_setImage(with: URL(string: product.pictures.first?.url ?? ""),
                                          placeholderImage: UIImage(named: "placeholder"),
                                          options: [],
                                          context: nil)
        titleLabel.text = product.title
        addressLabel.text = LocalizableStrings.addressMessage.localizedFormat(product.address)
        priceLabel.text = LocalizableStrings.priceMessage.localizedFormat(product.priceWithCurrency)
        warrantyLabel.text = product.warranty
        stockLabel.text = product.stockAvailable ? LocalizableStrings.availableStockMessage.localized :
            LocalizableStrings.notAvailableMessage.localized
        acceptsMPLabel.text = LocalizableStrings.acceptsMPMessage.localized
        acceptsMPLabel.isHidden = !product.acceptsMercadopago
    }

    private func setupErrorView() {
        stateView.onTryAgainDidPressed = { [weak self] in
            self?.viewModel.getProductDetail()
        }
    }

    private func setupLayout() {
        view.addSubview(containerStackView)
        containerStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerStackView.addArrangedSubview(imageContainerView)
        containerStackView.addArrangedSubview(detailContainerView)
        updateLayout()
    }

    private func setupImageView() {
        imageContainerView.addSubview(productImageView)
        productImageView.topAnchor.constraint(equalTo: imageContainerView.layoutMarginsGuide.topAnchor).isActive = true
        productImageView.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor, constant: 10).isActive = true
        productImageView.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor, constant: -10).isActive = true
        productImageView.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant:  -10).isActive = true
    }

    private func setupDetailStackView() {
        detailContainerView.addSubview(detailStackView)
        detailStackView.topAnchor.constraint(equalTo: detailContainerView.topAnchor, constant: 10).isActive = true
        detailStackView.leadingAnchor.constraint(equalTo: detailContainerView.leadingAnchor, constant: 10).isActive = true
        detailStackView.trailingAnchor.constraint(equalTo: detailContainerView.trailingAnchor, constant: -10).isActive = true
        detailStackView.addArrangedSubview(titleLabel)
        detailStackView.addArrangedSubview(addressLabel)
        detailStackView.addArrangedSubview(priceLabel)
        detailStackView.addArrangedSubview(warrantyLabel)
        detailStackView.addArrangedSubview(stockLabel)
        detailStackView.addArrangedSubview(acceptsMPLabel)
    }
}
