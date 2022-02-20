//
//  Menu.swift
//  Rahmet
//
//  Created by Arman on 12.02.2022.
//

import UIKit

enum MenuSection: Int, CaseIterable {
    case photos, segments
}

class Menu: UIViewController {
    let cafe: Cafe
    
    let menu: MenuModel = MenuModel(id: 1)
    let gallery: [PhotoModel] = [
        PhotoModel(id: 1, photoName: "rest1"),
        PhotoModel(id: 2, photoName: "rest2"),
        PhotoModel(id: 3, photoName: "rest3"),
        PhotoModel(id: 4, photoName: "rest4")
    ]
    
    let segments = [
        Segment(id: 1, title: "Menu"),
        Segment(id: 2, title: "Пицца"),
        Segment(id: 3, title: "Напитки"),
        Segment(id: 4, title: "Салаты"),
        Segment(id: 5, title: "Супы")
    ]
    
    
    
    
    var gallerySource: UICollectionViewDiffableDataSource<MenuSection, AnyHashable>!
    
    var collectionView: UICollectionView!
    
    var page: Double
    
    init(cafe: Cafe) {
        self.cafe = cafe
        self.page = 0
        super.init(nibName: nil, bundle: nil)
    }
    
    let pageLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        label.font = .systemFont(ofSize: 16)
        label.textColor = .blue
        label.layer.cornerRadius = 5
        return label
    }()
    
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

        createDataSource()
        reloadData()

        setupConstraints()
    }
    
}

extension Menu: LayoutForNavigationVC {
    func setupConstraints() {
        collectionView.addSubview(pageLabel)
        pageLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView).inset(180)
            make.leading.equalTo(collectionView).inset(16)
        }
    }
    
    func setupNavigationBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = nil
        navigationItem.title = cafe.name
    }
    
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseId)
        collectionView.register(SegmentedCell.self, forCellWithReuseIdentifier: SegmentedCell.reuseId)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
    }
    


    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let section = MenuSection(rawValue: sectionIndex) else {
                fatalError("Invalid Section Kind")
            }
            
            switch section {
            case .photos: return self.createPhotosSection()
            case .segments: return self.createSegmentsSection()
            }
        }
        return layout
    }
    
    func createPhotosSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(180))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        section.interGroupSpacing = 0
        section.visibleItemsInvalidationHandler = { [weak self] (items, offset, env) -> Void in
            guard let strongSelf = self else { return }
            strongSelf.page = round(offset.x / strongSelf.view.width)
        }
        
        let sectionHeader = createAddressHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    func createDataSource() {
        gallerySource = UICollectionViewDiffableDataSource<MenuSection, AnyHashable>(collectionView: collectionView, cellProvider: { collectionView, indexPath, data in
            guard let section = MenuSection(rawValue: indexPath.section) else {
                fatalError("Unknown section")
            }
            switch section {
            case .photos:
                let photo = data as! PhotoModel
                let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseId, for: indexPath) as! PhotoCell
                photoCell.imageView.image = UIImage(named: photo.photoName)!
                photoCell.paginationLabel.text = "\(indexPath.item + 1)/\(self.gallery.count)"
                return photoCell
            case .segments:
                let segmentCell = collectionView.dequeueReusableCell(withReuseIdentifier: SegmentedCell.reuseId, for: indexPath) as! SegmentedCell
                segmentCell.title.text = self.segments[indexPath.item].title
                return segmentCell
            }
        })
        gallerySource.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else {
                fatalError("Section header is invalid")
            }
            sectionHeader.configure(text: "ул. Панфилова 109", font: .systemFont(ofSize: 14), textColor: .gray)
            return sectionHeader
        }
        
        /// Set  or galllery data source
        
        
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<MenuSection, AnyHashable>()
        snapshot.appendSections([.photos, .segments])
        snapshot.appendItems(gallery, toSection: .photos)
        snapshot.appendItems(segments, toSection: .segments)
        gallerySource.apply(snapshot, animatingDifferences: true)

    }
    
    private func createSegmentsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .absolute(30))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func createAddressHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .bottom)
        return sectionHeader
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
