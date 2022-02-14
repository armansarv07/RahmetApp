//
//  MyOrders.swift
//  Rahmet
//
//  Created by Arman on 09.02.2022.
//

import UIKit

enum Section: Int, CaseIterable {
    case order
}

class MyOrders: UIViewController {
    var loggedIn = true
    
    let orders = Bundle.main.decode([TemporaryOrder].self, from: "choco.json")
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, TemporaryOrder>!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        setupNavigationBar()
        setup()
        print(orders.count)
    }
}


extension MyOrders: LayoutForNavigationVC {
    func setup() {
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
        dataSource = UICollectionViewDiffableDataSource<Section, TemporaryOrder>(collectionView: collectionView) { (collectionView, indexPath, order) -> UICollectionViewCell? in
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
        var snapshot = NSDiffableDataSourceSnapshot<Section, TemporaryOrder>()
        snapshot.appendSections([.order])
        snapshot.appendItems(orders, toSection: .order)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
}




import SwiftUI

struct MyOrdersProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let ordersVC = MainTabBarController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return ordersVC
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
