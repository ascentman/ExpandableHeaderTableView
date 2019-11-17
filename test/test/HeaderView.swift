//
//  HeaderView.swift
//  test
//
//  Created by Volodymyr Rykhva on 11/15/19.
//  Copyright © 2019 Volodymyr Rykhva. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate: class {
   func toggleSection(header: HeaderView, section: Int)
}

class HeaderView: UITableViewHeaderFooterView {

    weak var delegate: HeaderViewDelegate?
    var section: Int = 0

    static let reuseIdentifier: String = String(describing: self)

    override func awakeFromNib() {
        super.awakeFromNib()

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapHeader)))
    }

    @IBOutlet weak var myTextLabel: UILabel!

    @objc private func tapHeader(gestureRecognizer: UITapGestureRecognizer) {
       delegate?.toggleSection(header: self, section: section)
    }

    func setCollapsed(_ collapsed: Bool) {
        print("animate arrow")
    }
}
