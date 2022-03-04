//
//  MenuViewController.swift
//  Rahmet
//
//  Created by Arman on 01.03.2022.
//

import UIKit

class MenuViewController: UIViewController {
    
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
    
    
    let pizzas: [Product] = [
        Product(id: 0, name: "Маргарита", price: 1600, description: nil, image: "pizza1"),
        Product(id: 1, name: "Пепперони", price: 1800, description: "Любая маленькая пицца на выбор, порция фри и Coca Cola", image: "pizza2"),
        Product(id: 2, name: "Мексиканская", price: 2000, description: "Одна строка описания чего-то", image: "pizza3")
    ]
    
    let drinks: [Product] = [
        Product(id: 1, name: "Beer", price: 800, description: nil, image: nil),
        Product(id: 2, name: "Vine", price: 1200, description: nil, image: nil),
        Product(id: 3, name: "Vodka", price: 1000, description: nil, image: nil)
    ]
    
    var categories: [ProductCategories] = []
    
    var sections = [CategorySection]()
    
    let restaurant: Restaurant
    
    // MARK: UI Elements declaration
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: Internal methods of View Controller
    override func viewDidLoad() {
        setupData()
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
    
    private func setupData() {
        categories = [
            ProductCategories(id: 0, name: "Пицца", products: pizzas),
            ProductCategories(id: 1, name: "Напитки", products: drinks)
        ]
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let headerView = MenuHeaderView(frame: CGRect(x: 0, y: 0, width: Constants.screenWidth, height: 270))
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = MenuFooter(frame: CGRect(x: 0, y: 0, width: Constants.screenWidth, height: 90))
        tableView.register(MenuItemCell.self, forCellReuseIdentifier: MenuItemCell.reuseId)
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
        120
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
        navigationItem.title = restaurant.restaurant?.restaurantData?.name
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
