//
//  MyOrders.swift
//  Rahmet
//
//  Created by Arman on 09.02.2022.
//

import UIKit
import SwiftKeychainWrapper

enum Section: Int, CaseIterable {
    case order
}

class MyOrders: UIViewController {

    var loggedIn = KeychainWrapper.standard.string(forKey: Constants.tokenKey) != nil ? true : false
    var userOrders: [OrdersData] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, OrdersData>!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        setupNavigationBar()
        setup()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func getData() {
        APIClient.getOrders() { result in // temp
            switch result {
            case .success(let message):
                print(message)
                if let orders = message.data?.order {
                    self.userOrders = orders
                }
                self.reloadData()
            case .failure(let error):
                print(error.errorDescription)
                print(result)
            }
        }
    }
}

extension MyOrders: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = OrderDetailed(order: userOrders[indexPath.row])
        navigationController?.pushViewController(vc, animated: false)
    }
}


extension MyOrders: LayoutForNavigationVC {

    func setup() {
        self.tabBarController?.tabBar.isHidden = false
        if !loggedIn {
//            collectionView.isHidden = true
            let requireLoginLabel: UILabel = {
                let label = UILabel()
                label.text = "Войдите в свой аккаунт"
                label.font = .systemFont(ofSize: 18, weight: .bold)
                label.textAlignment = .center
                return label
            }()
            let loginDescriptionLabel: UILabel = {
                let label = UILabel()
                label.text = "Необходимо войти в свой аккаунт, чтобы увидеть историю заказов"
                label.font = .systemFont(ofSize: 16, weight: .regular)
                label.numberOfLines = 0
                label.textAlignment = .center
                return label
            }()
            
            
            let labelStack = UIStackView(arrangedSubviews: [requireLoginLabel, loginDescriptionLabel], axis: .vertical, spacing: 16)
            
            
            let loginButton = BlueButton(text: "Войти")
            
            view.addSubview(labelStack)
            view.addSubview(loginButton)
            
            labelStack.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalToSuperview().inset(32)
                make.trailing.equalToSuperview().inset(32)
            }
            loginButton.snp.makeConstraints { make in
                make.trailing.leading.equalToSuperview().inset(45)
                make.height.equalTo(44)
                make.top.equalTo(labelStack.snp.bottom).offset(32)
            }
            
        } else {
            setupCollectionView()
            createDataSource()
            reloadData()
        }
    }
    
    func setupConstraints() {
        
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Мои заказы"
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.register(OrderCell.self, forCellWithReuseIdentifier: OrderCell.reuseId)
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let section = Section(rawValue: sectionIndex) else {
                fatalError("Invalid Section Kind")
            }
            
            switch section {
            case .order:
                return self.createOrderSection()
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    func createOrderSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let spacing = CGFloat(15)
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 16)
        return section
    }
    
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, OrdersData>(collectionView: collectionView) { (collectionView, indexPath, order) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Unknown section")
            }
            
            switch section {
            case .order:
                return self.configure(collectionView: collectionView, cellType: OrderCell.self, with: order, for: indexPath)
            }
        }
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, OrdersData>()
        snapshot.appendSections([.order])
        snapshot.appendItems(userOrders, toSection: .order)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
}
