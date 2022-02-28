//
//  ViewController.swift
//  Contacts
//
//  Created by Karpinets Alexander on 27.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private var contacts = [ContactProtocol]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContacts()
    }
    
    private func loadContacts() {
        contacts.append(Contact(title: "Саня техосмотр", phone: "+78882130123"))
        contacts.append(Contact(title: "Вова кальян", phone: "+790124312"))
        contacts.append(Contact(title: "Петя груз", phone: "+72342352"))
        contacts.append(Contact(title: "Оля соня", phone: "+7232525899"))
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "MyCell") {
            print("Используем старую ячейку для строки с индексом \(indexPath.row)")
         cell = reuseCell
        } else {
            print("Создаем новую ячейку для строки с индексом \(indexPath.row)")
            cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
        }
            configure(cell: &cell, for: indexPath)
            return cell
    }

private func configure(cell: inout UITableViewCell, for indexPath: IndexPath) {
    var configuration = cell.defaultContentConfiguration()
    configuration.text = contacts[indexPath.row].title
    configuration.secondaryText = contacts[indexPath.row].phone
    cell.contentConfiguration = configuration
}
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDelete = UIContextualAction(style: .destructive, title: "Удалить") { _,_,_ in
            self.contacts.remove(at: indexPath.row)
            tableView.reloadData()
        }
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        return actions
    }
}
