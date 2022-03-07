//
//  MainMenu.swift
//  Rahmet
//
//  Created by Arman on 09.02.2022.
//

import UIKit
import SnapKit
import Alamofire

class MainMenu: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        fetchData()
        setupNavigationBar()
        setupViews()
        setupConstraints()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    var restaurants: [Restaurant] = []
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = true
        return tableView
    }()
}


extension MainMenu: LayoutForNavigationVC {
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Заказ с собой"
    }
    
    func setupViews() {
        view.addSubview(tableView)
        tableView.register(CafeCell.self, forCellReuseIdentifier: "cafeCell")
    }
    
    func fetchData() {
        AF.request("https://intern.rahmetapp.kz/api/restaurants")
          .validate()
          .responseDecodable(of: [Restaurant].self) { (response) in
            guard let rests = response.value else { return }
              self.restaurants = rests
              self.tableView.reloadData()
          }
      }
}

extension MainMenu: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cafeCell", for: indexPath) as! CafeCell
        print(indexPath.section)
        cell.cafe = restaurants[indexPath.row].restaurant
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 120
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var cafe = restaurants[indexPath.row]
        guard let restaurant = cafe.restaurant else { return }
        navigationController?.pushViewController(MenuViewController(id: cafe.restaurant?.restaurantData?.id ?? 0), animated: true)
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(indexPath.section)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(indexPath.section)
    }
}





import SwiftUI

struct MainMenuProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let menuVC = MainTabBarController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return menuVC
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
