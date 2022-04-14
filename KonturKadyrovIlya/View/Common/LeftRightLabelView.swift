//
//  CommonInformationRocketCell.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 14.04.2022.
//

import UIKit

class LeftRightLabelView: UIView {
    
    private var leftLabel: UILabel = {
        let leftLabel = UILabel()
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        return leftLabel
    }()
    
    private var rightLabel: UILabel = {
        let rightLabel = UILabel()
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        rightLabel.numberOfLines = 0
        return rightLabel
    }()
    
    
    init() {
        super.init(frame: .zero)
        addSubview(leftLabel)
        addSubview(rightLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            leftLabel.topAnchor.constraint(equalTo: topAnchor),
            leftLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            rightLabel.topAnchor.constraint(equalTo: leftLabel.topAnchor),
            rightLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leftLabel.trailingAnchor,
                                               constant: Constants.minRightInsetLabel),
            rightLabel.bottomAnchor.constraint(equalTo: leftLabel.bottomAnchor),
            rightLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: Constants.multiplierWidth),
            rightLabel.heightAnchor.constraint(lessThanOrEqualToConstant: Constants.maxHeightRightlabel)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(leftAttrString: NSAttributedString, rightAttrString: NSAttributedString) {
        leftLabel.attributedText = leftAttrString
        rightLabel.attributedText = rightAttrString
    }
    
}

//MARK: - Constants

private extension LeftRightLabelView {
    enum Constants {
        static let minRightInsetLabel: CGFloat = 19
        static let multiplierWidth: CGFloat = 0.5
        static let maxHeightRightlabel: CGFloat = 50
    }
}
