//
//  CartView.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 18.02.2022.
//

import UIKit
import SwiftUI

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
    
    let paymentButton = BlueButton(text: "Оплатить", rightText: "4533 тг", leftText: "", isActive: true)
}

extension CartView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFakeOrders.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLastRow(row: indexPath.row) {
            let cell = tableView.dequeueReusableCell(withIdentifier: OrderPositionsCell.reuseId, for: indexPath) as! OrderPositionsCell
            cell.leftLabel.text = "Итого"
            cell.leftLabel.font = .boldSystemFont(ofSize: 14)
            cell.rightLabel.text = "\(countTotalSum()) тг"
            cell.rightLabel.font = .boldSystemFont(ofSize: 14)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.reuseId, for: indexPath) as! CartCell
        cell.item = myFakeOrders[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isLastRow(row: indexPath.row) {
            return 50
        }
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CartView: LayoutForNavigationVC {
    
    func setupViews() {
        self.tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .white
        tableView.register(CartCell.self, forCellReuseIdentifier: CartCell.reuseId)
        tableView.register(OrderPositionsCell.self, forCellReuseIdentifier: OrderPositionsCell.reuseId)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.delaysContentTouches = false
        [cafeNameView, orderLabel, tableView, paymentButton].forEach {
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
            make.bottom.equalToSuperview().offset(120)
        }
        
        paymentButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
    }
    
    func setupNavigationBar() {
        self.title = "Корзина"
    }
    
    func countTotalSum() -> Double {
        var sum = 0.0
        for i in myFakeOrders {
            sum += i.itemPrice ?? 0
        }
        return sum
    }
    
    func isLastRow(row: Int) -> Bool {
        return row == myFakeOrders.count
    }
}
