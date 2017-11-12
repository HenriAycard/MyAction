//
//  prixVente.swift
//  MyAction
//
//  Created by Henri Aycard on 14/10/2017.
//  Copyright © 2017 Henri Aycard. All rights reserved.
//

import Foundation
import UIKit


class prixVente: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prixAction.delegate = self
        nbAction.delegate = self
        taxe.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(prixVente.dismissKeyboard)))    }
    @objc func dismissKeyboard(){
        prixAction.resignFirstResponder()
        nbAction.resignFirstResponder()
        taxe.resignFirstResponder()
    }
    
    @IBOutlet weak var prixAction: UITextField!
    @IBOutlet weak var nbAction: UITextField!
    @IBOutlet weak var taxe: UITextField!
    
    @IBOutlet weak var labelAffich: UILabel!
    
    @IBAction func calculer(_ sender: Any) {
        if((prixAction.text?.isEmpty)! || (nbAction.text?.isEmpty)!){
            labelAffich.text = "Error"
        }else{
            if(taxe.text?.isEmpty)!{
                labelAffich.text = "\(((prixAction.text!).DoublePrixA * (nbAction.text!).DoublePrixA) * (1.0068 * 1.02))"
            }else{
            labelAffich.text = "\(((prixAction.text!).DoublePrixA * (nbAction.text!).DoublePrixA) * (1+((taxe.text!).DoublePrixA/100) * 1.02))"
            }
        }
    }
    
    @IBOutlet weak var prixActionHT: UITextField!
  
    @IBOutlet weak var labelBenef: UILabel!
    
    @IBAction func calculerBenef(_ sender: Any) {
        if((prixAction.text?.isEmpty)! || (nbAction.text?.isEmpty)! || (prixActionHT.text?.isEmpty)!){
            labelAffich.text = "Error"
        }else{

            if(taxe.text?.isEmpty)!{
                labelAffich.text = "\(((prixAction.text!).DoublePrixA * (nbAction.text!).DoublePrixA) * (1.0068 * 1.02))"
                let cost = Double(labelAffich.text!)!

                 labelBenef.text = "\(cost - ((prixActionHT.text!).DoublePrixA * (nbAction.text!).DoublePrixA * (1.0068 * 1.02)))"
            }else{
                let taxeAct = (1+((taxe.text!).DoublePrixA/100)) * 1.02
                labelAffich.text = "\(((prixAction.text!).DoublePrixA * (nbAction.text!).DoublePrixA) * taxeAct)"
                let cost = Double(labelAffich.text!)!

                 labelBenef.text = "\(cost - ((prixActionHT.text!).DoublePrixA * (nbAction.text!).DoublePrixA * taxeAct))"
            }
           
        }
    }
    
    @IBAction func effacer(_ sender: Any) {
        prixAction.text = ""
        prixActionHT.text = ""
        nbAction.text = ""
        taxe.text = ""
        labelBenef.text = ""
        labelAffich.text = ""
    }
    
}
