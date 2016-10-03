//
//  MainVC.swift
//  DreamLister
//
//  Created by Luke Klepfer on 10/3/16.
//  Copyright © 2016 Luke. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    var fetchedResultsController: NSFetchedResultsController<Item>! //displays fetched core data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        //genTestData()
        attemptFetch()
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        configCell(cell: cell, indexPath: indexPath as NSIndexPath)
        
        return cell
    }
    
    func configCell(cell: ItemCell, indexPath: NSIndexPath){
        
        let newItem = fetchedResultsController.object(at: indexPath as IndexPath)
        cell.configureCell(item: newItem)
        
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        
        if let sections = fetchedResultsController.sections {
            
            return sections.count
        }
        
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if let sections = fetchedResultsController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func attemptFetch() {
        let fetchReq: NSFetchRequest<Item> = Item.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        fetchReq.sortDescriptors = [dateSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchReq, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        
        self.fetchedResultsController = controller
        do{
            try controller.performFetch()
            
        }catch{
            let error = error as NSError
            print("\(error)")
        }
        
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.beginUpdates()
        
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.endUpdates()
        
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch(type) {
            
        case.insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade) //when we create a new item, add it to the current index path and fade it in
            }
            break
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! ItemCell
                configCell(cell: cell, indexPath: indexPath as NSIndexPath) //local config cell
            }
            break
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
    }
    
    
    func genTestData(){
        
        let item = Item(context: context)
        item.title = "Macbook Pro"
        item.price = 1200
        item.details = "Can't Wait"
        
        let item1 = Item(context: context)
        item1.title = "Macbook Pro"
        item1.price = 1400
        item1.details = "Can't Wait"
        
        let item2 = Item(context: context)
        item2.title = "Macbook Pro"
        item2.price = 1500
        item2.details = "Can't Wait"
        
        let item3 = Item(context: context)
        item3.title = "Macbook Pro"
        item3.price = 1600
        item3.details = "Can't Wait"
        
        ad.saveContext()
    }
    

    
    
    
    
    
    
    
}

