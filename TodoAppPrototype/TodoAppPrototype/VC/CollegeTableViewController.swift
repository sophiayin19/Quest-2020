//
//  CollegeTableViewController.swift
//  TodoAppPrototype
//
//  Created by Sophia Yin on 2/20/20.
//  Copyright © 2020 Sophia Yin. All rights reserved.
//

import UIKit
import CoreData

class CollegeTableViewController: UITableViewController {
    //MARK: - Properties
    var resultsController: NSFetchedResultsController<College>!
    let coreDataStack = CoreDataStack()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Request
        let request:NSFetchRequest<College> = College.fetchRequest()
        _ = NSSortDescriptor(key: "date", ascending:true)

        //Init
        request.sortDescriptors = []

        resultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: coreDataStack.managedContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        resultsController.delegate = self
        // Fetch
        do{
            try resultsController.performFetch()
        } catch {
            print("Perform fetch error:\(error)")
        }
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return resultsController.sections?[section].objects?.count ?? 0
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolCell", for: indexPath)

        // Configure the cell...
        let college = resultsController.object(at: indexPath)
        cell.textLabel?.text = college.collegeName
        
        return cell
    }
    // MARK: -Table view delegate

    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style:.destructive, title: "Delete") { (action, view, completion) in
            //TODO: delete college
            let deletedcollege = self.resultsController.object(at: indexPath)
            self.resultsController.managedObjectContext.delete(deletedcollege)
            do {
                try self.resultsController.managedObjectContext.save()
                completion(true)
                       } catch{
                print("delete failed\(error)")
                completion(false)
                       }
        }

        action.image = #imageLiteral(resourceName: "trash")
        action.backgroundColor = .red
  
        
        return UISwipeActionsConfiguration(actions: [action])
    }


    // MARK: - Navigation

 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let _ = sender as? UIBarButtonItem, let vc = segue.destination as? AddCollegeViewController{
            vc.managedContext = resultsController.managedObjectContext
        }
        
    }


}

    extension CollegeTableViewController: NSFetchedResultsControllerDelegate{
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath{
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }
}
