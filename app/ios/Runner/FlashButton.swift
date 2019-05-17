//
//  FlashButton.swift
//  TheConcertStaff
//
//  Created by Surapong Suwanlee on 11/5/2562 BE.
//  Copyright © 2562 AsUnDeR. All rights reserved.
//

import UIKit

class FlashButton: UIButton {
    
    var isOn = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }
    
    func initButton() {
        setImage(UIImage(named: "round_flash_off"), for: .normal)
        addTarget(self, action: #selector(FlashButton.buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        activateButton(bool: !isOn)
    }
    
    func activateButton(bool: Bool) {
        
        isOn = bool
        let btnImage = bool ? UIImage(named: "round_flash_on") : UIImage(named: "round_flash_off")
        setImage(btnImage, for: .normal)
        
    }
    
    
}

