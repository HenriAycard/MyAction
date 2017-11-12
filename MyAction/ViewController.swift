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
    
    @IBOutlet weak var LaTaxe: UITextField!
    

    @IBAction func Lancement(_ sender: AnyObject){
        
        
        var n = Double(1)
        var tax = Double(1.0068*1.02)
        
        //let StringPorteF: String = PorteFeuille.text!
        //let StringPrixA: String = PrixAction.text!
        let DPorteF: Double = (PorteFeuille.text!).DoublePorteF
        let DPrixA: Double = (PrixAction.text!).DoublePrixA
        
        if ((PorteFeuille.text?.isEmpty) != false || (PrixAction.text?.isEmpty) != false) {
            PrixAction.text = ""
            PorteFeuille.text = ""
            Affichage1.text = "Aucune Valeur Saisi"
        }else if (DPorteF <= 0 || DPrixA <= 0){
            PrixAction.text = ""
            PorteFeuille.text = ""
            Affichage1.text = "Valeur Negative"
        }else{
            
            
            if(LaTaxe.text?.isEmpty)!{
                tax = ((1+((LaTaxe.text!.DoublePorteF)/100)) * 1.02)
            
            let SimulPrix = SimulationPrix(PorteF: DPorteF, PrixA: DPrixA, Tax: tax)
            
            repeat{
                SimulPrix.start(n: n)
                Affichage1.text = "Vous pouvez acheter \(SimulPrix.NbAction) actions \nPrix HT= \(SimulPrix.PrixHT) €\nPrix TTC= \(SimulPrix.PrixFinal) € \nVotre action est évalue à \(SimulPrix.PrixRevient) €"
                n = n + 1
            } while ((TestReduction(n: n,SimulPrix: SimulPrix, PorteF: DPorteF)) == false)
                
            }else{
                let SimulPrix = SimulationPrix(PorteF: DPorteF, PrixA: DPrixA, Tax: tax)
                
                repeat{
                    SimulPrix.start(n: n)
                    Affichage1.text = "Vous pouvez acheter \(SimulPrix.NbAction) actions \nPrix HT= \(SimulPrix.PrixHT) €\nPrix TTC= \(SimulPrix.PrixFinal) € \nVotre action est évalue à \(SimulPrix.PrixRevient) €"
                    n = n + 1
                } while ((TestReduction(n: n,SimulPrix: SimulPrix, PorteF: DPorteF)) == false)
                
            }
                
                
            
        }
    }
    
    func TestReduction(n: Double, SimulPrix: SimulationPrix, PorteF: Double) -> Bool{
        ///reduction
        let PrixFinal = SimulPrix.PrixFinal
        if (PrixFinal > PorteF){
            return false
        }else {
            return true
        }
    }
    
    /*
     @IBOutlet weak var PrixActionVente: UITextField!
     @IBOutlet weak var NbActionVente: UITextField!
     @IBOutlet weak var TaxeVente: UITextField!
     @IBOutlet weak var PrixActionAchat: UITextField!
     */
    
    @IBAction func relancer(_ sender: AnyObject) {
        PrixAction.text = ""
        PorteFeuille.text = ""
        Affichage1.text = ""

    }
   
}

extension String{
    var DoublePorteF: Double {
        let nf = NumberFormatter()
        nf.decimalSeparator = "."
        if let result = nf.number(from: self) {
            return result.doubleValue
        }else {
            nf.decimalSeparator = ","
            if let result = nf.number(from: self) {
                return result.doubleValue
            }
        }
        return 0
    }
    var DoublePrixA: Double {
        let nf = NumberFormatter()
        nf.decimalSeparator = "."
        if let result = nf.number(from: self) {
            return result.doubleValue
        } else {
            nf.decimalSeparator = ","
            if let result = nf.number(from: self) {
                return result.doubleValue
            }
        }
        return 0
    }
}
