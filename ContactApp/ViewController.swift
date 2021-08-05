//
//  ViewController.swift
//  ContactApp
//
//  Created by Ilshat Khairakhun on 03.08.2021.
//

import UIKit
import CallKit

class ViewController: UIViewController {
    
    private var contactsTableView: ContactsTableView!
    
    override func loadView() {
        contactsTableView = ContactsTableView(frame: .zero, style: .plain)
        self.view = contactsTableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureProvider()
    }
    
    func configureProvider() {
        let provider = CXProvider(configuration: CXProviderConfiguration())
        provider.setDelegate(self, queue: nil)

    }

}

//MARK: CXProviderDelegate

extension ViewController: CXProviderDelegate {
    
    func providerDidReset(_ provider: CXProvider) {
        }
    
    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
            action.fulfill()
        }
    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
            action.fulfill()
        }
    
    
}

