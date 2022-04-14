//
//  LaunchesRocketViewController.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 14.04.2022.
//

import UIKit

class LaunchesRocketViewController: UICollectionViewController {
    
    private var rocketId: String
    private var rocketName: String
    private var launches = [LaunchModel]()
    private let spaceRocketService = SpaceRocketService()
    
    init(rocketId: String, rocketName: String) {
        self.rocketId = rocketId
        self.rocketName = rocketName
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        super.init(collectionViewLayout: flowLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .black
        setupNavigationBar()
        collectionView.register(LaunchRocketCell.self, forCellWithReuseIdentifier: "\(LaunchRocketCell.self)")
        loadLaunches()
    }
    
    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        title = rocketName
    }
    
    private func loadLaunches() {
        spaceRocketService.getLaunchesRocket(rocketId: rocketId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .complete(let launches):
                self.launches = launches
                self.collectionView.reloadData()
            case .error(let text):
                print(text)
            }
            
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        launches.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(LaunchRocketCell.self)", for: indexPath) as! LaunchRocketCell
        let cuurentLaunch = launches[indexPath.item]
        cell.setData(name: cuurentLaunch.name,
                     dateUnix: cuurentLaunch.dateUnix,
                     success: cuurentLaunch.success)
        return cell
    }
}

extension LaunchesRocketViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - (Constants.baseInse * 2), height: Constants.heightCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets.init(top: Constants.insetForSectionTop, left: Constants.insetForSectionLeft, bottom: Constants.insetForSectionBottom, right: Constants.insetForSectionRight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Constants.lineSpacing
    }
}

//MARK: - Constants

private extension LaunchesRocketViewController {
    enum Constants {
        static let baseInse: CGFloat = 32
        static let heightCell: CGFloat = 100
        static let insetForSectionTop: CGFloat = 50
        static let insetForSectionLeft: CGFloat = 0
        static let insetForSectionRight: CGFloat = 0
        static let insetForSectionBottom: CGFloat = 50
        static let lineSpacing: CGFloat = 16
    }
}
