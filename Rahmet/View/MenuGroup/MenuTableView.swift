//
//  MenuTableView.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 14.02.2022.
//

import UIKit

class MenuTableView: UITableViewController {
    
    let fakeCategoriesData = FakeCategories.shared.fakeCategoriesData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        tableView.register(MenuCell.self, forCellReuseIdentifier: "menuCell")
        navigationItem.title = "Меню"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fakeCategoriesData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuCell
        cell.category = fakeCategoriesData[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
