//
//  DetailViewController.swift
//  ContactsApp
//
//  Created by Анастасия on 03.01.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private var contactBook: ContactBook
    private var indexPath: IndexPath
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Edit", for: .normal)
        button.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = contactBook.contacts[indexPath.row].name
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = contactBook.contacts[indexPath.row].number
        label.textColor = .systemGray2
        return label
    }()
    
    init(contactBook: ContactBook, indexPath: IndexPath) {
        self.contactBook = contactBook
        self.indexPath = indexPath
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutView()
    }
    
    @objc private func editButtonPressed() {
        let addContactVC = AddContactViewController(indexPath: indexPath, contactBook: contactBook)
        addContactVC.delegate = self
        present(addContactVC, animated: true)
    }
    
    private func layoutView() {
        view.backgroundColor = .white
        view.addSubview(editButton)
        view.addSubview(nameLabel)
        view.addSubview(numberLabel)
        
        setupConstrains()
    }
    
    private func setupConstrains() {
        editButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        editButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 16).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        numberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16).isActive = true
        numberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        numberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }

}

extension DetailViewController: AddContactViewControllerDelegate {
    
    func didUpdateContact() {
        reloadData()
    }
    
    func reloadData() {
        nameLabel.text = contactBook.contacts[indexPath.row].name
        numberLabel.text = contactBook.contacts[indexPath.row].number
    }
}
