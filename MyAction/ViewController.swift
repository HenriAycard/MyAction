//
//  ViewController.swift
//  MyAction
//
//  Created by Henri Aycard on 31/03/2017.
//  Copyright © 2017 Henri Aycard. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        PrixAction.delegate = self
        PorteFeuille.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard)))
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func dismissKeyboard(){
        PrixAction.resignFirstResponder()
        PorteFeuille.resignFirstResponder()
        
    }
    func textFieldShouldReturn(PrixAction: UITextField) -> Bool {
        PrixAction.resignFirstResponder()
        return true
    }
    
    @IBOutlet weak var PorteFeuille: UITextField!

    @IBOutlet weak var PrixAction: UITextField!
    @IBOutlet weak var Affichage1: UILabel!
    
    @IBOutlet weak var Affichage2: UILabel!
    @IBOutlet weak var Affichage3: UILabel!
    @IBOutlet weak var Affichage4: UILabel!
    
    
    
    @IBAction func Lancement(_ sender: AnyObject){
 
        //reduction de 10% sur le porte feuille
        var n = Double(1)
        //let test = verif(n: n)
        //print(test)
        //var verifN : Bool = false
        
        while ((verif(n: n)) == false){
            n = n+1
        }
        
    }
    
    func Calculargent(PorteFeuille: Double, reduc: Double) -> Double{
        return PorteFeuille*reduc
    }
    
    func NombreAction(argent: Double, prixAction: Double) -> Double{
        return argent/prixAction
    }
    
    func CalculPrixHT(nbaction: Double, prixAction: Double) -> Double{
            return nbaction*prixAction
    }
    
    func CalculPrixFinal(prixHT: Double) -> Double{
        let prixFin: Double = (prixHT*1.0068)*1.02
        if ((prixFin-prixHT) < 7.5){
                return ((prixHT+7.5)*1.02)
            }else{
                return prixFin
            }
    }
    
    func SimulationPrix(n: Double) -> Double{
       
        let reduc = Double(1-(n/100))
        //on calcule l argent en enlevant un pourcentage car il faudra prendre un compte la taxe à la fin
        let argent = Double(Calculargent(PorteFeuille: Double(PorteFeuille.text!)!, reduc: reduc))
        
        //ON calcule le nombre d action
        var nbaction = Double(NombreAction(argent: argent, prixAction: Double(PrixAction.text!)!))
        nbaction.round()
        Affichage1.text = "Vous pouvez acheter \(nbaction) actions"

        //on calcule le prix HT
        let prixHT: Double =  CalculPrixHT(nbaction: nbaction, prixAction: Double(PrixAction.text!)!)
        Affichage2.text = "Prix HT= \(prixHT) €"

        //on calcule le prix TTC
        //let prixTTC: Double = CalculPrixFinal(prixHT: prixHT)
        //let prixfinal = Double(CalculPrixFinal(prixHT: prixHT))
        var prixfinal = Double(prixHT*1.0068*1.02)
        if ((prixfinal-prixHT)<7.5){
            prixfinal = (prixHT+7.5)*1.02
        }
        Affichage3.text = "Prix TTC= \(prixfinal) €"

        //on calcule le prix de l action apres achat, il faut prendre en compte la taxe
        let prixActionFinal = prixfinal/nbaction
        Affichage4.text = "Votre action est évalue à \(prixActionFinal) €"
        
        return prixfinal
    }
    
    func verif(n: Double) -> Bool{
        
        ///reduction
      
        let prixTTC = Double(SimulationPrix(n: n))
        if (prixTTC > Double(PorteFeuille.text!)!){
            return false
        }
        else {
            return true
        }
        
        
    }
    @IBAction func relancer(_ sender: AnyObject) {
        PrixAction.text = ""
        PorteFeuille.text = ""
        Affichage1.text = ""
        Affichage2.text = ""
        Affichage3.text = ""
        Affichage4.text = ""
    }
   
}
