//
//  MyOrderDetailed.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 15.02.2022.
//

import UIKit
import SwiftUI

class OrderDetailed: UIViewController {

    var order: TemporaryOrder
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
        setupConstraints()
    }
    
    init(order: TemporaryOrder) {
        self.order = order
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let cafeNameView: ParametersView = {
        var view = ParametersView()
        view.mainLabel.text = "ChocoCafe"
        view.mainLabel.textColor = .black
        view.mainLabel.font = .boldSystemFont(ofSize: 16)
        view.subLabel.text = "1.2 км • Коктем 3-й микрорайон"
        view.subLabel.textColor = .gray
        return view
    }()
    
    let statusView: ParametersView = {
        var view = ParametersView()
        view.mainLabel.text = "Статус заказа"
        view.subLabel.text = "Завершен"
        return view
    }()
    
    let dateView: ParametersView = {
        var view = ParametersView()
        view.mainLabel.text = "Дата"
        view.subLabel.text = "22.04.2021, 12:43"
        return view
    }()
    
    let orderNumView: ParametersView = {
        var view = ParametersView()
        view.mainLabel.text = "Номер заказа"
        view.subLabel.text = "№3161389"
        return view
    }()
    
    let stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    let positionsLabel: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .gray
        label.text = "Позиции в заказе"
        return label
    }()
    
    let tableView = UITableView()
}

extension OrderDetailed: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (order.orderItems?.count ?? 1) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderPositionsCell.reuseId, for: indexPath) as! OrderPositionsCell
        if indexPath.row == order.orderItems?.count{
            cell.leftLabel.text = "Итого"
            cell.leftLabel.font = .boldSystemFont(ofSize: 14)
            cell.rightLabel.text = "\(countTotalSum()) тг"
            cell.rightLabel.font = .boldSystemFont(ofSize: 14)
            return cell
        }
        if let items = order.orderItems {
            cell.item = items[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension OrderDetailed: LayoutForNavigationVC {
    
    func setupNavigationBar() {
        navigationItem.title = "Детали заказа"
    }
    
    func setupViews() {
        tableView.register(OrderPositionsCell.self, forCellReuseIdentifier: OrderPositionsCell.reuseId)
        tableView.dataSource = self
        tableView.delegate = self
        [statusView, dateView, orderNumView].forEach {
            stackView.addArrangedSubview($0)
        }
        [cafeNameView, stackView, positionsLabel, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    func setupConstraints() {
        cafeNameView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.screenHeight / 4)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(cafeNameView.snp.bottom).offset(40)
        }
        
        positionsLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(40)
            make.right.equalToSuperview()
            make.left.equalTo(15)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(positionsLabel.snp.bottom).offset(7)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func countTotalSum() -> Double {
        var sum = 0.0
        if let items = order.orderItems {
            for i in items {
                sum += i.itemPrice ?? 0
            }
        }
        return sum
    }
}
