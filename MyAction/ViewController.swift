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
    @objc func dismissKeyboard(){
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
 

        var n = Double(1)
        let tax = Double(0)
        let SimulPrix = SimulationPrix(PorteF: Double(PorteFeuille.text!)!, PrixA: Double(PrixAction.text!)!, Tax: tax)
       
        if ((PorteFeuille.text?.isEmpty) != false || (PrixAction.text?.isEmpty) != false) {
            PrixAction.text = ""
            PorteFeuille.text = ""
            Affichage1.text = "Aucune Valeur Saisi"
            Affichage2.text = "Aucune Valeur Saisi"
            Affichage3.text = "Aucune Valeur Saisi"
            Affichage4.text = "Aucune Valeur Saisi"
        }
        else {
            repeat{
                SimulPrix.start(n: n)
                Affichage1.text = "Vous pouvez acheter \(SimulPrix.NbAction) actions"
                Affichage2.text = "Prix HT= \(SimulPrix.PrixHT) €"
                Affichage3.text = "Prix TTC= \(SimulPrix.PrixFinal) €"
                Affichage4.text = "Votre action est évalue à \(SimulPrix.PrixRevient) €"
                n = n+1
            } while ((TestReduction(n: n,SimulPrix: SimulPrix)) == false)
        }
    }
    
    func TestReduction(n: Double, SimulPrix: SimulationPrix) -> Bool{
        ///reduction
        let PrixFinal = SimulPrix.PrixFinal
        if (PrixFinal > Double(PorteFeuille.text!)!){
            return false
        }else {
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
