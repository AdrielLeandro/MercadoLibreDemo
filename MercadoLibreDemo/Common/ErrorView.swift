//
//  StateView.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 9/1/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import Foundation
import UIKit

protocol StateProtocol: class {
    var stateView: StateView { get }
    func start(messageTitle: String, stateImage: UIImage?, isShowReload: Bool)
    func stopState()
}

extension StateProtocol where Self: UIViewController {
    func start(messageTitle: String, stateImage: UIImage?, isShowReload: Bool) {
        stateView.setup(messageTitle: messageTitle, stateImage: stateImage, isShowReload: isShowReload)
        view.addSubview(stateView)
        stateView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 56).isActive = true
        stateView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stateView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stateView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func stopState() {
        stateView.removeFromSuperview()
    }
}

class StateView: UIView {
    var onTryAgainDidPressed: (() -> Void)?
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()

    lazy var reloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.lightGray, for: .normal)
        button.setTitle(LocalizableStrings.reloadTitle.localized, for: .normal)
        button.titleLabel?.font = .robotoRegularFontSize16()
        button.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)
        return button
    }()

    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoRegularFontSize20()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        setupImage()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupImage() {
        addSubview(imageView)
        addSubview(messageLabel)
        addSubview(reloadButton)
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -40).isActive = true

        messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true

        reloadButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        reloadButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 15).isActive = true
    }

    func setup(messageTitle: String, stateImage: UIImage?, isShowReload: Bool) {
        messageLabel.text = messageTitle
        imageView.image = stateImage
        reloadButton.isHidden = !isShowReload
    }

    @objc private func tryAgain() {
        onTryAgainDidPressed?()
    }
}
