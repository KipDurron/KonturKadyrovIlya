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
                                    payloadWeights: [PayloadWeight],
                                    settingParameters: [ParameterRealmModel]) {
        
        var parametersList = [ParameterRocketCollection.ParameterItem]()
        
        let heightParameterRealModel = settingParameters.filter { parameter in
            parameter.name == ParameterNameEnum.height.rawValue
        }.first
        
        parametersList.append(makeLengthParameter(lengthParameter: height, parameterRealModel: heightParameterRealModel, descriptionString: Constants.heightParameterLabel))
        
        let diameterParameterRealModel = settingParameters.filter { parameter in
            parameter.name == ParameterNameEnum.diameter.rawValue
        }.first
        
        parametersList.append(makeLengthParameter(lengthParameter: diameter, parameterRealModel: diameterParameterRealModel, descriptionString: Constants.diameterParameterLabel))
        
        let massParameterRealModel = settingParameters.filter { parameter in
            parameter.name == ParameterNameEnum.mass.rawValue
        }.first
        
        parametersList.append(makeMassParameter(massParameter: mass, parameterRealModel: massParameterRealModel, withCommas: true, descriptionString: Constants.massParameterLabel))
        
        let loadLeo = payloadWeights.filter { payload in
            payload.id == Constants.payloadId
        }.first
        
        let payloadParameterRealModel = settingParameters.filter { parameter in
            parameter.name == ParameterNameEnum.payload.rawValue
        }.first
        
        parametersList.append(makeMassParameter(massParameter: loadLeo?.mass, parameterRealModel: payloadParameterRealModel, withCommas: true, descriptionString: Constants.payloadParameterLabel))
        
        updateWith(parameterArray: parametersList)
    }
    
    private func makeMassParameter(massParameter: Mass?,
                                   parameterRealModel: ParameterRealmModel?,
                                   withCommas: Bool = false,
                                   descriptionString: String = "") -> ParameterRocketCollection.ParameterItem {
        var resultTypeParameter: String = ""
        var massResult = Constants.dash
        
        if let massParameter = massParameter {
            if let parameterRealModel = parameterRealModel {
                resultTypeParameter = parameterRealModel.getTypeParameter()
            }
            if resultTypeParameter == KgLbEnum.kg.rawValue {
                massResult = withCommas ? massParameter.kg.withCommas() : String(describing: massParameter.kg)
            }
            if resultTypeParameter == KgLbEnum.lb.rawValue {
                massResult = withCommas ? massParameter.lb.withCommas() : String(describing: massParameter.lb)
            }
        }
        return .init(number: massResult,
                     descroptionText: descriptionString + Constants.comma + resultTypeParameter)
    }
    
    private func makeLengthParameter(lengthParameter: LengthType,
                                     parameterRealModel: ParameterRealmModel?,
                                     descriptionString: String = "") -> ParameterRocketCollection.ParameterItem {
        var resultTypeParameter: String = ""
        var heightResult = Constants.dash
        
        if let parameterRealModel = parameterRealModel {
            resultTypeParameter = parameterRealModel.getTypeParameter()
        }
        
        if resultTypeParameter == MFtEnum.m.rawValue {
            if let height = lengthParameter.feet {
                heightResult = String(describing: height)
            }
        }
        
        if resultTypeParameter == MFtEnum.ft.rawValue {
            if let height = lengthParameter.meters {
                heightResult = String(describing: height)
            }
        }
        return .init(number: heightResult,
                     descroptionText: descriptionString + Constants.comma + resultTypeParameter)
    }
}

extension ParameterRocketCollection: UICollectionViewDataSource {
    
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
        static let dash = "-"
        static let comma = ", "
    }
}
