//
//  CompositeImageView.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 14.04.2022.
//

import UIKit

class CompositeImageView: UIView {
    
    //MARK: - Properties
    
    private var baseImageView: UIImageView = {
        let baseImageView = UIImageView()
        baseImageView.translatesAutoresizingMaskIntoConstraints = false
        return baseImageView
    }()
    
    private var subImageView: UIImageView = {
        let subImageView = UIImageView()
        subImageView.translatesAutoresizingMaskIntoConstraints = false
        return subImageView
    }()
    
    //MARK: - life cycle

    init() {
        super.init(frame: .zero)
        addSubview(baseImageView)
        baseImageView.addSubview(subImageView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(baseImage: UIImage?, subImage: UIImage?) {
        baseImageView.image = baseImage
        subImageView.image = subImage
    }
    
    //MARK: - Private methods
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            baseImageView.topAnchor.constraint(equalTo: topAnchor),
            baseImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            baseImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            baseImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            subImageView.heightAnchor.constraint(equalTo: baseImageView.heightAnchor, multiplier: Constants.multiplierHeight),
            subImageView.widthAnchor.constraint(equalTo: subImageView.heightAnchor),
            subImageView.trailingAnchor.constraint(equalTo: baseImageView.trailingAnchor),
            subImageView.bottomAnchor.constraint(equalTo: baseImageView.bottomAnchor),
        ])
    }
}

//MARK: - Constants

private extension CompositeImageView {
    enum Constants {
        static let multiplierHeight: CGFloat = 0.38
    }
}
