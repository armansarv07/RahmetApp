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
    // MARK: Data storage
    
    var categories: [ProductCategories] = []
    
    var sections = [CategorySection]()
    
    let id: Int
    
    var cartProducts: [CartItem] = []
    
    var imagesData: [MenuRestaurantImage] = []
    
    var deselectIndex: Int = 0
    
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
    
    // MARK: Internal methods of View Controller
    override func viewDidLoad() {
        tabBarController?.tabBar.isHidden = true
        fetchData()
        setupNavigationBar()
        setupConstraints()
        setupTableView()
    }
    
    init(id: Int) {
        self.id = id
        self.titleLabel.text = "Restaurant"
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
        headerView.menuButton.addTarget(self, action: #selector(categoriesButtonTapped), for: .touchUpInside)
        headerView.tableCompletion = {
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: $0), at: .top, animated: true)
            self.deselectIndex = $0
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.4
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    
    lazy var cartButton: BlueButton = {
        let button = BlueButton(text: "Корзина")
        button.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func cartButtonTapped() {
        let vc = CartView()
        vc.cartProducts = cartProducts
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func categoriesButtonTapped() {
        let vc = CategoriesViewController(categories: categories)
        vc.scrollCompletion = {
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: $0), at: .top, animated: true)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: Methods of Network logic
extension MenuViewController {
    private func fetchData() {
        spinner.show(in: tableView)
        AF.request(Constants.baseURL + "/menu/\(id)").validate().responseDecodable(of: Menu.self) { [weak self] (response) in
            guard let menu = response.value else { return }
            self?.imagesData = menu.data?.restaurantImages ?? []
            self?.categories = menu.data?.productCategories ?? []
            self?.spinner.dismiss(animated: true)
            self?.headerView.segments = (self?.createSegments(menu.data?.productCategories ?? []))!
            self?.headerView.gallery = (self?.createPhotoModels(menu.data?.restaurantImages ?? []))!
            self?.headerView.address = menu.data?.location ?? ""
            self?.titleLabel.text = menu.data?.restaurantName ?? ""
            self?.navigationItem.title = menu.data?.restaurantName ?? ""
            print(menu.data?.restaurantName ?? "")
            self?.tableView.reloadData()
        }
    }
}

// MARK: Delegating

extension MenuViewController: CartChangingDelegate {
    func changeQuantity(product: Product, quantity: Int) {
        let index = cartProducts.firstIndex { $0.product == product }
        if let idx = index {
            cartProducts[idx].quantity = quantity
            if quantity == 0 {
                cartProducts.remove(at: idx)
            }
        } else {
            cartProducts.append(CartItem(product: product, quantity: 1))
        }
        cartIsActive = !cartProducts.isEmpty
        print("done")
    }
    
}

// MARK: Data converters

extension MenuViewController {
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
        guard let product = categories[indexPath.section].products?[indexPath.row] else { return cell }
        cell.cartItem = CartItem(product: product, quantity: 0)
        cell.delegate = self
        cell.selectionStyle = .none
        
        if let firstVisibleIndexPath = tableView.indexPathsForVisibleRows?.first {
            self.headerView.segmentsView.selectItem(at: IndexPath(item: firstVisibleIndexPath.section, section: 0), animated: true, scrollPosition: .centeredVertically)
        }
        
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
            make.edges.equalToSuperview()
        }
    }
    
    func setupNavigationBar() {
        navigationItem.backButtonTitle = " "
        navigationItem.rightBarButtonItem = .init(title: "Вверх", style: .plain, target: self, action: #selector(scrollToTop))
    }
    
    @objc private func scrollToTop() {
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .bottom, animated: true)
    }
    
    private func cartAppear() {
        view.addSubview(cartButton)
        cartButton.isHidden = false
        cartButton.snp.remakeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        tableView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(Constants.screenHeight -
            68)
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

import SwiftUI
struct MenuVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    struct ContainerView: UIViewControllerRepresentable {
        let menuVC = MenuViewController(id: 1)
        func makeUIViewController(context: Context) -> some UIViewController {
            return NavigationVCGenerator.generateNavigationController(rootViewController: menuVC, image: UIImage(), title: "Title", prefersLargeTitle: true)
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
}
