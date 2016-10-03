//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by Luke Klepfer on 10/3/16.
//  Copyright © 2016 Luke. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    @IBOutlet weak var image: UIImageView!
    
    
    var stores = [Store]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        storePicker.delegate = self
        storePicker.dataSource = self
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        //testStores()
        getStores()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let store = stores[row]
        return store.name
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return stores.count
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
    }
    
    func testStores(){
        
        let store = Store(context: context)
        store.name = "Best Buy"
        let store2 = Store(context: context)
        store2.name = "Amazon"
        let store3 = Store(context: context)
        store3.name = "Fry's"
        let store4 = Store(context: context)
        store4.name = "Walmart"
        let store5 = Store(context: context)
        store5.name = "Target"
        let store6 = Store(context: context)
        store6.name = "K-Mart"
        
        ad.saveContext()
    }
    
    @IBAction func savePressed(_ sender: AnyObject) {
        let newItem = Item(context: context)
        
        if let title = titleField.text{
            newItem.title = title
        }
        if let price = priceField.text{
            newItem.price = (price as NSString).doubleValue
        }
        if let details = detailsField.text{
            newItem.details = details
        }
        
        newItem.toStore = stores[storePicker.selectedRow(inComponent: 0)] //only have one collumn
        ad.saveContext()
        _ = navigationController?.popViewController(animated: true)//return to first view
    }
    
    @IBAction func imageTapped(_ sender: AnyObject) {
    
    
    }
    
    func getStores(){
        let fetchReq: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            self.stores = try context.fetch(fetchReq)
            self.storePicker.reloadAllComponents()
        }catch{
            //handle error
        }
    }

}
