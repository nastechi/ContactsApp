//
//  AddContactViewController.swift
//  ContactsApp
//
//  Created by Анастасия on 03.01.2023.
//

import UIKit

final class AddContactViewController: UIViewController {
    
    var contactBook = ContactBook()
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutView()
    }
    
    @objc private func saveButtonPressed() {
        if let name = nameField.text, let number = numberField.text {
            if !name.isEmpty, !number.isEmpty {
                contactBook.addContact(name: name, number: number)
                self.dismiss(animated: true)
                return
            }
        }
        errorMessage.text = "Please fill all the fields."
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
        saveButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
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
