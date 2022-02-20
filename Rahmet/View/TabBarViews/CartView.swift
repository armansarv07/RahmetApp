//
//  CartView.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 18.02.2022.
//

import UIKit

class CartView: UIViewController {

    let tableView = UITableView()
    var myFakeOrders: [OrderItem] = [
        OrderItem(itemName: "Пицца Маргарита", numberOfItems: 1, itemPrice: 1900, imgName: "cafeImage"),
        OrderItem(itemName: "Пицца Пепперони", numberOfItems: 1, itemPrice: 1600, imgName: "cafeImage"),
        OrderItem(itemName: "Пицца Маргарита 1", numberOfItems: 2, itemPrice: 1000, imgName: "cafeImage")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
        setupConstraints()
    }
    
    let cafeNameView: ParametersView = {
        var view = ParametersView()
        view.mainLabel.text = "Mamma mia"
        view.mainLabel.textColor = .black
        view.mainLabel.font = .boldSystemFont(ofSize: 16)
        view.subLabel.text = "ул. Панфилова 109"
        view.subLabel.textColor = .gray
        return view
    }()
    
    let orderLabel: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "Мой заказ"
        return label
    }()
}

extension CartView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFakeOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.reuseId, for: indexPath) as! CartCell
        cell.item = myFakeOrders[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CartView: LayoutForNavigationVC {
    
    func setupViews() {
        tableView.register(CartCell.self, forCellReuseIdentifier: CartCell.reuseId)
        tableView.dataSource = self
        tableView.delegate = self
        [cafeNameView, orderLabel, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    func setupConstraints() {
        
        cafeNameView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.screenHeight / 4)
        }
        
        orderLabel.snp.makeConstraints { make in
            make.top.equalTo(cafeNameView.snp.bottom).offset(40)
            make.right.equalToSuperview()
            make.left.equalTo(15)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(orderLabel.snp.bottom).offset(15)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Корзина"
    }
    
    
}
