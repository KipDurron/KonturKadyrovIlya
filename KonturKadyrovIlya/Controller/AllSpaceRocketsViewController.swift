//
//  AllSpaceRocketsViewController.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 13.04.2022.
//

import UIKit

class AllSpaceRocketsViewController: UIViewController {
    
    //MARK: - Properties
    
    private var errorView: BaseErrorView = {
        var errorView = BaseErrorView()
        errorView.tag = Constants.tagOfErrorView
        errorView.translatesAutoresizingMaskIntoConstraints = false
        return errorView
    }()
    
    private var spinner: UIActivityIndicatorView = {
        var spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .white
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let spaceRocketService = SpaceRocketService()
    private var spaceRocketsList = [SpaceRocketModel]()
    private let parameterRealmService = ParameterRealmService()
    private var errorViewModel = BaseErrorViewModel()
    private var pageController: UIPageViewController?
    private var currentIndex: Int = 0
    
    //MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageController()
        setupSpinner()
        setupErrorViewModel()
        loadAllSpaceRockets()
        setupNavigationBar()
        parameterRealmService.createStartParameters()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: - Private methods
    
    private func setupNavigationBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: Constants.titleBackButtonNavBar, style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .white
        
        let titleTextAttributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: Constants.sizeFontTitle)
        ]
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .black
        navigationBarAppearance.titleTextAttributes = titleTextAttributes
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
    
    private func loadAllSpaceRockets() {
        removeErrorViewIfExist()
        spinner.startAnimating()
        spaceRocketService.getSpaceRockets { [weak self] requestResult in
            guard let self = self else { return }
            self.spinner.stopAnimating()
            switch requestResult {
            case .complete(let models):
                self.spaceRocketsList = models
                self.setStartPageController()
            case .error(let text):
                self.showError()
                print(text)
            }
        }
    }
    
    private func setStartPageController() {
        let initialVC = CurrentSpaceRocketViewController(with: self.spaceRocketsList[0], indexPage: 0)
        pageController?.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
    }
    
    private func setupPageController() {
        let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageController.dataSource = self
        pageController.delegate = self
        self.addChild(pageController)
        self.view.addSubview(pageController.view)
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pageController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pageController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pageController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        pageController.didMove(toParent: self)
        
        pageController.view.backgroundColor = Constants.pageControlColor
        self.pageController = pageController
    }
    
    private func setupSpinner() {
        guard let pageController = pageController else { return }
        view.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo:  pageController.view.safeAreaLayoutGuide.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo:  pageController.view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    //MARK: - Setup Error view
    
    private func setupErrorViewModel() {
        errorViewModel.refreshButtonAction = { [weak self] in
            guard let self = self else { return }
            self.loadAllSpaceRockets()
        }
    }
    
    private func showError() {
        errorView.viewModel = errorViewModel
        view.addSubview(errorView)
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func removeErrorViewIfExist(){
        if let errorView = view.viewWithTag(Constants.tagOfErrorView) {
            errorView.removeFromSuperview()
        }
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
        static let titleBackButtonNavBar = "Назад"
        static let sizeFontTitle: CGFloat = 16
        static let tagOfErrorView = 100
    }
}
