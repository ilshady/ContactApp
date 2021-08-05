//
//  ContactsTableView.swift
//  ContactApp
//
//  Created by Ilshat Khairakhun on 03.08.2021.
//

import UIKit
import Contacts
import CallKit

class ContactsTableView: UITableView {
    
    let cellID = "CellID"
    
    var contactsArray = [ContactModel]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        delegate = self
        dataSource = self
        fetchContats()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: Functions
extension ContactsTableView {
    func fetchContats() {
        
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { granted, error in
            if let err = error {
                print("failed to request access", err)
            }
            if granted {
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey ]
                
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                
                do {
                    try store.enumerateContacts(with: request, usingBlock: { contact, stopPointer in
                        let contact = ContactModel(firstname: contact.givenName.description, lastname: contact.familyName.description, phoneNumber: contact.phoneNumbers.first?.value.stringValue ?? "")
                        self.contactsArray.append(contact)
                        
                    })
                } catch let error {
                    print("Failed to enumerate contact", error)
                }
            }
        }
        
    }
}

//MARK: ContactsTableViewDelegate
extension ContactsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = CXCallController()
        let transaction = CXTransaction(action: CXStartCallAction(call: UUID(), handle: CXHandle(type: .generic, value: "You are calling me!!!")))
        controller.request(transaction, completion: { error in })
            
    }
}

//MARK: ContactsTableViewDataSource
extension ContactsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: cellID)!
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        cell.textLabel?.text =  contactsArray[indexPath.row].firstname + " " + contactsArray[indexPath.row].lastname + " / " + contactsArray[indexPath.row].phoneNumber
        return cell
    }

}
