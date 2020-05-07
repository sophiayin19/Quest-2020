//
//  TodoListViewController.swift
//  QuestPrototype1
//
//  Created by Sophia Yin on 5/6/20.
//  Copyright © 2020 Sophia Yin. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UIViewController {
    
    // MARK: -Properties
    
    var resultsController: NSFetchedResultsController<Todo>!
    let coreDataStackTodo = CoreDataStackTodo()
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tasks"
        tableView.delegate = self
        tableView.dataSource = self
        let request:NSFetchRequest<Todo> = Todo.fetchRequest()
        let dateSort = NSSortDescriptor(key: "date", ascending:true)
        request.sortDescriptors = [dateSort]
        
        resultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: coreDataStackTodo.managedContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        resultsController.delegate = self as? NSFetchedResultsControllerDelegate
        do{
            try resultsController.performFetch()
        } catch {
            print("Perform fetch error:\(error)")
                   }
            
        }
        // Do any additional setup after loading the view.
    
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


extension TodoListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TodoListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resultsController.sections?[section].objects?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Todo", for: indexPath)
        let todo = self.resultsController.object(at: indexPath)
        cell.textLabel?.text = todo.title
        return cell
        
    }
}

