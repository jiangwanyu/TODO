//
//  ViewController.swift
//  TODO
//
//  Created by 超级电脑 on 2018/12/30.
//  Copyright © 2018年 超级电脑. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    let itemArray = ["购买水杯","买手机","修改密码"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
   
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "添加一个ToDo项目", message: "", preferredStyle: .alert)
        let action = UIAlertAction (title: " 添加项目 ", style: .default) {
            (action) in
            
            print("成功！")
        }
        
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "创建一个新项目..."
            print(alertTextField.text!)
        }
        
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
    }
    
}

