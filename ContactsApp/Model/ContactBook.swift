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

final class ContactBook {
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
    
    func updateContact(contact: Contact, name: String, number: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let contextContact = context.object(with: contact.objectID) as! Contact
        contextContact.name = name
        contextContact.number = number
        
        do {
            try context.save()
            guard contacts.firstIndex(of: contact) != nil else { return }
            contacts[contacts.firstIndex(of: contact)!] = contextContact
            delegate?.didUpdateContacts()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteContact(contact: Contact) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let contextContact = context.object(with: contact.objectID) as! Contact
        context.delete(contextContact)
        
        do {
            try context.save()
            guard contacts.firstIndex(of: contact) != nil else { return }
            contacts.remove(at: contacts.firstIndex(of: contact)!)
            delegate?.didUpdateContacts()
        } catch {
            print(error.localizedDescription)
        }
    }
}
