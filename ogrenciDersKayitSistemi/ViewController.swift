//
//  ViewController.swift
//  ogrenciDersKayitSistemi
//
//  Created by Eyüphan Akkaya on 14.03.2023.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var ogrNoTextField: UITextField!
    
    @IBOutlet weak var parolaTextField: UITextField!
    
    var gidenDers = ""
    var gidenOgrAd = ""
    var gidenOgrNo = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(artiTiklandi))
        
        // Do any additional setup after loading the view.
    }
    
    @objc func artiTiklandi(){
        performSegue(withIdentifier: "toYeniOgrVC", sender: nil)
        
    }

    @IBAction func girisYapTiklandi(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName : "OgrenciBilgi")
        
        do {
            let sonuclar = try context.fetch(fetchRequest)
            if sonuclar.count > 0 {
                for sonuc in sonuclar as! [NSManagedObject] {
                    if let adSoyad = sonuc.value(forKey: "isimSoyisim") as? String {
                        gidenOgrAd = adSoyad
                        if let numara = sonuc.value(forKey: "okulNo") as? String {
                            gidenOgrNo = numara
                            if let parola = sonuc.value(forKey: "sifre") as? String {
                                if numara == ogrNoTextField.text && parola == parolaTextField.text {
                                    performSegue(withIdentifier: "toOgrBilgiVC", sender: nil)
                                }
                                }
                            if let ders = sonuc.value(forKey:"ders") as? String {
                                gidenDers = ders
                            }
                            
                            }
                    }

                    }
                }
            else {
                let uyariMesaji = UIAlertController(title: "Hatalı Giriş", message: "Lütfen Geçerli Numara ve Şifre Giriniz", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (UIAlertAction) in
                    print("Ok Butonuna Tıklandı")
                }
                uyariMesaji.addAction(okButton)
                self.present(uyariMesaji, animated: true,completion: nil)
            
               
            }
            }catch {
                print("Hata")
            }
        
        
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toOgrBilgiVC" {
            let destinationVC = segue.destination as? OgrDetayViewController
            destinationVC?.gelenOgrAd = gidenOgrAd
            destinationVC?.gelenOgrNo = gidenOgrNo
        }
    }

    
}
