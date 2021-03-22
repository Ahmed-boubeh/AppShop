//
//  TableViewCell.swift
//  Jumia
//
//  Created by EL BAKKALI Soufiane on 6/11/20.
//  Copyright © 2020 boubeh. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var laStoreName: UILabel!
   
    @IBOutlet weak var laDateAdded: UILabel!
    @IBOutlet weak var laImage: UIImageView!
    
    @IBOutlet weak var laItemName: UILabel!
    
    func setMyCell(item:Items){
        laItemName.text = item.itemname
        laImage.image = item.image as? UIImage
        laStoreName.text = item.toStore?.name
        let dateformat=DateFormatter()
        dateformat.dateFormat="MM-dd-YYYY h:mm a"
        laDateAdded.text=dateformat.string(from: item.date_add as! Date)
    }
}
