//
//  AllSpaceRocketsViewController.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 13.04.2022.
//

import UIKit

class AllSpaceRocketsViewController: UIViewController {
    
    private let spaceRocketService = SpaceRocketService()
    private var spaceRocketsList = [SpaceRocketModel]()
    
    private var pageController: UIPageViewController?
    private var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllSpaceRockets()
    }
    
    private func loadAllSpaceRockets() {
        spaceRocketService.getSpaceRockets { [weak self] requestResult in
            guard let self = self else { return }
            switch requestResult {
            case .complete(let models):
                self.spaceRocketsList = models
                self.setupPageController()
            case .error(let text):
                print(text)
            }
        }
    }
    
    private func setupPageController() {
        
        let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        pageController.dataSource = self
        pageController.delegate = self
        self.addChild(pageController)
        self.view.addSubview(pageController.view)
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            pageController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pageController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pageController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        
        
        let initialVC = CurrentSpaceRocketViewController(with: self.spaceRocketsList[0], indexPage: 0)
        
        pageController.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
        
        pageController.didMove(toParent: self)
        
        pageController.view.backgroundColor = Constants.pageControlColor
        
        self.pageController = pageController
    }
}

//MARK: - UIPageViewController extention

extension AllSpaceRocketsViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = viewController as? CurrentSpaceRocketViewController
        else {
            return nil
        }
        var index = currentVC.getIndexPage()
        
        if index == 0 {
            return nil
        }
        
        index -= 1
        
        let vc: CurrentSpaceRocketViewController = CurrentSpaceRocketViewController(with: spaceRocketsList[index], indexPage: index)
        
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = viewController as? CurrentSpaceRocketViewController else {
            return nil
        }
        
        var index = currentVC.getIndexPage()
        
        if index >= self.spaceRocketsList.count - 1 {
            return nil
        }
        
        index += 1
        
        let vc: CurrentSpaceRocketViewController = CurrentSpaceRocketViewController(with: spaceRocketsList[index], indexPage: index)
        
        return vc
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.spaceRocketsList.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.currentIndex
    }
}

//MARK: - Constants

private extension AllSpaceRocketsViewController {
    enum Constants {
        static let pageControlColor = UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1)
    }
}
