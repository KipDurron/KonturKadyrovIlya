//
//  SettingParametersRocketViewController.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 15.04.2022.
//

import UIKit

class SettingParametersRocketViewController: UIViewController {
    
    private let parameterRealmService = ParameterRealmService()
    
    private var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar(frame: .zero)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
    
    private var parametersCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ParameterSettingCell.self, forCellWithReuseIdentifier: "\(ParameterSettingCell.self)")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private var parameters = [ParameterRealmModel]()
    
    var actionWhenDismiss: (()->Void)?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        parametersCollectionView.delegate = self
        parametersCollectionView.dataSource = self
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchParameters()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(
            alongsideTransition: { _ in self.parametersCollectionView.collectionViewLayout.invalidateLayout() }
        )
    }
    
    private func fetchParameters() {
        parameters = parameterRealmService.loadAll()
        parametersCollectionView.reloadData()
    }
    
    private func setupUI() {
        view.backgroundColor = Constants.backgroundColor
        setupNavigationBar()
        setupParameterCollection()
    }
    
    private func setupParameterCollection() {
        view.addSubview(parametersCollectionView)
        NSLayoutConstraint.activate([
            parametersCollectionView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor,
                                                          constant: Constants.topInsetContentView),
            parametersCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            parametersCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            parametersCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func getChangeSegmentAction() -> ActionChangeSegmentType {
        return { [weak self] (name, index) in
            guard let self = self else { return }
            _ = self.parameterRealmService.updateSelectedSegmentIndex(name: name,
                                                                      selectedSegmentIndex: index)
        }
    }
    
    private func setupNavigationBar() {
        view.addSubview(navigationBar)
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: Constants.heightNavigationBar),
        ])
        
        let navigationItem = UINavigationItem(title: Constants.titlePage)
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = Constants.backgroundColor
        navigationBarAppearance.shadowColor = nil
        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: Constants.sizeFontTitleButton)
        ]
        navigationBar.standardAppearance = navigationBarAppearance
        
        let closeItem = UIBarButtonItem(title: Constants.closeButtonTitle, style: .plain, target: nil, action: #selector(closeButtonAction))
        closeItem.setTitleTextAttributes([
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: Constants.sizeFontTitleButton)
        ], for: .normal)
        navigationItem.rightBarButtonItem = closeItem
        navigationBar.setItems([navigationItem], animated: false)
    }
    
    @objc private func closeButtonAction() {
        dismiss(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        actionWhenDismiss?()
    }
}

//MARK: - Collection extention

extension SettingParametersRocketViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        parameters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ParameterSettingCell.self)", for: indexPath) as! ParameterSettingCell
        cell.viewModel = parameters[indexPath.item].buildViewModel(action: getChangeSegmentAction())
        return cell
    }
}

extension SettingParametersRocketViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.safeAreaLayoutGuide.layoutFrame.width - (Constants.leftRightInsetContentView * 2) , height: Constants.heightCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Constants.lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets.init(top: Constants.insetForSectionTop, left: Constants.insetForSectionLeft, bottom: Constants.insetForSectionBottom, right: Constants.insetForSectionRight)
    }
}

//MARK: - Constants

private extension SettingParametersRocketViewController {
    enum Constants {
        static let titlePage = "Настройки"
        static let closeButtonTitle = "Закрыть"
        
        static let sizeFontTitleButton: CGFloat = 16
        
        static let cornerRadius: CGFloat = 12
        static let backgroundColor = UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1)
        
        static let heightNavigationBar: CGFloat = 56
        static let lineSpacing: CGFloat = 24
        
        static let heightParameterLabel = "Высота"
        static let diameterParameterLabel = "Диаметр"
        static let massParameterLabel = "Масса"
        static let payloadParameterLabel = "Полезная нагрузка"
        
        static let topInsetContentView: CGFloat = 40
        static let leftRightInsetContentView: CGFloat = 28
        
        static let heightCell:CGFloat = 40
        
        static let insetForSectionTop: CGFloat = 0
        static let insetForSectionLeft: CGFloat = 0
        static let insetForSectionRight: CGFloat = 0
        static let insetForSectionBottom: CGFloat = 10
        
        
        
    }
}
