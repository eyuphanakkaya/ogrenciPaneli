//
//  YeniOgrViewController.swift
//  ogrenciDersKayitSistemi
//
//  Created by Eyüphan Akkaya on 14.03.2023.
//

import UIKit
import CoreData

class YeniOgrViewController: UIViewController {

    
    @IBOutlet weak var adsoyadTextField: UITextField!
    
    @IBOutlet weak var numaraTextField: UITextField!
    
    
    @IBOutlet weak var sifreTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(artiTikla))

        // Do any additional setup after loading the view.
    }
    @objc func artiTikla() {
        performSegue(withIdentifier: "toDersEkleVC", sender: nil)
    }
    

    
    @IBAction func kaydetTiklandi(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let yeniOgrenci = NSEntityDescription.insertNewObject(forEntityName: "OgrenciBilgi", into: context)
        yeniOgrenci.setValue(adsoyadTextField.text, forKey: "isimSoyisim")
        yeniOgrenci.setValue(numaraTextField.text, forKey: "okulNo")
        yeniOgrenci.setValue(sifreTextField.text, forKey: "sifre")
        yeniOgrenci.setValue(UUID(), forKey: "id")
        
        self.navigationController?.popViewController(animated: true)
        
        do{
            try context.save()
            print("Öğrenci Eklendi")
        } catch {
            print("Hata!!")
        }
        
    }
    
}
