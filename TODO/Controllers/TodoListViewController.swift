//
//  ViewController.swift
//  TODO
//
//  Created by 超级电脑 on 2018/12/30.
//  Copyright © 2018年 超级电脑. All rights reserved.
//

import UIKit
import CoreData


class TodoListViewController: UITableViewController {
  
    var itemArray = [Item]()
   
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    //print(dataFilePath)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
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
        
        if itemArray[indexPath.row].done == false {
            itemArray[indexPath.row].done = true
        }else
        {
            itemArray[indexPath.row].done = false
        }
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        let title = itemArray[indexPath.row].title
        itemArray[indexPath.row].setValue(title! + " - (已完成)", forKey: "title")
        
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
            //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
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
        do{
           
            try context.save()
        }catch{
            print("编码错误：\(error)")
        }
        
       
        self.tableView.reloadData()
    }
    
    func loadItems(){
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        do{
            itemArray = try context.fetch(request)
        }catch{
            print("从context获取数据错误: \(error)")
        }
    }
}

