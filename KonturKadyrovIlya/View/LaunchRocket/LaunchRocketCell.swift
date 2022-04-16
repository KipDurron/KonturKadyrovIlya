//
//  LaunchesRocketView.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 14.04.2022.
//

import UIKit

class LaunchRocketCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Constants.dateLocal)
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = Constants.dateFormatTo
        return dateFormatter
    }()
    
    private var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 0
        nameLabel.lineBreakMode = .byTruncatingTail
        return nameLabel
    }()
    
    private var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
    private var compositeImageView: CompositeImageView = {
        let compositeImageView = CompositeImageView()
        compositeImageView.translatesAutoresizingMaskIntoConstraints = false
        return compositeImageView
    }()
    
    //MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = Constants.cornerRadiusCell
        contentView.backgroundColor = Constants.backgroundColorCell
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(compositeImageView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(name: String, dateUnix: Int, success: Bool) {
        setupNameLabel(name: name)
        setupDateLabel(dateUnix:dateUnix)
        setupCompositeImageView(success: success)
    }
    
    //MARK: - Private methods
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.baseInset),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.baseInset),
            nameLabel.trailingAnchor.constraint(equalTo: compositeImageView.leadingAnchor, constant: -Constants.baseInset),
            nameLabel.heightAnchor.constraint(equalTo: dateLabel.heightAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.spacingLabels),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.baseInset),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.baseInset),
            dateLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            compositeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            compositeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.baseInset),
            compositeImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: Constants.compositeViewMultiplier),
            compositeImageView.heightAnchor.constraint(equalTo: compositeImageView.widthAnchor)
            
        ])
    }
    
    private func setupCompositeImageView(success: Bool) {
        switch success {
        case true:
            compositeImageView.setData(baseImage: UIImage(named: "rocket"), subImage: UIImage(named: "success"))
        case false:
            compositeImageView.setData(baseImage: UIImage(named: "rocket-reverse"), subImage: UIImage(named: "error"))
        }
    }
    
    private func setupDateLabel(dateUnix: Int) {
        let date = Date(timeIntervalSince1970: Double(dateUnix))
        let dateString = dateFormatter.string(from: date)
        let paragraphDateStyle = NSMutableParagraphStyle()
        paragraphDateStyle.maximumLineHeight = Constants.maximumLineHeightDate
        paragraphDateStyle.minimumLineHeight = Constants.maximumLineHeightDate
        let descriptionAttrString = NSAttributedString(string: dateString,
                                                 attributes: [.font:  UIFont(name: "LabGrotesque-Bold", size: Constants.sizeDateFont) ?? .systemFont(ofSize: Constants.sizeDateFont),
                                                              .paragraphStyle: paragraphDateStyle,
                                                              .foregroundColor: Constants.dateColor])
        dateLabel.attributedText = descriptionAttrString
    }
    
    private func setupNameLabel(name: String) {
        let paragraphNameStyle = NSMutableParagraphStyle()
        paragraphNameStyle.maximumLineHeight = Constants.maximumLineHeightName
        paragraphNameStyle.minimumLineHeight = Constants.maximumLineHeightName
        let numberAttrString = NSAttributedString(string: name,
                                                 attributes: [.font:  UIFont(name: "LabGrotesque-Bold", size: Constants.sizeNameFont) ?? .boldSystemFont(ofSize: Constants.sizeNameFont),
                                                              .paragraphStyle: paragraphNameStyle,
                                                              .foregroundColor: UIColor.white])
        nameLabel.attributedText = numberAttrString
    }
}

//MARK: - Constants

private extension LaunchRocketCell {
    enum Constants {
        static let baseInset: CGFloat = 24
        static let spacingLabels: CGFloat = 4
        static let widthMultiplier: CGFloat = 0.6
        static let compositeViewMultiplier: CGFloat = 0.32
        
        static let sizeNameFont: CGFloat = 20
        static let maximumLineHeightName: CGFloat = 28

        static let sizeDateFont: CGFloat = 16
        static let maximumLineHeightDate: CGFloat = 24
        
        static let backgroundColorCell = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 1)
        static let dateColor = UIColor(red: 0.557, green: 0.557, blue: 0.561, alpha: 1)
        
        static let cornerRadiusCell: CGFloat = 24
        static let dateLocal = "ru_RU"
        static let dateFormatTo = "dd MMMM, yyyy"
    }
}

