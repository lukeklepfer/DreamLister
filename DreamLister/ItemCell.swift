//
//  ItemCell.swift
//  DreamLister
//
//  Created by Luke Klepfer on 10/3/16.
//  Copyright © 2016 Luke. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    
    func configureCell(item: Item) {
        
        titleLbl.text = item.title
        priceLbl.text = "$\(item.price)"
        detailLbl.text = item.details
        thumb.image = item.toImage?.image as? UIImage
        
    }
    
    
}
