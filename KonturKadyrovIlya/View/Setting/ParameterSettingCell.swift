//
//  ParameterSettingCell.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 15.04.2022.
//

import UIKit

class ParameterSettingCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private var leftLabel: UILabel = {
        let leftLabel = UILabel()
        leftLabel.numberOfLines = 0
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        return leftLabel
    }()
    
    private var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["", ""])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    var viewModel: ParameterSettingViewModel? {
        didSet {
            updateData()
        }
    }
    
    //MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    
    private func setupUI() {
        addSubview(leftLabel)
        addSubview(segmentedControl)
    
        NSLayoutConstraint.activate([
            leftLabel.topAnchor.constraint(equalTo: segmentedControl.topAnchor),
            leftLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftLabel.trailingAnchor.constraint(equalTo: segmentedControl.leadingAnchor,
                                                constant: -Constants.minRightInsetLabel),
            leftLabel.bottomAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            
            segmentedControl.topAnchor.constraint(equalTo: topAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor),
            segmentedControl.bottomAnchor.constraint(equalTo: bottomAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: Constants.maxHeightSegment),
            segmentedControl.widthAnchor.constraint(equalToConstant: Constants.maxWidthSegment),
            
        ])
        setupSegmentedControlView()
    }
    
    private func setupSegmentedControlView() {
        let titleTextAttributesNormal: [NSAttributedString.Key : Any] = [
            .backgroundColor: Constants.normalBackgroundColorSegment,
            .foregroundColor: Constants.normalFontColorSegment,
            .font: UIFont.boldSystemFont(ofSize: Constants.normalFontSizeSegment)
        ]
        let titleTextAttributesSelected: [NSAttributedString.Key : Any] = [
            .backgroundColor: UIColor.white,
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: Constants.normalFontSizeSegment)
        ]
        segmentedControl.setTitleTextAttributes(titleTextAttributesNormal, for: .normal)
        segmentedControl.setTitleTextAttributes(titleTextAttributesSelected, for: .selected)
        segmentedControl.addTarget(self, action: #selector(changeSegmentedControlActionCall), for: .valueChanged)
    }
    
    
    private func setupLeftLabel(text: String) {
        let attrString = NSAttributedString(string: text, attributes: [.font:  UIFont.systemFont(ofSize: Constants.sizeFontLeftLabel), .foregroundColor: UIColor.white])
        leftLabel.attributedText = attrString
    }
    
    @objc private func changeSegmentedControlActionCall(sender: UISegmentedControl) {
        guard let viewModel = viewModel else { return }
        viewModel.action?(viewModel.model.name, sender.selectedSegmentIndex)
    }
    
    private func updateData() {
        guard let viewModel = viewModel else { return }
        
        segmentedControl.selectedSegmentIndex = viewModel.model.selectedSegmentIndex
        segmentedControl.setTitle(viewModel.model.leftTitleSegmentText, forSegmentAt: 0)
        segmentedControl.setTitle(viewModel.model.rightTitleSegmentText, forSegmentAt: 1)
        setupLeftLabel(text: viewModel.model.labelName)
    }
    
}

//MARK: - Constants

private extension ParameterSettingCell {
    enum Constants {
        static let minRightInsetLabel: CGFloat = 10
        static let multiplierWidth: CGFloat = 0.36
        static let multiplierHeight: CGFloat = 0.35
        static let maxHeightRightlabel: CGFloat = 50
        
        static let normalFontColorSegment = UIColor(red: 0.557, green: 0.557, blue: 0.561, alpha: 1)
        static let normalBackgroundColorSegment = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 1)
        static let normalFontSizeSegment = 13.7
        
        static let sizeFontLeftLabel: CGFloat = 16
        static let maxHeightSegment: CGFloat = 40
        static let maxWidthSegment: CGFloat = 115
        
    }
}
