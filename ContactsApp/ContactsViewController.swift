//
//  ViewController.swift
//  ContactsApp
//
//  Created by Анастасия on 01.01.2023.
//

import UIKit
import CoreData

class ContactsViewController: UIViewController {
    
    var contactBook = ContactBook()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
        do {
            contactBook.contacts = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactBook.delegate = self
        configureView()
    }
    
    func configureView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(addButton)
        setConstrains()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    func setConstrains() {
        addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        tableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 16).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    @objc func addButtonPressed() {
        let addContactVC = AddContactViewController()
        addContactVC.contactBook = contactBook
        present(addContactVC, animated: true)
    }

}

extension ContactsViewController: UITableViewDelegate {}

extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactBook.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell {
            if let name = contactBook.contacts[indexPath.row].name {
                cell.setupCell(withName: name)
            }
            return cell
        }
        fatalError("Could not dequeue reusable cell")
    }
    
}

extension ContactsViewController: ContactBookDelegate {
    
    func didUpdateContacts() {
        tableView.reloadData()
    }
}
