//
//  SpaceRacketStageInfo.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 14.04.2022.
//

import UIKit

class SpaceRocketStageInfoView: UIView {
    
    private var titleLabel: TitleLabelView = {
        let titleLabel = TitleLabelView()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.stackSpacing
        return stackView
    }()
    
    private var countEnginesView: LeftRightLabelView = {
        let countEnginesView = LeftRightLabelView()
        countEnginesView.translatesAutoresizingMaskIntoConstraints = false
        return countEnginesView
    }()
    
    private var fuelAmountView: LeftRightLabelView = {
        let fuelAmountView = LeftRightLabelView()
        fuelAmountView.translatesAutoresizingMaskIntoConstraints = false
        return fuelAmountView
    }()
    
    private var burnTimeView: LeftRightLabelView = {
        let burnTimeView = LeftRightLabelView()
        burnTimeView.translatesAutoresizingMaskIntoConstraints = false
        return burnTimeView
    }()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(countEnginesView)
        contentStackView.addArrangedSubview(fuelAmountView)
        contentStackView.addArrangedSubview(burnTimeView)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                  constant: Constants.contentStackViewTopInset),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func updateView(titleName: String, stage: SpaceRocketStage) {
        titleLabel.updateData(titleText: titleName)
        
        setupCountEnginesInfo(count: stage.engines)
        
        setupFuelAmountInfo(fuelAmountTons: stage.fuelAmountTons)
        
        setupBurnTimeInfo(burnTimeSEC: stage.burnTimeSEC)
        
    }
    
    
    private func setupCountEnginesInfo(count: Int) {
        countEnginesView.setData(leftAttrString: setupCommonInfoLabelAttrString(string: Constants.countEnginesLabel), rightAttrString: setupCommonInfoValueAttrString(string: "\(count)"))
    }
    
    private func setupFuelAmountInfo(fuelAmountTons: Double) {
        let resultFuelAmountTons = NSMutableAttributedString()
        resultFuelAmountTons.append(setupCommonInfoValueAttrString(string: "\(fuelAmountTons)"))
        resultFuelAmountTons.append(NSAttributedString(string: Constants.space))
        resultFuelAmountTons.append(setupCommonInfoValueExtaAttrString(string: Constants.ton))
        
        fuelAmountView.setData(leftAttrString: setupCommonInfoLabelAttrString(string: Constants.fuelAmountTonsLabel), rightAttrString: resultFuelAmountTons)
    }
    
    private func setupBurnTimeInfo(burnTimeSEC: Int?) {
        var resultBurnTimeSEC = Constants.emptyString
        if let burnTimeSEC = burnTimeSEC {
            resultBurnTimeSEC = "\(burnTimeSEC)"
        }
        
        let resultFuelAmountTons = NSMutableAttributedString()
        resultFuelAmountTons.append(setupCommonInfoValueAttrString(string: resultBurnTimeSEC))
        if resultBurnTimeSEC != Constants.emptyString {
            resultFuelAmountTons.append(NSAttributedString(string: Constants.space))
            resultFuelAmountTons.append(setupCommonInfoValueExtaAttrString(string: Constants.sec))
        }
        burnTimeView.setData(leftAttrString: setupCommonInfoLabelAttrString(string: Constants.burnTimeSECLabel), rightAttrString: resultFuelAmountTons)

    }
    
    private func setupCommonInfoLabelAttrString(string: String) -> NSAttributedString {
        let paragraphNumberStyle = NSMutableParagraphStyle()
        paragraphNumberStyle.maximumLineHeight = Constants.commonInfoLabelLineHeight
        paragraphNumberStyle.minimumLineHeight = Constants.commonInfoLabelLineHeight
        return NSAttributedString(string: string,
                                  attributes: [.font:  UIFont(name: Constants.commonInfoLabelNameFont, size: Constants.commonInfoLabelFontSize) ?? .systemFont(ofSize: Constants.commonInfoLabelFontSize),
                                               .paragraphStyle: paragraphNumberStyle,
                                               .foregroundColor: Constants.commonInfoLabelColor])
    }
    
    private func setupCommonInfoValueAttrString(string: String) -> NSAttributedString {
        let paragraphNumberStyle = NSMutableParagraphStyle()
        paragraphNumberStyle.maximumLineHeight = Constants.commonInfoValueLineHeight
        paragraphNumberStyle.minimumLineHeight = Constants.commonInfoValueLineHeight
        return NSAttributedString(string: string,
                                  attributes: [.font:  UIFont(name: Constants.commonInfoValueNameFont, size: Constants.commonInfoValueFontSize) ?? .boldSystemFont(ofSize: Constants.commonInfoValueFontSize),
                                               .paragraphStyle: paragraphNumberStyle,
                                               .foregroundColor: Constants.commonInfoValueColor])
    }
    
    private func setupCommonInfoValueExtaAttrString(string: String) -> NSAttributedString {
        let paragraphNumberStyle = NSMutableParagraphStyle()
        paragraphNumberStyle.maximumLineHeight = Constants.commonInfoValueLineHeight
        paragraphNumberStyle.minimumLineHeight = Constants.commonInfoValueLineHeight
        return NSAttributedString(string: string,
                                  attributes: [.font:  UIFont(name: Constants.commonInfoValueNameFont, size: Constants.commonInfoValueFontSize) ?? .boldSystemFont(ofSize: Constants.commonInfoValueFontSize),
                                               .paragraphStyle: paragraphNumberStyle,
                                               .foregroundColor: Constants.commonInfoValueExtra])
    }
}

//MARK: - Constants

private extension SpaceRocketStageInfoView {
    enum Constants {
        static let countEnginesLabel = "Количество двигателей"
        static let fuelAmountTonsLabel = "Количество топлива"
        static let burnTimeSECLabel = "Время сгорания"
        static let emptyString = "-"
        
        static let stackSpacing: CGFloat = 16
        
        static let commonInfoLabelLineHeight: CGFloat = 24
        static let commonInfoLabelFontSize: CGFloat = 16
        static let commonInfoLabelNameFont = "LabGrotesque-Regular"
        static let commonInfoLabelColor = UIColor(red: 0.792, green: 0.792, blue: 0.792, alpha: 1)
        
        static let commonInfoValueLineHeight: CGFloat = 24
        static let commonInfoValueFontSize: CGFloat = 16
        static let commonInfoValueNameFont = "LabGrotesque-Regular"
        static let commonInfoValueColor = UIColor.white
        static let commonInfoValueExtra = UIColor(red: 0.557, green: 0.557, blue: 0.561, alpha: 1)
        
        static let contentStackViewTopInset: CGFloat = 16
        
        static let space = " "
        static let ton = "ton"
        static let sec = "sec"
    }
}


