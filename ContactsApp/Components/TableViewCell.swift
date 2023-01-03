//
//  TableViewCell.swift
//  ContactsApp
//
//  Created by Анастасия on 01.01.2023.
//

import UIKit

final class TableViewCell: UITableViewCell {
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(nameLabel)
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(withName name: String) {
        nameLabel.text = name
    }
    
    private func setConstrains() {
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16).isActive = true
    }
}
