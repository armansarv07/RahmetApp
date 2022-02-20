//
//  Menu.swift
//  Rahmet
//
//  Created by Arman on 12.02.2022.
//

import UIKit

class Menu: UIViewController {
    let cafe: Cafe
    
    let fakeCategoriesData = FakeCategories.shared.fakeCategoriesData
    
    let photos = FakePhotosDatabase.shared.database
    
    var pagingImages: UICollectionView!
    
    init(cafe: Cafe) {
        self.cafe = cafe
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
    }
    
    private lazy var categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = .init(width: Constants.screenWidth / 5, height: 50)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.contentInsetAdjustmentBehavior = .never
        cv.showsHorizontalScrollIndicator = false
        cv.contentOffset = .zero
        cv.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    private lazy var menuButton: UIButton = {
        let button = UIButton()
        button.alpha = 0.5
        button.setImage(UIImage.init(named: "menu"), for: .normal)
        button.addTarget(self, action: #selector(openMenuTableView), for: .touchUpInside)
        return button
    }()
    
    @objc func openMenuTableView() {
        let vc = CartView() // change!!!
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func setupViews() {
        setupCollectionView()
        view.addSubview(categoriesCollectionView)
        view.addSubview(menuButton)
        setupConstraints()
    }
    
}

extension Menu: LayoutForNavigationVC {
    func setupConstraints() {
        categoriesCollectionView.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.left.equalToSuperview().offset(50)
            make.top.equalToSuperview().offset(Constants.screenHeight / 4)
            make.height.equalTo(40)
        }
        
        menuButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(categoriesCollectionView).offset(8)
            make.width.height.equalTo(25)
        }
    }
    
    func setupNavigationBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = nil
        navigationItem.title = cafe.name
    }
    
    func setupCollectionView() {
        let y = navigationController?.view.height
        pagingImages = UICollectionView(frame: CGRect(x: 0, y: y ?? 0, width: view.width, height: 180), collectionViewLayout: UICollectionViewFlowLayout())
        pagingImages.backgroundColor = .cyan
        pagingImages.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "photo")
        view.addSubview(pagingImages)
        pagingImages.isPagingEnabled = true
//        view.addSubview(pagingImages)
    }
    
    
}


extension Menu: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == pagingImages {
            return photos.count
        }
        return fakeCategoriesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if collectionView == pagingImages {
            let cell = pagingImages.dequeueReusableCell(withReuseIdentifier: "photo", for: indexPath)
            cell.backgroundColor = .cyan
            return cell
        } else {
            guard let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseIdentifier, for: indexPath) as? CategoryCell else {
                fatalError("Wrong cell class dequeued")
            }
            cell.backgroundColor = .white
            cell.category = fakeCategoriesData[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == pagingImages {
            return CGSize(width: pagingImages.width, height: pagingImages.height)
        }
        return CGSize(width: Constants.screenWidth / 4, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
}


import SwiftUI
struct MenuVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    struct ContainerView: UIViewControllerRepresentable {
        let menuVC = Menu(cafe: Cafe(name: "Mamma Mia", address: "ул. Бухар жырау, 66, уг. ул. Ауэзова", imgName: "cafeImage"))
        func makeUIViewController(context: Context) -> some UIViewController {
            return NavigationVCGenerator.generateNavigationController(rootViewController: menuVC, image: UIImage(), title: "Title", prefersLargeTitle: true)
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
}
