//
//  SettingParametersRocketViewController.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 15.04.2022.
//

import UIKit

class SettingParametersRocketViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.titlePage
        view.backgroundColor = .red
    }
}

//MARK: - Constants

private extension SettingParametersRocketViewController {
    enum Constants {
        static let titlePage = "Настройки"
        //        static let pageControlColor = UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1)
        //        static let titleBackButtonNavBar = "Назад"
        //        static let sizeFontTitle: CGFloat = 16
    }
}
