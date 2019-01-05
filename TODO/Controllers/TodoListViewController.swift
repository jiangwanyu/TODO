//
//  ViewController.swift
//  TODO
//
//  Created by 超级电脑 on 2018/12/30.
//  Copyright © 2018年 超级电脑. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    //var itemArray = ["购买水杯","买手机","修改密码","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p"]
    var itemArray = [Item]()
    //let defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    //print(dataFilePath)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
        //let newItem = Item()
        //newItem.title = "购买水杯"
        //itemArray.append(newItem)
        
        //let newItem2 = Item()
        //newItem2.title = "买手机"
        //itemArray.append(newItem2)
        
        //let newItem3 = Item()
        //newItem3.title = "修改密码"
        //itemArray.append(newItem3)
        
       // for index in 4...120{
         //   let newItem = Item()
           // newItem.title = "第\(index)事物"
            //itemArray.append(newItem)
        //}
        
        //if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            //itemArray = items
        //}
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        if itemArray[indexPath.row].done == false{
           cell.accessoryType = .none
        }else
        {
           cell.accessoryType = .checkmark
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        //if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            //tableView.cellForRow(at: indexPath)?.accessoryType = .none
        //}else
        //{
            //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        //}
        if itemArray[indexPath.row].done == false {
            itemArray[indexPath.row].done = true
        }else
        {
            itemArray[indexPath.row].done = false
        }
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
        tableView.endUpdates()
        
        self.saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
   
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "添加一个ToDo项目", message: "", preferredStyle: .alert)
        let action = UIAlertAction (title: " 添加项目 ", style: .default) {
            (action) in
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
            
            
            print("成功！")
        }
        
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "创建一个新项目..."
            //print(alertTextField.text!)
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        }catch{
            print("编码错误：\(error)")
        }
        
       
        self.tableView.reloadData()
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print ("解码错误")
            }
        }
    }
}

