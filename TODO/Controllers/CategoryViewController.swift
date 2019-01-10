//
//  CategoryTableViewController.swift
//  TODO
//
//  Created by 超级电脑 on 2019/1/6.
//  Copyright © 2019年 超级电脑. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class CategoryViewController: UITableViewController {
    
    var categories: Results<Category>?
    
    let realm = try! Realm()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadCategories()
     
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if segue.identifier == "goToItems" {
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCategory = categories?[indexPath.row]
            }
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "添加新的类别", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "添加", style: .default) {
            (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
            //self.categories.append(newCategory)
            self.save(category: newCategory)
        }
        
        alert.addAction(action)
        
        alert.addTextField{ (field) in
            textField = field
            
            textField.placeholder = "添加一个新的类别"
        }
        present(alert, animated: true, completion: nil)
    }
    func save(category: Category){
        do{
            try realm.write {
                realm.add(category)
            }
        }catch{
            print("保存Category错误：\(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories(){
        
        
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
}
