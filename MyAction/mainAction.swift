//
//  mainAction.swift
//  MyAction
//
//  Created by Henri Aycard on 15/10/2017.
//  Copyright © 2017 Henri Aycard. All rights reserved.
//

import Foundation

import UIKit

class mainAction: UIViewController {
    @IBOutlet weak var achat: UIButton!
    @IBOutlet weak var vente: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        achat.applyDesign()
        vente.applyDesign()
    }
}
extension UIButton{
    func applyDesign(){
        self.backgroundColor = UIColor.darkGray
        self.layer.cornerRadius = self.frame.height / 2
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
}
}
