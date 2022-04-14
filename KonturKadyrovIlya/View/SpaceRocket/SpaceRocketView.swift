//
//  SpaceRocketView.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 13.04.2022.
//

import UIKit

class SpaceRocketView: UIView {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let wrapperView: UIView = {
        let wrapperView = UIView()
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        return wrapperView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .black
        contentView.layer.cornerRadius = Constants.cornerRadiusContentView
        contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return contentView
    }()
    
    private let titleView: LabelButtonView = {
        let titleView = LabelButtonView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        return titleView
    }()
    
    private let parameterCollectionView: ParameterRocketCollection = {
        let parameterRocketCollection = ParameterRocketCollection()
        parameterRocketCollection.translatesAutoresizingMaskIntoConstraints = false
        return parameterRocketCollection
    }()
    
    private let commonInformationRocketView: CommonInformationRocketView = {
        let commonInformationRocketView = CommonInformationRocketView()
        commonInformationRocketView.translatesAutoresizingMaskIntoConstraints = false
        return commonInformationRocketView
    }()
    
    private let viewLaunchesButton: UIButton = {
        let viewLaunchesButton = UIButton()
        viewLaunchesButton.translatesAutoresizingMaskIntoConstraints = false
        viewLaunchesButton.titleLabel?.font = .boldSystemFont(ofSize: Constants.viewLaunchesButtonFontSize)
        viewLaunchesButton.tintColor = .white
        viewLaunchesButton.backgroundColor = Constants.viewLaunchesButtonBackgroundColor
        viewLaunchesButton.layer.cornerRadius = Constants.viewLaunchesButtonCornerRadius
        viewLaunchesButton.setTitle(Constants.viewLaunchesButtonBottomTitle, for: .normal)
        return viewLaunchesButton
    }()
    
    private var viewLaunchesButtonAction: (()->Void)?
    
    init() {
        super.init(frame: .zero)
        setupUI()
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateData(model: SpaceRocketModel) {
        updateImageView(flickrImages: model.flickrImages)
        updateTitleView(name: model.name)
        parameterCollectionView.updateCollectionParameters(height: model.height,
                                                           diameter: model.diameter,
                                                           mass: model.mass,
                                                           payloadWeights: model.payloadWeights)
        commonInformationRocketView.updateView(firstFlight: model.firstFlight,
                                               country: model.country,
                                               costPerLaunch: model.costPerLaunch,
                                               firstStage: model.firstStage,
                                               secondStage: model.secondStage)
    }
    
    func setupViewLaunchesButtonAction(action: @escaping (()->Void)) {
        viewLaunchesButtonAction = action
    }
    
    private func setupButton() {
        viewLaunchesButton.addTarget(self, action: #selector(viewLaunchesButtonActionCall), for: .touchUpInside)
    }
    
    @objc private func viewLaunchesButtonActionCall() {
        viewLaunchesButtonAction?()
    }
    
    private func updateTitleView(name: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.maximumLineHeight = Constants.titleMaxLineHeight
        paragraphStyle.minimumLineHeight = Constants.titleMaxLineHeight
        let labelAttrString = NSAttributedString(string: name,
                                                 attributes: [.font:  UIFont(name: Constants.titleNameFont, size: Constants.titleFontSize) ?? .boldSystemFont(ofSize: Constants.titleFontSize),
                                                              .paragraphStyle: paragraphStyle,
                                                              .foregroundColor: UIColor.white])
        
        let viewModel = LabelButtonViewModel(labelAttrString: labelAttrString, buttonImage: UIImage(systemName: Constants.systemNameSettingImage))
        titleView.viewModel = viewModel
    }
    
    private func updateImageView(flickrImages: [String]) {
        guard flickrImages.count > 0 else { return }
        UIImage.load(from: flickrImages[0]) { [weak self] image in
            self?.imageView.image = image
        }
    }
    
    private func setupUI() {
        addSubview(scrollView)
        scrollView.addSubview(wrapperView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            wrapperView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            wrapperView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            wrapperView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            wrapperView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            wrapperView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        let heightConstraint = wrapperView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightConstraint.priority = UILayoutPriority(rawValue: Constants.heightWrapperViewPriority)
        heightConstraint.isActive = true
        
        wrapperView.addSubview(imageView)
        wrapperView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: wrapperView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: wrapperView.widthAnchor, multiplier: Constants.multiplierHeightImage),
            
            contentView.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: wrapperView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -Constants.topConstraintContentView),
            contentView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -Constants.bottomConstraintContentView)
        ])
        
        contentView.addSubview(titleView)
        contentView.addSubview(parameterCollectionView)
        contentView.addSubview(commonInformationRocketView)
        contentView.addSubview(viewLaunchesButton)
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.titleViewTopInset),
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.titleViewRightInset),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.titleViewRightInset),
            
            
            parameterCollectionView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: Constants.parameterCollectionViewTopInset),
            parameterCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            parameterCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            parameterCollectionView.heightAnchor.constraint(equalToConstant: Constants.sizeCollectionParameter),
            
            
            commonInformationRocketView.topAnchor.constraint(equalTo: parameterCollectionView.bottomAnchor,
                                                             constant: Constants.commonInformationTopInset),
            commonInformationRocketView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.commonInformationLeftRightInset),
            commonInformationRocketView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.commonInformationLeftRightInset),
            
            
            
            viewLaunchesButton.heightAnchor.constraint(equalToConstant: Constants.viewLaunchesButtonHeight),
            viewLaunchesButton.topAnchor.constraint(equalTo: commonInformationRocketView.bottomAnchor,
                                                    constant: Constants.viewLaunchesButtonTopInset),
            viewLaunchesButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.viewLaunchesButtonLeftRightInset),
            viewLaunchesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.viewLaunchesButtonLeftRightInset),
            viewLaunchesButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.viewLaunchesButtonBottomInset)
            
            
            
        ])
    }
    
}

//MARK: - Constants

private extension SpaceRocketView {
    enum Constants {
        static let baseBottomAnchor: CGFloat = 10
        static let topConstraintContentView: CGFloat = 30
        static let bottomConstraintContentView: CGFloat = 20
        static let cornerRadiusContentView: CGFloat = 30
        static let multiplierHeightImage: CGFloat = 1.08
        static let sizeCollectionParameter: CGFloat = 96
        
        static let titleViewTopInset: CGFloat = 48
        static let titleViewLeftInset: CGFloat = 32
        static let titleViewRightInset: CGFloat = 32
        static let titleMaxLineHeight: CGFloat = 32
        static let titleFontSize: CGFloat = 24
        static let titleNameFont = "LabGrotesque-Medium"
        
        static let parameterCollectionViewTopInset: CGFloat = 32
        
        static let heightWrapperViewPriority: Float = 250
        
        static let systemNameSettingImage = "gearshape"
        
        static let commonInformationTopInset: CGFloat = 40
        static let commonInformationLeftRightInset: CGFloat = 32
        
        static let viewLaunchesButtonFontSize: CGFloat = 18
        static let viewLaunchesButtonBackgroundColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 1)
        static let viewLaunchesButtonCornerRadius: CGFloat = 12
        
        static let viewLaunchesButtonTopInset: CGFloat = 40
        static let viewLaunchesButtonLeftRightInset: CGFloat = 32
        static let viewLaunchesButtonHeight: CGFloat = 56
        static let viewLaunchesButtonBottomInset: CGFloat = 90
        static let viewLaunchesButtonBottomTitle = "Посмотреть запуски"
    }
}
