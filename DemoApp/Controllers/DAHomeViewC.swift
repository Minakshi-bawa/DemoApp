//
//  DAHomeViewC.swift
//  DemoApp
//
//  Created by Minakshi Bawa on 29/01/18.
//  Copyright © 2018 OrganisationName. All rights reserved.
//

import UIKit

class DAHomeViewC: DABaseViewC
{
    @IBOutlet weak var btnStartTest: UIButton!
    
    //MARK: - View LifeCycle Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        btnStartTest.layer.cornerRadius = 10
        btnStartTest.layer.masksToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
