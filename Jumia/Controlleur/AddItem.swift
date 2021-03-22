//
//  AddItem.swift
//  Jumia
//
//  Created by EL BAKKALI Soufiane on 6/11/20.
//  Copyright © 2020 boubeh. All rights reserved.
//

import UIKit
import CoreData

class AddItem: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
   
    

    @IBOutlet weak var Itemname: UITextField!
    @IBOutlet weak var pvStoreType: UIPickerView!
    @IBOutlet weak var ItemImage: UIImageView!
    var EditOrDeleteItem:Items?
    var ListStoreType=[StoreType]()
    var imagePicker:UIImagePickerController!
    override func viewDidLoad() {
        super.viewDidLoad()
        pvStoreType.dataSource=self
        pvStoreType.delegate=self
        imagePicker=UIImagePickerController()
        imagePicker.delegate=self
        LoadStores()

        if EditOrDeleteItem != nil {
            LoadForEdit()
        }
    }
    
    func LoadStores(){
        let fetchRequest:NSFetchRequest<StoreType>=StoreType.fetchRequest()
        do{
            ListStoreType=try context.fetch(fetchRequest)
        }catch{
            
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
              return 1
          }
          
          func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return ListStoreType.count
          }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store=ListStoreType[row]
        return store.name
    }
    @IBAction func SelectImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated : true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        ItemImage.image = (info[UIImagePickerController.InfoKey.originalImage] as! UIImage)
        dismiss(animated: true, completion: nil)
    }
   

    @IBAction func ItemSave(_ sender: Any) {
        let newItem:Items!
        if EditOrDeleteItem == nil {
            newItem=Items(context: context)
        }else {
            newItem=EditOrDeleteItem
        }
        newItem.itemname=Itemname.text
        newItem.date_add=NSDate() as Date
        newItem.image=ItemImage.image
        newItem.toStore=ListStoreType[pvStoreType.selectedRow(inComponent: 0)]
        do{
            ad.saveContext()
            Itemname.text=""
            print("saved")
        }catch {
            print("Error")
        }
    }
    
    @IBAction func ItemBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func LoadForEdit(){
        if let item = EditOrDeleteItem {
            Itemname.text=item.itemname
            ItemImage.image=item.image as? UIImage
            if let store=item.toStore{
                var index = 0
                while index<ListStoreType.count {
                    let row=ListStoreType[index]
                    if row.name==store.name{
                        pvStoreType.selectRow(index,inComponent: 0,animated:false)
                    }
                    index=index+1
                }
                
            }
        }
    }
    
    
    @IBAction func ItemDelete(_ sender: UIBarButtonItem) {
        if EditOrDeleteItem != nil{
            context.delete(EditOrDeleteItem! )
            ad.saveContext()
          _ =  navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        }
    }
    
}
