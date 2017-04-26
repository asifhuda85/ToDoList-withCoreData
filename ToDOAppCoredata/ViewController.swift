//
//  ViewController.swift
//  ToDOAppCoredata
//
//  Created by Md Asif Huda on 3/1/17.
//  Copyright © 2017 Md Asif Huda. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var myTableView: UITableView!

    var toDoItems: [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func addToDoList(_ sender: UIBarButtonItem) {
        let add = UIAlertController(title: "Add task", message: "add new task", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            let textField = add.textFields?[0]
            
            self.saveTask(newTask: (textField?.text)!)
            self.myTableView.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        add.addTextField { textField in }
        add.addAction(ok)
        add.addAction(cancel)
        
        present(add, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func saveTask(newTask: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let taskEntity = NSEntityDescription.entity(forEntityName: "Task", in: context)
        guard taskEntity != nil else {
            return
        }
        let taskObject = NSManagedObject(entity: taskEntity!, insertInto: context) as! Task
        
        taskObject.text = newTask
        do {
            try context.save()
            toDoItems.append(taskObject)
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let tasksRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            toDoItems = try context.fetch(tasksRequest)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath as IndexPath) as! ToDoTableViewCell

        let task = toDoItems[indexPath.row]
        cell.textLabel?.text = task.text
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
}


