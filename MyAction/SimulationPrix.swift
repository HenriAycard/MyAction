//
//  SimulationPrix.swift
//  MyAction
//
//  Created by Henri Aycard on 24/06/2017.
//  Copyright © 2017 Henri Aycard. All rights reserved.
//

import Foundation

class SimulationPrix{
    
    var PorteFeuille: Double
    var PrixAction: Double
    var Taxe:Double
    var PrixFinal: Double
    var Reduc: Double
    var Argent: Double
    var NbAction: Double
    var PrixHT: Double
    var PrixRevient: Double
    
    init(PorteF: Double, PrixA: Double, Tax: Double){
        
        //PorteFeuille = PorteF.DoublePorteF
        //PrixAction = PrixA.DoublePrixA
        PorteFeuille = PorteF
        PrixAction = PrixA
        Taxe = Tax
        PrixFinal = 0
        Reduc = 0
        Argent = 0
        NbAction = 0
        PrixHT = 0
        PrixRevient = 0
        }
    
    func start(n: Double){
    
        if (verifValeur() == true) && (verifValeur2() == true){
            print("Aucune erreur \(PorteFeuille) \(PrixAction)")
            Reduc = 1-(n/100)
            //on calcule l argent en enlevant un pourcentage car il faudra prendre un compte la taxe à la fin
            Argent = Calculargent()
            
            //ON calcule le nombre d action
            NbAction = NombreAction()
            NbAction.round()
            
            //on calcule le prix HT
            PrixHT =  CalculPrixHT()

            //on calcule le prix TTC
            //let prixTTC: Double = CalculPrixFinal(prixHT: prixHT)
            //let prixfinal = Double(CalculPrixFinal(prixHT: prixHT))
            PrixFinal = PrixHT*Taxe
            if ((PrixFinal-PrixHT)<7.5){
                PrixFinal = (PrixHT+7.5)*1.02
            }
            
            //on calcule le prix de l action apres achat, il faut prendre en compte la taxe
            PrixRevient = PrixFinal/NbAction
        }else{
            print("erreur")
        }
    }
    
    func setValeur(val: String, val2: String){
        PorteFeuille = val.DoublePorteF
        PrixAction = val2.DoublePrixA
    }
    
    
    
    
    func verifValeur()-> Bool{
        if PorteFeuille<PrixAction{
            return false
        }else{
            return true
        }
    }
    
    func verifValeur2()-> Bool{
        if PorteFeuille<(PrixAction+7.5){
            return false
        }else{
            return true
        }
    }
    
    func Calculargent() -> Double{
        return PorteFeuille*Reduc
    }
    
    func NombreAction() -> Double{
        return Argent/PrixAction
    }
    
    func CalculPrixHT() -> Double{
        return NbAction*PrixAction
    }
}



