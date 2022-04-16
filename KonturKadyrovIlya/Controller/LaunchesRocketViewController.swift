//
//  LaunchesRocketViewController.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 14.04.2022.
//

import UIKit

class LaunchesRocketViewController: UIViewController {
    
    //MARK: - Properties
    
    private var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(LaunchRocketCell.self, forCellWithReuseIdentifier: "\(LaunchRocketCell.self)")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .black
        return collectionView
    }()
    
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
    
    private var rocketId: String
    private var rocketName: String
    private var launches = [LaunchModel]()
    private let spaceRocketService = SpaceRocketService()
    
    //MARK: - life cycle
    
    init(rocketId: String, rocketName: String) {
        self.rocketId = rocketId
        self.rocketName = rocketName
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        super.init(nibName: nil, bundle: nil)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadLaunches()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    //MARK: - Private methods
    
    private func setupUI() {
        view.addSubview(collectionView)
        view.addSubview(spinner)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = rocketName
    }
    
    private func loadLaunches() {
        removeErrorViewIfExist()
        spinner.startAnimating()
        spaceRocketService.getLaunchesRocket(rocketId: rocketId) { [weak self] result in
            guard let self = self else { return }
            self.spinner.stopAnimating()
            switch result {
            case .complete(let launches):
                self.launches = launches
                self.collectionView.reloadData()
                if launches.isEmpty {
                    self.showError(viewModel: BaseErrorViewModel(title: Constants.emptyMessageText,
                                                                 refreshButtonAction: self.getActionErrorView()))
                }
            case .error(let text):
                self.showError(viewModel: BaseErrorViewModel(refreshButtonAction: self.getActionErrorView()))
                print(text)
            }
        }
    }
    
    //MARK: - Setup Error view
    
    private func getActionErrorView() -> (()->Void) {
        return { [weak self] in
            guard let self = self else { return }
            self.loadLaunches()
        }
    }
    
    private func showError(viewModel: BaseErrorViewModel) {
        errorView.viewModel = viewModel
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

//MARK: - Collection extentions

extension LaunchesRocketViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        launches.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(LaunchRocketCell.self)", for: indexPath) as! LaunchRocketCell
        let curentLaunch = launches[indexPath.item]
        cell.setData(name: curentLaunch.name,
                     dateUnix: curentLaunch.dateUnix,
                     success: curentLaunch.success)
        return cell
    }
}

extension LaunchesRocketViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.safeAreaLayoutGuide.layoutFrame.width - (Constants.baseInse * 2), height: Constants.heightCell)
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
        static let tagOfErrorView = 100
        static let emptyMessageText = "Данных нет"
    }
}
