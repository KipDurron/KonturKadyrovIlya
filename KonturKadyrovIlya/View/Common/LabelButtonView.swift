import UIKit

class LabelButtonView: UIView {

    private var label: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private var rightButtonImageView: UIImageView = {
        let rightButton = UIImageView()
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.isHidden = true
        rightButton.tintColor = .white
        return rightButton
    }()
    
    var viewModel: LabelButtonViewModel? {
        didSet {
            updateData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        addSubview(rightButtonImageView)
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(rightButtonAction))
        rightButtonImageView.addGestureRecognizer(tapGR)
        rightButtonImageView.isUserInteractionEnabled = true
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            rightButtonImageView.topAnchor.constraint(equalTo: label.topAnchor, constant: Constants.topInsetButton),
            rightButtonImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightButtonImageView.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: -Constants.bottomInsetButton),
            rightButtonImageView.widthAnchor.constraint(equalTo: rightButtonImageView.heightAnchor)
        ])
    }
    
    func updateData() {
        guard let viewModel = viewModel else {return}
        label.attributedText = viewModel.labelAttrString
        if let buttonImage = viewModel.buttonImage {
            rightButtonImageView.isHidden = false
            rightButtonImageView.image = buttonImage
        }
    }
    
    @objc private func rightButtonAction() {
        viewModel?.actionButton?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

//MARK: - Constants

private extension LabelButtonView {
    enum Constants {
        static let leadingAnchorRightButton: CGFloat = 20
        static let heightAnchorButton: CGFloat = 32
        static let topInsetButton: CGFloat = 2.5
        static let bottomInsetButton: CGFloat = 2.5
    }
}
