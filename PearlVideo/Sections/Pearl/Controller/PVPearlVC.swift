//
//  PVPearlVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/2.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

class PVPearlVC: PVBaseNavigationVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        YPJOtherTool.ypj.loginValidate(currentVC: self) { (isFinish) in
            if isFinish {
                
            }
        }
    }
   

}
