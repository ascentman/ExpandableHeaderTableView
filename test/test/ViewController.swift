//
//  ViewController.swift
//  test
//
//  Created by Volodymyr Rykhva on 11/15/19.
//  Copyright © 2019 Volodymyr Rykhva. All rights reserved.
//

struct Category {
    let name: String
    let id: Int
    let subCategories: [SubCategory]
    var collapsed: Bool

    init(name: String, id: Int, subCategories: [SubCategory], collapsed: Bool = true) {
        self.name = name
        self.id = id
        self.subCategories = subCategories
        self.collapsed = collapsed
    }
}

struct SubCategory {
    let name: String
    let id: Int
}

import UIKit

final class ViewController: UITableViewController {

    var dataSource: [Category] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let sub1 = SubCategory(name: "apple", id: 1)
        let sub2 = SubCategory(name: "pineapple", id: 2)
        let sub3 = SubCategory(name: "plum", id: 3)
        let subs1 = [sub1, sub2, sub3]
        let category1 = Category(name: "fruits", id: 1, subCategories: subs1)

        let sub4 = SubCategory(name: "bread", id: 4)
        let sub5 = SubCategory(name: "milk", id: 5)
        let sub6 = SubCategory(name: "meat", id: 6)
        let sub7 = SubCategory(name: "fish", id: 7)
        let subs2 = [sub4, sub5, sub6, sub7]
        let category2 = Category(name: "products", id: 1, subCategories: subs2)

        let sub8 = SubCategory(name: "icecream", id: 4)
        let sub9 = SubCategory(name: "sweets", id: 5)
        let sub10 = SubCategory(name: "candies", id: 6)
        let sub11 = SubCategory(name: "cake", id: 7)
        let sub12 = SubCategory(name: "lollypop", id: 7)
        let subs3 = [sub8, sub9, sub10, sub11, sub12]
        let category3 = Category(name: "desserts", id: 1, subCategories: subs3)

        let sub13 = SubCategory(name: "icecream", id: 4)
        let sub14 = SubCategory(name: "sweets", id: 5)
        let sub15 = SubCategory(name: "candies", id: 6)
        let sub16 = SubCategory(name: "cake", id: 7)
        let sub17 = SubCategory(name: "lollypop", id: 7)
        let subs4 = [sub13, sub14, sub15, sub16, sub17]
        let category4 = Category(name: "desserts", id: 1, subCategories: subs4)

        dataSource = [category1, category2, category3, category4]

        let view = UIView()
        tableView.tableFooterView = view
        title = "Test"

        tableView.sectionHeaderHeight = 44
        let nib = UINib(nibName: "HeaderView", bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: HeaderView.reuseIdentifier)
    }

    // MARK: - UITableViewDelegate & UITableViewDataSource

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.reuseIdentifier) as! HeaderView
        header.myTextLabel.text = dataSource[section].name
        header.section = section
        header.setCollapsed(dataSource[section].collapsed)
        header.delegate = self
        return header
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource[section].subCategories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = dataSource[indexPath.section].subCategories[indexPath.row].name
        cell?.detailTextLabel?.text = String(dataSource[indexPath.section].subCategories[indexPath.row].id)
        return cell ?? UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataSource[indexPath.section].collapsed ? 0 : UITableView.automaticDimension
    }
}

extension ViewController: HeaderViewDelegate {
    func toggleSection(header: HeaderView, section: Int) {
        let collapsed = !dataSource[section].collapsed
        dataSource[section].collapsed = collapsed
        header.setCollapsed(collapsed)

        for (idx, _) in dataSource.enumerated() where idx != section {
            dataSource[idx].collapsed = true
        }

        UIView.transition(with: tableView,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: { self.tableView.reloadData() })

        tableView.reloadData()
    }
}
