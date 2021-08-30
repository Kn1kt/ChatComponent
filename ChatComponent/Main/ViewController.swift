//
//  ViewController.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 21.08.2021.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let mockService = MockMessagesService()
        let chatVC = MessagesViewController<MessagesViewModel>()
        chatVC.viewModel = .init(chatID: 0, user: mockService.makeCurrentUser(), messagesService: mockService)
        let nc = UINavigationController(rootViewController: chatVC)
        nc.modalPresentationStyle = .fullScreen
        present(nc, animated: false)
    }
    
}

