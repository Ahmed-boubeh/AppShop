//
//  ViewController.swift
//  Jumia
//
//  Created by EL BAKKALI Soufiane on 6/11/20.
//  Copyright © 2020 boubeh. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate {
  

  
    @IBOutlet weak var tableview: UITableView!
    var controller:NSFetchedResultsController<Items>!
    
    override func viewDidLoad() {
        tableview.dataSource=self
        tableview.delegate=self
        LoadItems()
       }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections{
            let sectionInfo=sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableview.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        as! TableViewCell
        configureCell(cell: cell, indexPath: indexPath)
        return cell
      }
      
    func configureCell(cell:TableViewCell,indexPath:IndexPath)     {
        let Singleitem=controller.object(at: indexPath )
        cell.setMyCell(item:Singleitem)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="EditOrDelete"{
            if let distination=segue.destination as? AddItem {
                if let item=sender as? Items{
                    distination.EditOrDeleteItem=item
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let objc=controller.fetchedObjects{
            let item=objc[indexPath.row]
            performSegue(withIdentifier: "EditOrDelete", sender: item)
        }
    }
    func LoadItems(){
        let fetchRequest:NSFetchRequest<Items>=Items.fetchRequest()
        let date_addSort=NSSortDescriptor(key: "date_add", ascending: false)
        fetchRequest.sortDescriptors=[date_addSort]
        controller=NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate=self
        do{
            try controller.performFetch()
        }catch{
            print("error")
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableview.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableview.endUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch(type) {
            
        case.insert:
            if let indexPath = newIndexPath {
                tableview.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                tableview.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = indexPath {
                let cell = tableview.cellForRow(at: indexPath) as! TableViewCell
                configureCell(cell: cell, indexPath: indexPath )
            }
            break
        case.move:
            if let indexPath = indexPath {
                tableview.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableview.insertRows(at: [indexPath], with: .fade)
            }
            break
            
        }
    }
    
    @IBOutlet weak var searchItem: UISearchBar!
}

