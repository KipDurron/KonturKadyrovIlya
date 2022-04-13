//
//  ParameterRocketCell.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 13.04.2022.
//

import UIKit

class ParameterRocketCell: UICollectionViewCell {
    
    private var numberLabel: UILabel = {
        let numberLabel = UILabel()
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        return numberLabel
    }()
    
    private var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Constants.stackSpacing
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = Constants.cornerRadiusCell
        contentView.layer.backgroundColor = Constants.backgroundColorCell
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(numberLabel)
        stackView.addArrangedSubview(descriptionLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.stackTopInset),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.stackLeftInset),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.stackRightInset),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.stackBottomInset)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(data: ParameterRocketCollection.ParameterItem) {
        let paragraphNumberStyle = NSMutableParagraphStyle()
        paragraphNumberStyle.maximumLineHeight = Constants.maximumLineHeightNumber
        paragraphNumberStyle.minimumLineHeight = Constants.maximumLineHeightNumber
        let numberAttrString = NSAttributedString(string: data.number,
                                                 attributes: [.font:  UIFont(name: "LabGrotesque-Bold", size: Constants.sizeNumberFont) ?? .systemFont(ofSize: Constants.sizeNumberFont),
                                                              .paragraphStyle: paragraphNumberStyle,
                                                              .foregroundColor: UIColor.white])
        numberLabel.attributedText = numberAttrString
        
        let paragraphDecriptionStyle = NSMutableParagraphStyle()
        paragraphDecriptionStyle.maximumLineHeight = Constants.maximumLineHeightDescription
        paragraphDecriptionStyle.minimumLineHeight = Constants.maximumLineHeightDescription
        let descriptionAttrString = NSAttributedString(string: data.descroptionText,
                                                 attributes: [.font:  UIFont(name: "LabGrotesque-Bold", size: Constants.sizeDescriptionFont) ?? .systemFont(ofSize: Constants.sizeDescriptionFont),
                                                              .paragraphStyle: paragraphDecriptionStyle,
                                                              .foregroundColor: Constants.descriptionColor])
        descriptionLabel.attributedText = descriptionAttrString
        
    }
    
}

//MARK: - Constants

private extension ParameterRocketCell {
    enum Constants {
        static let stackSpacing: CGFloat = 4
        static let stackTopInset: CGFloat = 24
        static let stackBottomInset: CGFloat = 24
        static let stackLeftInset: CGFloat = 8
        static let stackRightInset: CGFloat = 8
        
        static let sizeNumberFont: CGFloat = 16
        static let maximumLineHeightNumber: CGFloat = 24
        
        static let sizeDescriptionFont: CGFloat = 13
        static let maximumLineHeightDescription: CGFloat = 20
        
        static let backgroundColorCell: CGColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 1).cgColor
        static let descriptionColor = UIColor(red: 0.557, green: 0.557, blue: 0.561, alpha: 1)
        
        static let cornerRadiusCell: CGFloat = 32
    }
}
