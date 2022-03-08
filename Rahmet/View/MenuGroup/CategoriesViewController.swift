//
//  CategoriesViewController.swift
//  Rahmet
//
//  Created by Arman on 08.03.2022.
//

import UIKit

class CategoriesViewController: UIViewController {
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 27, weight: .medium)
        return label
    }()
    
    let categories: [ProductCategories]
    
    var scrollCompletion: ((Int) -> Void)?
    
    init(categories: [ProductCategories]) {
        self.categories = categories
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        setupConstraints()
    }
    
    func showCategory(index: Int) {
        scrollCompletion?(index)
    }
}


extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.reuseId, for: indexPath) as! CategoryTableViewCell
        cell.category = categories[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.popViewController(animated: true)
        showCategory(index: indexPath.row)
    }
}


extension CategoriesViewController: LayoutForNavigationVC {
    func setupConstraints() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
    
    func setupNavigationBar() {
        navigationItem.titleView = titleLabel
        titleLabel.text = "Меню"
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.reuseId)
    }
}

