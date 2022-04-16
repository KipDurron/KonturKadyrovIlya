//
//  BaseErrorView.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 16.04.2022.
//

import UIKit

class BaseErrorView: UIView {
    
    //MARK: - Properties
    
    private var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .boldSystemFont(ofSize: Constants.fontSizeTitle)
        titleLabel.textColor = .white
        return titleLabel
    }()
    
    private var refreshButton: UIButton = {
        let refreshButton = UIButton()
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        refreshButton.titleLabel?.font = .systemFont(ofSize: Constants.fontSizeTitleButton)
        refreshButton.setTitleColor(.white, for: .normal)
        refreshButton.backgroundColor = Constants.backgroundColorButton
        refreshButton.layer.cornerRadius = Constants.cornerRadius
        return refreshButton
    }()
    
    
    var viewModel: BaseErrorViewModel? {
        didSet {
            updateData()
        }
    }
    
    //MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(titleLabel)
        addSubview(refreshButton)
        setupConstraints()
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: refreshButton.topAnchor, constant: -20),
            refreshButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            refreshButton.heightAnchor.constraint(equalToConstant: Constants.heightButton),
            refreshButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                                   constant: Constants.leftRightButtonInset),
            refreshButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                                   constant: -Constants.leftRightButtonInset),
        ])
    }
    
    private func setupButton() {
        refreshButton.addTarget(self, action: #selector(refreshButtonAction), for: .touchUpInside)
    }
    
    @objc private func refreshButtonAction() {
        viewModel?.refreshButtonAction?()
    }
    
    private func updateData() {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.title
        refreshButton.setTitle(viewModel.titleButton, for: .normal)
    }
}

//MARK: - BaseErrorView

private extension BaseErrorView {
    enum Constants {
        static let fontSizeTitle: CGFloat = 24
        static let fontSizeTitleButton: CGFloat = 16
        static let backgroundColorButton = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 1)
        static let heightButton: CGFloat = 50
        static let leftRightButtonInset: CGFloat = 32
        static let cornerRadius: CGFloat = 12
    }
}
