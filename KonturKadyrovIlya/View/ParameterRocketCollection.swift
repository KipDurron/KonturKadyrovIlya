//
//  ParameterRocketCollection.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 13.04.2022.
//

import UIKit

class ParameterRocketCollection: UIView {
    
    var parameterArray: [ParameterItem] = []
    
    var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ParameterRocketCell.self, forCellWithReuseIdentifier: "\(ParameterRocketCell.self)")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    init() {
        super.init(frame: .zero)
        addSubview(collectionView)
        setupConstraints()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func updateWith(parameterArray: [ParameterRocketCollection.ParameterItem]) {
        self.parameterArray = parameterArray
        self.collectionView.reloadData()
    }
    
    func updateCollectionParameters(height: LengthType,
                                    diameter: LengthType,
                                    mass: Mass,
                                    payloadWeights: [PayloadWeight]) {
        let loadLeo = payloadWeights.filter { payload in
            payload.id == Constants.payloadId
        }.first
        var parametersList = [ParameterRocketCollection.ParameterItem]()
        
        var heightResult = Constants.emptyString
        if let height = height.feet {
            heightResult = String(describing: height)
        }
        parametersList.append(.init(number: heightResult, descroptionText: Constants.heightParameterLabel + Constants.ftLabel))
        
        var diameterResult = Constants.emptyString
        if let diameter = diameter.feet {
            diameterResult = String(describing: diameter)
        }
        
        parametersList.append(.init(number: diameterResult, descroptionText: Constants.diameterParameterLabel + Constants.ftLabel))
        
        parametersList.append(.init(number: String(describing: mass.lb.withCommas()), descroptionText: Constants.massParameterLabel + Constants.lbLabel))
        
        var loadResult = Constants.emptyString
        if let loadLeo = loadLeo {
            loadResult = String(describing:loadLeo.lb.withCommas())
        }
        
        parametersList.append(.init(number: loadResult, descroptionText: Constants.payloadParameterLabel + Constants.lbLabel))
        
        updateWith(parameterArray: parametersList)
    }
}

extension ParameterRocketCollection: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        parameterArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ParameterRocketCell.self)", for: indexPath) as! ParameterRocketCell
        cell.setData(data: parameterArray[indexPath.row])
        return cell
    }
}

extension ParameterRocketCollection: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.sizeCell, height: Constants.sizeCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets.init(top: 0, left: Constants.horizontalInset, bottom: 0, right: Constants.horizontalInset)
    }
}

//MARK: - Nested types

extension ParameterRocketCollection {
    struct ParameterItem {
        var number: String
        var descroptionText: String
    }
}

//MARK: - Constants

private extension ParameterRocketCollection {
    enum Constants {
        static let sizeCell: CGFloat = 96
        static let horizontalInset: CGFloat = 32
        
        static let payloadId = "leo"
        
        static let heightParameterLabel = "Высота"
        static let diameterParameterLabel = "Диаметр"
        static let massParameterLabel = "Масса"
        static let payloadParameterLabel = "Нагрузка"
        static let ftLabel = ", ft"
        static let lbLabel = ", lb"
        static let emptyString = "-"
    }
}
