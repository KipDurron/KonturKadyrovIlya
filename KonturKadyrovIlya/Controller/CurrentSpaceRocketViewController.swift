//
//  CurrentSpaceRocketViewController.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 12.04.2022.
//

import UIKit

class CurrentSpaceRocketViewController: UIViewController {
    
    private let spaceRocketView: SpaceRocketView = {
        let spaceRocketView = SpaceRocketView()
        return spaceRocketView
    }()
    
    private var spaceRocketModel: SpaceRocketModel
    private var indexPage: Int
    
    override func loadView() {
        view = spaceRocketView
    }
    
    init(with spaceRocketModel: SpaceRocketModel, indexPage: Int) {
        self.spaceRocketModel = spaceRocketModel
        self.indexPage = indexPage
        super.init(nibName: nil, bundle: nil)
    }
    
    func getIndexPage() -> Int{
        return indexPage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        updateViewData()
    }
    
    private func updateViewData() {
        let launchesButtonAction = getLaunchesButtonAction()
        let settingButtonAction = getSettingButtonAction()
        spaceRocketView.updateData(model: spaceRocketModel,
                                   launchesButtonAction: launchesButtonAction,
                                   settingButtonAction: settingButtonAction)
    }
    
    private func getLaunchesButtonAction() -> (()->Void) {
        return { [weak self] in
            guard let self = self else { return }
            let launchesRocketViewController = LaunchesRocketViewController(rocketId: self.spaceRocketModel.id,
                                                                            rocketName: self.spaceRocketModel.name)
            self.navigationController?.pushViewController(launchesRocketViewController, animated: true)
        }
    }
    
    private func getSettingButtonAction() -> (()->Void) {
        return { [weak self] in
            guard let self = self else { return }
            let settingParametersRocketViewController = SettingParametersRocketViewController()
            self.present(settingParametersRocketViewController, animated: true)
        }
    }
}

