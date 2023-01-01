//
//  ContactBook.swift
//  ContactsApp
//
//  Created by Анастасия on 01.01.2023.
//

import Foundation

struct Contact {
    var name: String
    var number: String
}

class ContactBook {
    var contacts = [Contact(name: "Hillary", number: "123456789123"), Contact(name: "Robert", number: "123456789123"), Contact(name: "Jane", number: "123456789123")]
}
