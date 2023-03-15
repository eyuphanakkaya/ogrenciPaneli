//
//  DersEkleViewController.swift
//  ogrenciDersKayitSistemi
//
//  Created by Eyüphan Akkaya on 14.03.2023.
//

import UIKit
import CoreData

class OgrDetayViewController: UIViewController {

    
    @IBOutlet weak var adSoyadLabel: UILabel!
    @IBOutlet weak var okulNoLabel: UILabel!
    @IBOutlet weak var dersAdiTextField: UITextField!
    
    var gelenOgrAd = ""
    var gelenOgrNo = ""
    var gidenId : UUID?
    var gelenDers = String()
    var gelenId :UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        adSoyadLabel.text = "Ad Soyad:\(gelenOgrAd)"
        okulNoLabel.text = "Okul Numarası:\(gelenOgrNo)"
        
        if  let uuidString = gelenId?.uuidString {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let context = appDelegate?.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "OgrenciBilgi")
            
            fetchRequest.predicate = NSPredicate(format: "id = %@", uuidString)
            /*"id = %@" id si uuidstringe eşit olanları getir*/
            /*mantıksal bazı filtreler koymamızı sağlar */
            do{
                let sonuclar = try context?.fetch(fetchRequest)
                if sonuclar!.count > 0 {
                    for sonuc in sonuclar as! [NSManagedObject] {
                        if let ders = sonuc.value(forKey: "ders") as? String{
                            
                        }
                       
                    }
                }

            }catch {
                print("Hatalı!!")
            }
            
            
            
            
        }
        
        
    }
    

    @IBAction func kaydetTiklandi(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let dersEkle = NSEntityDescription.insertNewObject(forEntityName: "OgrenciBilgi", into:context)
        
        dersEkle.setValue(dersAdiTextField.text, forKey: "ders")
        
        do {
            try context.save()
            print("Ders Eklendi")
        }catch {
            print("Hata!!")
        }
        
        performSegue(withIdentifier: "toDersDetayVC", sender: nil)
        
        //veriGonder()
    }
    
    
    @IBAction func listeleTiklandi(_ sender: Any) {
        performSegue(withIdentifier: "toDersDetayVC", sender: nil)
        
    }
    

    
    func verileriSil(){
       
    }
    
    
   /* func veriGonder() {
        if okulNoLabel.text == gelenOgrNo {
            
            if let uuidString = gidenId?.uuidString {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "OgrenciBilgi")
                fetchRequest.predicate = NSPredicate(format: "id = %#", uuidString)
                
                do {
                    let sonuclar =  try context.fetch(fetchRequest)
                    for sonuc in sonuclar as! [NSManagedObject] {
                        let id = sonuc.value(forKey: "id") as? UUID
                        gidenId = id
                    }
                } catch {
                    print("Hata!!")
                }
            }
            
        }

       
        
    } */
    
    
}
