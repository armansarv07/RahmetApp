//
//  MyOrderDetailed.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 15.02.2022.
//

import UIKit
import Alamofire
import JGProgressHUD

class OrderDetailed: UIViewController {
    let spinner = JGProgressHUD(style: .dark)

    var order: OrdersData
    var products: [ProductCategories] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMenu()
        setupNavigationBar()
        setupViews()
        setupConstraints()
    }
    
    init(order: OrdersData) {
        self.order = order
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let cafeNameView: ParametersView = {
        var view = ParametersView()
        view.mainLabel.textColor = .black
        view.mainLabel.font = .boldSystemFont(ofSize: 16)
        view.subLabel.textColor = .gray
        return view
    }()
    
    let statusView: ParametersView = {
        var view = ParametersView()
        view.mainLabel.text = "Статус заказа"
        return view
    }()
    
    let dateView: ParametersView = {
        var view = ParametersView()
        view.mainLabel.text = "Дата"
        return view
    }()
    
    let orderNumView: ParametersView = {
        var view = ParametersView()
        view.mainLabel.text = "Номер заказа"
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
        return (order.orderDetail?.count ?? 1) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderPositionsCell.reuseId, for: indexPath) as! OrderPositionsCell
        if let items = order.orderDetail {
            cell.item = items[indexPath.row]
        }
        if indexPath.row == order.orderDetail?.count {
            cell.leftLabel.text = "Итого"
            cell.leftLabel.font = .boldSystemFont(ofSize: 14)
            cell.rightLabel.text = "\(order.total ?? 0) тг"
            cell.rightLabel.font = .boldSystemFont(ofSize: 14)
            return cell
        } else {
            cell.rightLabel.text = "\(self.findProduct(id: order.orderDetail?[indexPath.row].id ?? 0).name ?? "")"
            cell.leftLabel.text = "\(self.findProduct(id: order.orderDetail?[indexPath.row].id ?? 0).price ?? 0)"
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
    
    func setupData() {
        cafeNameView.subLabel.text = order.restaurant?.name
        var statusTitle: String = ""
        switch order.orderStatus {
        case 0: statusTitle = "В обработке"; statusView.subLabel.textColor = #colorLiteral(red: 0, green: 0.6025887132, blue: 1, alpha: 1)
        case 1: statusTitle = "На кухне" ; statusView.subLabel.textColor = #colorLiteral(red: 0.9535714984, green: 0.4975312352, blue: 0.1409159303, alpha: 1)
        case 2: statusTitle = "Готов" ; statusView.subLabel.textColor = #colorLiteral(red: 0.2856111825, green: 0.6951665282, blue: 0.3649486899, alpha: 1)
        case 4: statusTitle = "Завершен" ; statusView.subLabel.textColor = .gray
        default: break
        }
        
        statusView.subLabel.text = statusTitle
        dateView.subLabel.text = order.createdAt
        orderNumView.subLabel.text = "№\(String(describing: order.id))"
        
    }
    
    func fetchMenu() {
        spinner.show(in: view)
        guard let url = URL(string: Constants.baseURL + "/menu/\(String(describing: order.restaurantID))") else { return }
        AF.request(url).validate().responseDecodable(of: Menu.self) {
            guard let menu = $0.value else { return }
            self.spinner.dismiss(animated: true)
            self.products = menu.data?.productCategories ?? []
        }
    }
    
    func findProduct(id: Int) -> Product {
        let product = Product(id: 0, name: "", price: 0, description: "", image: "")
        for sect in products {
            for prod in sect.products! {
                if id == prod.id {
                    return prod
                }
            }
        }
        return product
    }
    
    func countTotalSum() -> Double {
        var sum = 0.0
        if let items = order.orderDetail {
//            for i in items {
//                sum += i.price ?? 0
//            }
        }
        return sum
    }
}
