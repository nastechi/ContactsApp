//
//  AddContactViewController.swift
//  ContactsApp
//
//  Created by Анастасия on 03.01.2023.
//

import UIKit

protocol AddContactViewControllerDelegate {
    func didUpdateContact()
}

final class AddContactViewController: UIViewController {
    
    var contactBook = ContactBook()
    private var indexPath: IndexPath?
    var delegate: AddContactViewControllerDelegate?
    
    private var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private var nameField: UITextField = {
        let nameField = UITextField()
        nameField.placeholder = "Name"
        nameField.tintColor = .lightGray
        nameField.translatesAutoresizingMaskIntoConstraints = false
        return nameField
    }()
    
    private var numberField: UITextField = {
        let numberField = UITextField()
        numberField.placeholder = "Phone number"
        numberField.tintColor = .lightGray
        numberField.translatesAutoresizingMaskIntoConstraints = false
        return numberField
    }()
    
    private var errorMessage: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    init(indexPath: IndexPath, contactBook: ContactBook) {
        self.contactBook = contactBook
        let contact = contactBook.contacts[indexPath.row]
        nameField.text = contact.name
        numberField.text = contact.number
        saveButton.setTitle("Save changes", for: .normal)
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
    
    @objc private func saveButtonPressed() {
        if saveButton.currentTitle == "Save changes" {
            if let name = nameField.text, let number = numberField.text {
                guard !name.isEmpty, !number.isEmpty, indexPath != nil else { return }
                contactBook.updateContact(contact: contactBook.contacts[indexPath!.row], name: name, number: number)
                delegate?.didUpdateContact()
                self.dismiss(animated: true)
                return
            }
        } else {
            if let name = nameField.text, let number = numberField.text {
                if !name.isEmpty, !number.isEmpty {
                    contactBook.addContact(name: name, number: number)
                    self.dismiss(animated: true)
                    return
                }
            }
            errorMessage.text = "Please fill all the fields."
        }
    }
    
    private func layoutView() {
        view.backgroundColor = .white
        view.addSubview(saveButton)
        view.addSubview(nameField)
        view.addSubview(numberField)
        view.addSubview(errorMessage)
        setupConstrains()
    }
    
    private func setupConstrains() {
        saveButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
        
        nameField.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 16).isActive = true
        nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        nameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        numberField.topAnchor.constraint(equalTo: nameField.bottomAnchor).isActive = true
        numberField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        numberField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        errorMessage.topAnchor.constraint(equalTo: numberField.bottomAnchor, constant: 16).isActive = true
        errorMessage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        errorMessage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        }

}
