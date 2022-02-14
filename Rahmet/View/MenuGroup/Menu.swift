//
//  Menu.swift
//  Rahmet
//
//  Created by Arman on 12.02.2022.
//

import UIKit

class Menu: UIViewController {
    let cafe: Cafe
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
        setupCollectionView()
        
    }
    
}

extension Menu: LayoutForNavigationVC {
    func setupConstraints() {
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


extension Menu: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = pagingImages.dequeueReusableCell(withReuseIdentifier: "photo", for: indexPath)
        cell.backgroundColor = .cyan
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: pagingImages.width, height: pagingImages.height)
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
