//
//  MenuHeaderView.swift
//  Rahmet
//
//  Created by Arman on 01.03.2022.
//

import UIKit


class MenuHeaderView: UIView {
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<MenuSection, AnyHashable>!
    var gallery: [PhotoModel] = [] {
        didSet {
            self.reloadData()
        }
    }
    
    var segments: [Segment] = [] {
        didSet {
            self.reloadData()
        }
    }
    
    var address: String!
    
    var restaurantData: RestaurantDataModel
    var gallery: [RestaurantImage] = []
    
    init(restaurantData: RestaurantDataModel, frame: CGRect) {
        self.restaurantData = restaurantData
        super.init(frame: frame)
        setupCollectionView()
        createDataSource()
        reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuHeaderView {
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: createCompostionalLayout())
        self.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseId)
        collectionView.register(SegmentedCell.self, forCellWithReuseIdentifier: SegmentedCell.reuseId)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
    }
    
    private func createCompostionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let section = MenuSection(rawValue: sectionIndex) else {
                fatalError("Invalid Section Kind")
            }
            switch section {
            case .photos:
                return self.createPhotosSection()
            case .segments:
                return self.createSegmentsSection()
            }
        }
        return layout
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<MenuSection, AnyHashable>(collectionView: collectionView, cellProvider: { collectionView, indexPath, data in
            guard let section = MenuSection(rawValue: indexPath.section) else {
                fatalError("Unknown section")
            }
            switch section {
            case .photos:
                let photo = data as! RestaurantImage
                let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseId, for: indexPath) as! PhotoCell
                if let data = photo.imageURL {
                    let urlImage = URL(string: data)
                    if let url = urlImage {
                        photoCell.imageView.load(url: url)
                    }
                let urlImage = URL(string: photo.photoUrl)
                if let url = urlImage {
                    photoCell.imageView.load(url: url)
                }
                photoCell.paginationLabel.text = "\(indexPath.item + 1)/\(self.gallery.count)"
                return photoCell
            case .segments:
                let segmentCell = collectionView.dequeueReusableCell(withReuseIdentifier: SegmentedCell.reuseId, for: indexPath) as! SegmentedCell
                segmentCell.title.text = self.segments[indexPath.item].title
                segmentCell.isFirst = indexPath.item == 0 ? true : false
                return segmentCell
            }
        })
        dataSource.supplementaryViewProvider = {
            [weak self] collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else {
                fatalError("Section header is invalid")
            }
            sectionHeader.configure(text: self.restaurantData.restaurantData?.location ?? "", font: .systemFont(ofSize: 14), textColor: .gray)
            return sectionHeader
        }
    }
    
    private func reloadData() {
        gallery = restaurantData.restaurantData?.images ?? []
        var snapshot = NSDiffableDataSourceSnapshot<MenuSection, AnyHashable>()
        snapshot.appendSections([.photos, .segments])
        snapshot.appendItems(gallery, toSection: .photos)
        snapshot.appendItems(segments, toSection: .segments)
        dataSource.apply(snapshot)
    }
    
    private func createPhotosSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        section.interGroupSpacing = 0
        
        let sectionHeader = createAddressFooter()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    private func createSegmentsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(200), heightDimension: .absolute(30))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 30
        return section
    }
    
    private func createAddressFooter() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .bottom)
        return sectionHeader
    }
 }


//import SwiftUI
//struct MenuHeaderVCProvider: PreviewProvider {
//    static var previews: some View {
//        ContainerView().edgesIgnoringSafeArea(.all)
//    }
//    struct ContainerView: UIViewControllerRepresentable {
//        let menuVC = MenuViewController(restaurant: Restaurant(restaurant: RestaurantDataModel(restaurantData: DetailedRestaurant(id: 1, name: "Mamma Mia", location: "Baker Street 221B", createdAt: "20.02.2022", updatedAt: "20.02.2022", images: []), image: nil)))
//        func makeUIViewController(context: Context) -> some UIViewController {
//            return NavigationVCGenerator.generateNavigationController(rootViewController: menuVC, image: UIImage(), title: "Title", prefersLargeTitle: true)
//        }
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//        }
//    }
//}
