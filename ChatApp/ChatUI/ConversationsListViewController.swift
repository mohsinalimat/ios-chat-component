//
//  ConversationsListViewController.swift
//  ChatUI
//
//  Created by Jan Schwarz on 05/01/2020.
//  Copyright © 2020 Jan Schwarz. All rights reserved.
//

import UIKit
import ChatCore

public class ConversationsListViewController<Core: ChatUICoreServicing>: UIViewController {
    let core: Core
    
    private let dataSource = DataSource()
    private var delegate: Delegate?
    
    private var tableView: UITableView!
    private var listener: ChatListener?
    
    init(core: Core) {
        self.core = core

        super.init(nibName: nil, bundle: nil)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        if let listener = listener {
            core.remove(listener: listener)
        }
    }
    
    private func setup() {
        view.backgroundColor = .white
        
        delegate = Delegate(didSelectBlock: { [weak self] row in
            guard let self = self else {
                return
            }
            
            let conversation = self.dataSource.conversations[row]
            let controller = MessagesListViewController(conversation: conversation, core: self.core)
            self.navigationController?.pushViewController(controller, animated: true)
        })
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.reuseIdentifier)
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        view.addSubview(tableView)
        
        view.addConstraints([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])

        listener = core.listenToConversations { [weak self] result in
            switch result {
            case .success(let conversations):
                self?.dataSource.conversations = conversations
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createTestConversation))
    }
    
    @objc func createTestConversation() {
        core.createTestConversation()
    }
}

extension ConversationsListViewController {
    class DataSource: NSObject, UITableViewDataSource {
        var conversations: [Conversation] = []

        func conversationTitle(_ conversation: Conversation) -> String {
            let title = conversation.members.compactMap{ $0.name }.joined(separator: ",")
            return title == "" ? "Conversation Title" : title
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return conversations.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.reuseIdentifier, for: indexPath)
            
            let conversation = conversations[indexPath.row]
            
            cell.textLabel?.text = conversationTitle(conversation)
            cell.detailTextLabel?.text = "message"
            
            return cell
        }
    }
    
    class Delegate: NSObject, UITableViewDelegate {
        typealias Block = (Int) -> Void
        let didSelectBlock: Block
        
        init(didSelectBlock: @escaping Block) {
            self.didSelectBlock = didSelectBlock
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            didSelectBlock(indexPath.row)
        }
    }
}
