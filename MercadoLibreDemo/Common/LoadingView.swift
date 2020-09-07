//
//  LoadingView.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 9/1/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import UIKit

protocol LoadingProtocol: class {
    var loadingView: LoadingView { get }
    func startLoading()
    func stopLoading()
}

extension LoadingProtocol where Self: UIViewController {
    func startLoading() {
        loadingView.frame.size = CGSize(width: view.bounds.width, height: view.bounds.height - 145)
        view.addSubview(loadingView)

        loadingView.loader.startAnimating()
    }

    func stopLoading() {
        loadingView.loader.stopAnimating()
        loadingView.removeFromSuperview()
    }

}

class LoadingView: UIView {
    lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.style = .medium
        loader.color = UIColor.gray
        return loader
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.white
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        setupActivityControl()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Error - Container Loader")
    }

    fileprivate func setupActivityControl() {
        addSubview(loader)
        loader.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
