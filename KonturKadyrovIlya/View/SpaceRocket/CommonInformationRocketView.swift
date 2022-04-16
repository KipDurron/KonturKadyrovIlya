//
//  CommonInformationRocketView.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 14.04.2022.
//

import UIKit

class CommonInformationRocketView: UIView {
    
    //MARK: - Properties
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Constants.dateLocal)
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = Constants.dateFormatFrom
        return dateFormatter
    }()
    
    private var commonInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.stackSpacing
        return stackView
    }()
    
    private var firstFlightView: LeftRightLabelView = {
        let firstFlightView = LeftRightLabelView()
        firstFlightView.translatesAutoresizingMaskIntoConstraints = false
        return firstFlightView
    }()
    
    private var countryView: LeftRightLabelView = {
        let countryView = LeftRightLabelView()
        countryView.translatesAutoresizingMaskIntoConstraints = false
        return countryView
    }()
    
    private var costPerLaunchView: LeftRightLabelView = {
        let costPerLaunchView = LeftRightLabelView()
        costPerLaunchView.translatesAutoresizingMaskIntoConstraints = false
        return costPerLaunchView
    }()
    
    private var firstStageView: SpaceRocketStageInfoView = {
        let firstStage = SpaceRocketStageInfoView()
        firstStage.translatesAutoresizingMaskIntoConstraints = false
        return firstStage
    }()
    
    private var secondStageView: SpaceRocketStageInfoView = {
        let secondStage = SpaceRocketStageInfoView()
        secondStage.translatesAutoresizingMaskIntoConstraints = false
        return secondStage
    }()
    
    //MARK: - life cycle
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(firstFlight: String,
                    country: String,
                    costPerLaunch: Int,
                    firstStage: SpaceRocketStage,
                    secondStage: SpaceRocketStage) {
        setupFirstFlightInfo(firstFlight: firstFlight)
        setupCountryInfo(country: country)
        setupCostPerLaunchInfo(costPerLaunch: costPerLaunch)
        
        firstStageView.updateView(titleName: Constants.firstStageLabel, stage: firstStage)
        secondStageView.updateView(titleName: Constants.secondStageLabel, stage: secondStage)
        
    }
    
    //MARK: - Private methods
    
    private func setupUI() {
        addSubview(commonInfoStackView)
        addSubview(firstStageView)
        addSubview(secondStageView)
        
        commonInfoStackView.addArrangedSubview(firstFlightView)
        commonInfoStackView.addArrangedSubview(countryView)
        commonInfoStackView.addArrangedSubview(costPerLaunchView)
        
        NSLayoutConstraint.activate([
            commonInfoStackView.topAnchor.constraint(equalTo: topAnchor),
            commonInfoStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            commonInfoStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            firstStageView.topAnchor.constraint(equalTo: commonInfoStackView.bottomAnchor, constant: Constants.firstStageTopInset),
            firstStageView.leadingAnchor.constraint(equalTo: commonInfoStackView.leadingAnchor),
            firstStageView.trailingAnchor.constraint(equalTo: commonInfoStackView.trailingAnchor),
            
            secondStageView.topAnchor.constraint(equalTo: firstStageView.bottomAnchor,
                                             constant: Constants.firstStageTopInset),
            secondStageView.leadingAnchor.constraint(equalTo: commonInfoStackView.leadingAnchor),
            secondStageView.trailingAnchor.constraint(equalTo: commonInfoStackView.trailingAnchor),
            secondStageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
    
    private func setupCostPerLaunchInfo(costPerLaunch: Int) {
        costPerLaunchView.setData(leftAttrString: setupCommonInfoLabelAttrString(string: Constants.costPerLaunchLabel), rightAttrString: setupCommonInfoValueAttrString(string: Constants.dollar + costPerLaunch.toShortedFormat()))
    }
    
    private func setupCountryInfo(country: String) {
        countryView.setData(leftAttrString: setupCommonInfoLabelAttrString(string: Constants.countryLabel), rightAttrString: setupCommonInfoValueAttrString(string: country))
    }
    
    private func setupFirstFlightInfo(firstFlight: String) {
        let newDateFormatString = changeDateFormat(dateString: firstFlight)
        
        firstFlightView.setData(leftAttrString: setupCommonInfoLabelAttrString(string: Constants.firstFlightLabel), rightAttrString: setupCommonInfoValueAttrString(string: newDateFormatString))
        
        
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
                                  attributes: [.font:  UIFont(name: Constants.commonInfoValueNameFont, size: Constants.commonInfoValueFontSize) ?? .systemFont(ofSize: Constants.commonInfoValueFontSize),
                                               .paragraphStyle: paragraphNumberStyle,
                                               .foregroundColor: Constants.commonInfoValueColor])
    }
    
    private func changeDateFormat(dateString: String) -> String{
        let date = dateFormatter.date(from: dateString)
        guard let date = date else { return dateString }
        dateFormatter.dateFormat = Constants.dateFormatTo
        return dateFormatter.string(from: date)
    }
}

//MARK: - Constants

private extension CommonInformationRocketView {
    enum Constants {
        static let firstFlightLabel = "Первый запуск"
        static let countryLabel = "Страна"
        static let costPerLaunchLabel = "Стоимость запуска"
        static let firstStageLabel = "ПЕРВАЯ СТУПЕНЬ"
        static let secondStageLabel = "ВТОРАЯ СТУПЕНЬ"
        static let emptyString = "-"
        
        static let dateLocal = "ru_RU"
        static let dateFormatFrom = "yyyy-MM-dd"
        static let dateFormatTo = "dd MMMM, yyyy"
        
        static let stackSpacing: CGFloat = 16
        
        static let commonInfoLabelLineHeight: CGFloat = 24
        static let commonInfoLabelFontSize: CGFloat = 16
        static let commonInfoLabelNameFont = "LabGrotesque-Regular"
        static let commonInfoLabelColor = UIColor(red: 0.792, green: 0.792, blue: 0.792, alpha: 1)
        
        static let commonInfoValueLineHeight: CGFloat = 24
        static let commonInfoValueFontSize: CGFloat = 16
        static let commonInfoValueNameFont = "LabGrotesque-Regular"
        static let commonInfoValueColor = UIColor.white
        
        static let dollar = "$"
        
        static let firstStageTopInset: CGFloat = 40
    }
}
