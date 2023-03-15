//
//  DersDetayViewController.swift
//  ogrenciDersKayitSistemi
//
//  Created by Eyüphan Akkaya on 14.03.2023.
//

import UIKit
import CoreData

class DersDetayViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    
    var diziDers = [String]()
    var diziId = [UUID]()
    var secilenDers = ""
    var secilenId :  UUID?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        tableView.delegate = self
        tableView.dataSource = self
        verial()
        
        
        
    }
    func verial(){
        
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName : "OgrenciBilgi")
            
            do{
                let sonuclar =  try context.fetch(fetchRequest)
                if sonuclar.count > 0 {
                    for sonuc in sonuclar as! [NSManagedObject] {
                        if let id = sonuc.value(forKey: "id") as? UUID {
                            diziId.append(id)
                        }
                        if  let ders = sonuc.value(forKey: "ders") as? String {
                            diziDers.append(ders)
                        }
                        
                    }
                }
            } catch {
                print("Hata!!")
            }
        

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        secilenDers = diziDers[indexPath.row]
        secilenId = diziId[indexPath.row]
        performSegue(withIdentifier: "toDersDetayVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "OgrenciBilgi")
            let uuidString = diziId[indexPath.row].uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %#", uuidString)
            
            
            do{
                let sonuclar = try context.fetch(fetchRequest)
                for sonuc in sonuclar as! [NSManagedObject] {
                    if let id = sonuc.value(forKey: "id") as? UUID{
                        if id == diziId[indexPath.row] {
                            context.delete(sonuc)
                            diziDers.remove(at: indexPath.row)
                            diziId.remove(at: indexPath.row)
                            
                            self.tableView.reloadData()
                            
                            do{
                                try context.save()
                            } catch {
                                print("Hata")
                            }
                            break
                        }
                    }
                }
                
            } catch {
                print("Hata!!")
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diziDers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = diziDers[indexPath.row]
        return cell
    }
    

   

}
