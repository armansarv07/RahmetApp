//
//  MenuViewController.swift
//  Rahmet
//
//  Created by Arman on 01.03.2022.
//

import UIKit
import Alamofire
import JGProgressHUD

class MenuViewController: UIViewController {
    
    var categories: [ProductCategories] = []
    
    var sections = [CategorySection]()
    
    let restaurant: Restaurant
    
    var imagesData: [MenuRestaurantImage] = []
    
    var cartIsActive = false {
        didSet {
            if cartIsActive {
                self.cartAppear()
            } else {
                self.cartDisappear()
            }
        }
    }
    
    // MARK: UI Elements declaration
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    var headerView: MenuHeaderView!
    
    private let spinner = JGProgressHUD(style: .dark)
    
    let cartButton = BlueButton(text: "Корзина")
    
    // MARK: Internal methods of View Controller
    override func viewDidLoad() {
        tabBarController?.tabBar.isHidden = true
        fetchData()
        setupNavigationBar()
        setupConstraints()
        setupTableView()
    }
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        headerView = MenuHeaderView(frame: CGRect(x: 0, y: 0, width: Constants.screenWidth, height: 270))
        tableView.tableHeaderView = headerView
        tableView.register(MenuItemCell.self, forCellReuseIdentifier: MenuItemCell.reuseId)
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
}
// MARK: Methods of Network logic
extension MenuViewController {
    private func fetchData() {
        spinner.show(in: tableView)
        AF.request(Constants.baseURL + "/menu/1").validate().responseDecodable(of: Menu.self) { [weak self] (response) in
            guard let menu = response.value else { return }
            self?.imagesData = menu.data?.restaurantImages ?? []
            self?.categories = menu.data?.productCategories ?? []
            self?.spinner.dismiss(animated: true)
            self?.headerView.segments = (self?.createSegments(menu.data?.productCategories ?? []))!
            self?.headerView.gallery = (self?.createPhotoModels(menu.data?.restaurantImages ?? []))!
            self?.headerView.address = menu.data?.location ?? ""
            self?.tableView.reloadData()
        }
    }
    
    private func createSegments(_ value: [ProductCategories]) -> [Segment] {
        var segments = [Segment]()
        for category in value {
            let segment = Segment(id: category.id!, title: category.name!)
            segments.append(segment)
        }
        return segments
    }
    
    private func createPhotoModels(_ value: [MenuRestaurantImage]) -> [PhotoModel] {
        var photos = [PhotoModel]()
        for photo in value {
            let photoCell = PhotoModel(id: photo.imageID!, photoUrl: photo.url!)
            photos.append(photoCell)
        }
        return photos
    }
}


extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        self.categories[section].name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuItemCell.reuseId, for: indexPath) as! MenuItemCell
        cell.product = categories[indexPath.section].products?[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.categories[section].products?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.categories.count
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        170
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension MenuViewController: LayoutForNavigationVC {
    func setupConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func setupNavigationBar() {
        navigationItem.titleView = titleLabel
        titleLabel.text = restaurant.restaurant?.restaurantData?.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(toggleAction))
    }
    
    private func cartAppear() {
        view.addSubview(cartButton)
        cartButton.isHidden = false
        cartButton.snp.remakeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(60)
        }
        
        tableView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(Constants.screenHeight -
            90)
        }
    }
    
    private func cartDisappear() {
        cartButton.isHidden = true
        cartButton.snp.removeConstraints()
        tableView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


extension MenuViewController {
    @objc private func toggleAction() {
        cartIsActive.toggle()
        print(cartIsActive)
    }
}


import SwiftUI
struct MenuVCProvider: PreviewProvider {
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
