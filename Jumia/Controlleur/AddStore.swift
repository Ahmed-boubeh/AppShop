//
//  AddStore.swift
//  Jumia
//
//  Created by EL BAKKALI Soufiane on 6/11/20.
//  Copyright © 2020 boubeh. All rights reserved.
//

import UIKit

class AddStore: UIViewController {

    @IBOutlet weak var Storename: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SaveStore(_ sender: Any) {
        let store=StoreType(context: context)
        store.name=Storename.text
        do{
            ad.saveContext()
            Storename.text=""
            print("Saved")
        }catch{
            print("cannot saved")
        }
    }
    @IBAction func StoreBack(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
