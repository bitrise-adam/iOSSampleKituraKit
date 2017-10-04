//
//  ViewController.swift
//  iOS Sample Kitura Buddy
//
//  Created by Shihab Mehboob on 03/10/2017.
//  Copyright © 2017 IBM. All rights reserved.
//

import UIKit
import TypeSafeKituraClient

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView()
    var employees: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "Kitura Buddy"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        self.tableView = UITableView(frame:CGRect(x:0, y:(self.navigationController?.navigationBar.bounds.height)!, width: self.view.bounds.width, height: (self.navigationController?.view.bounds.height)!))
        self.tableView.backgroundColor = UIColor.white
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func addTapped(button: UIButton) {
        let textEntry = UIAlertController(title: "Text", message: "Please input some text to send:", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Confirm", style: .default) { (_) in
            if let field = textEntry.textFields?[0] {
                
                // send to Kitura
                if let textToSend = field.text {
                    
                    self.create(text: textToSend)
                    
                    self.employees.append(textToSend)
                    self.tableView.reloadData()
                } else {
                    
                }
                
            } else {
                
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        textEntry.addTextField { (textField) in
            textField.placeholder = "Text..."
        }
        
        textEntry.addAction(confirm)
        textEntry.addAction(cancel)
        
        self.present(textEntry, animated: true, completion: nil)
    }
    
    // Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(employees[indexPath.row])"
        return cell
    }
    
    // Kitura
    
    func create(text: String) {
        let Emp1 = Employee(id: "1234", name: text)
        let Emp2 = try Employee.create(model: Emp1)
        
        // read into table after creating new item:
        self.read(i: nil)
    }
    
    func read(i: String?) {
        let Emp1 = try Employee.read(id: i?)
        employees.append(Emp1)
        
        self.tableView.reloadData()
        
        // or to read all:
        // let Emp1 = try Employee.read()
        // employees = Emp1
    }
    
    func update(i: String, text: String) {
        let Emp1 = Employee(id: "1234", name: text)
        let Emp2 = try Employee.update(id: i, model: Emp1)
        
        // read into table after updating item:
        self.read(i: nil)
    }
    
    func delete(i: String?) {
        try Employee.delete(id: i?)
        
        self.tableView.reloadData()
        
        // or to delete all:
        // try Employee.delete()
    }

}