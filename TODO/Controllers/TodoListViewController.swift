//
//  ViewController.swift
//  TODO
//
//  Created by 超级电脑 on 2018/12/30.
//  Copyright © 2018年 超级电脑. All rights reserved.
//

import UIKit
import RealmSwift


class TodoListViewController: UITableViewController {
    
   
    
    let realm = try! Realm()
    var todoItems: Results<Item>?
    var selectedCategory: Category? {
        didSet {
            print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
            loadItems()
        }
    }
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    //print(dataFilePath)
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        //loadItems()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
       
        if let item = todoItems?[indexPath.row]{
           cell.textLabel?.text = item.title
            cell.accessoryType = item.done == true ? .checkmark : .none
        }else
        {
           cell.textLabel?.text = "没有事项"
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = item.done
                }
            }catch{
                print("保存完成状态失败:\(error)")
            }
        }
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
        tableView.deselectRow(at: indexPath, animated: true)
    }
   
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "添加一个ToDo项目", message: "", preferredStyle: .alert)
        let action = UIAlertAction (title: " 添加项目 ", style: .default) {
            (action) in
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                }catch{
                    print("保存item发生错误：\(error)")
                }
                
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "创建一个新项目..."
            //print(alertTextField.text!)
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
    }
    
    
    
    
    
    func loadItems(){
      
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
    
    
}
extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        todoItems = todoItems?.filter("title CONTAINS[c] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: false)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()
            DispatchQueue.main.async{
            searchBar.resignFirstResponder()
            }
        }
    }
}

