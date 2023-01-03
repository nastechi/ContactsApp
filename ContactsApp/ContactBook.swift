//
//  ContactBook.swift
//  ContactsApp
//
//  Created by Анастасия on 01.01.2023.
//

import CoreData
import UIKit

protocol ContactBookDelegate {
    func didUpdateContacts()
}

class ContactBook {
    var delegate: ContactBookDelegate?
    var contacts: [Contact] = []
    
    func addContact(name: String, number: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Contact", in: context) else {
            return
        }
        let contactObject = Contact(entity: entity, insertInto: context)
        
        contactObject.name = name
        contactObject.number = number
        
        do {
            try context.save()
            contacts.append(contactObject)
            delegate?.didUpdateContacts()
        } catch {
            print(error.localizedDescription)
        }
    }
}
