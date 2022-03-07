//
//  MenuHeaderView.swift
//  Rahmet
//
//  Created by Arman on 01.03.2022.
//

import UIKit


class MenuHeaderView: UIView {
    
    var gallery: [PhotoModel] = [] {
        didSet {
            self.reloadData()
            self.pageView.text = "1/\(gallery.count)"
            self.pageView.isHidden = false
            self.menuButton.isHidden = false
        }
    }
    
    var tableCompletion: ((Int) -> Void)?
    
    var deselectIndex: Int = 0
    
    var segments: [Segment] = [] {
        didSet {
            self.reloadSegmentsData()
        }
    }
    
    var address: String = "" {
        didSet {
            addressLabel.text = address
        }
    }
    
    var onCompletion: ((IndexPath) -> Void)?
    
    var selectedIndex: Int = 1
    
    var collectionView: UICollectionView!
    var segmentsView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<MenuSection, AnyHashable>!
    var segmentsDataSource: UICollectionViewDiffableDataSource<SegmentsSection, AnyHashable>!
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .gray
        return label
    }()
    
    let menuButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "menu"), for: .normal)
        button.isHidden = true
        return button
    }()
    
    let pageView: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white.withAlphaComponent(0.8)
        label.textColor = .black
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.isHidden = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        setupConstraints()
        createDataSource()
        reloadData()
        setupSegments()
        createSegmentsDataSource()
        reloadSegmentsData()
        setupPageLabel()
        setSelected()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuHeaderView: UICollectionViewDelegate {
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let collectionView = scrollView as? UICollectionView else { return }
        collectionView.allowsSelection = false
    }
    
}

extension MenuHeaderView {
    private func setupConstraints() {
        self.addSubview(addressLabel)
        self.addSubview(menuButton)
        self.addSubview(pageView)
        addressLabel.frame = .init(x: 16, y: collectionView.bottom + 16, width: 250, height: 36)
        menuButton.frame = .init(x: 16, y: addressLabel.bottom + 16, width: 30, height: 30)
        pageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(180 - 42)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(24)
            make.width.equalTo(40)
        }
    }
    private func setupPageLabel() {
        pageView.text = "1/\(gallery.count)"
    }
    
    private func setSelected() {
        DispatchQueue.main.async {
            guard let cell = self.segmentsView.cellForItem(at: IndexPath(item: self.selectedIndex, section: 0)) as? SegmentedCell else {
                return
            }
            cell.titleButton.backgroundColor = .blue
        }
    }
}

extension MenuHeaderView {
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .init(x: 0, y: 0, width: Constants.screenWidth, height: 180), collectionViewLayout: createCompostionalLayout())
        self.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseId)
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
                let photo = data as! PhotoModel
                let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseId, for: indexPath) as! PhotoCell
                let urlImage = URL(string: photo.photoUrl)
                if let url = urlImage {
                    photoCell.imageView.load(url: url)
                }
                
                return photoCell
            }
        })
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<MenuSection, AnyHashable>()
        snapshot.appendSections([.photos])
        snapshot.appendItems(gallery, toSection: .photos)
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
        section.visibleItemsInvalidationHandler = { [weak self] (items, offset, env) -> Void in
            guard let strongSelf = self else { return }
            strongSelf.pageView.text = "\(1 + Int(round(offset.x / Constants.screenWidth)))/\(strongSelf.gallery.count)"
        }
        
        
        return section
    }
 }

extension MenuHeaderView {
    private func setupSegments() {
        segmentsView = UICollectionView(frame: .init(x: menuButton.right, y: menuButton.top, width: Constants.screenWidth - menuButton.width - 16, height: menuButton.height), collectionViewLayout: createSegmentsLayout())
        self.addSubview(segmentsView)
        segmentsView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        segmentsView.register(SegmentedCell.self, forCellWithReuseIdentifier: SegmentedCell.reuseId)
    }
    
    private func createSegmentsLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let section = SegmentsSection(rawValue: sectionIndex) else {
                fatalError("Invalid Section Kind")
            }
            switch section {
            case .segments: return self.createSegmentsSection()
            }
        }
        return layout
    }
    
    private func createSegmentsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.8))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(220), heightDimension: .absolute(30))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.interGroupSpacing = 25
        
        return section
    }
    
    private func createSegmentsDataSource() {
        segmentsDataSource = UICollectionViewDiffableDataSource<SegmentsSection, AnyHashable>(collectionView: segmentsView, cellProvider: { collectionView, indexPath, data in
            guard let section = SegmentsSection(rawValue: indexPath.section) else {
                fatalError("Unknown section")
            }
            switch section {
            case .segments:
                let segment = data as! Segment
                let cell = self.segmentsView.dequeueReusableCell(withReuseIdentifier: SegmentedCell.reuseId, for: indexPath) as! SegmentedCell
                cell.titleButton.setTitle(segment.title, for: .normal)
                cell.index = indexPath.item
                cell.onCompletion = {[weak self] index in
                    self?.segmentsView.deselectAllItems(animated: true)
                    self?.tableCompletion?(index)
                }
                return cell
            }
        })
    }
    
    private func reloadSegmentsData() {
        var snapshot = NSDiffableDataSourceSnapshot<SegmentsSection, AnyHashable>()
        snapshot.appendSections([.segments])
        snapshot.appendItems(segments, toSection: .segments)
        segmentsDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
}




import SwiftUI
struct MenuHeaderVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    struct ContainerView: UIViewControllerRepresentable {
        let menuVC = MenuViewController(restaurant: Restaurant(restaurant: RestaurantDataModel(restaurantData: DetailedRestaurant(id: 1, name: "Mamma Mia", location: "Baker Street 221B", createdAt: "20.02.2022", updatedAt: "20.02.2022", images: []), image: nil)))
        func makeUIViewController(context: Context) -> some UIViewController {
            return NavigationVCGenerator.generateNavigationController(rootViewController: menuVC, image: UIImage(), title: "Title", prefersLargeTitle: true)
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
}
