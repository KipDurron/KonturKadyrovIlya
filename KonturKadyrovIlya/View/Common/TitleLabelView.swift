//
//  TitleHeaderCollection.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 14.04.2022.
//

import UIKit

class TitleLabelView: UIView {
    
    //MARK: - Properties
    
    private var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    //MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateData(titleText: String) {
        let paragraphNumberStyle = NSMutableParagraphStyle()
        paragraphNumberStyle.maximumLineHeight = Constants.maximumLineHeightTitle
        paragraphNumberStyle.minimumLineHeight = Constants.maximumLineHeightTitle
        let titleAttrString = NSAttributedString(string: titleText.uppercased(),
                                                 attributes: [.font:  UIFont(name: Constants.fontName
                                                                             , size: Constants.sizeTitleFont) ?? .boldSystemFont(ofSize: Constants.sizeTitleFont),
                                                              .paragraphStyle: paragraphNumberStyle,
                                                              .foregroundColor: UIColor.white])
        titleLabel.attributedText = titleAttrString
    }
    
    //MARK: - Private methods
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}


//MARK: - Constants

private extension TitleLabelView {
    enum Constants {
        
        static let sizeTitleFont: CGFloat = 16
        static let maximumLineHeightTitle: CGFloat = 24
        static let fontName = "LabGrotesque-Bold"
        
    }
}
