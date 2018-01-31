//
//  DABaseViewC.swift
//  DemoApp
//
//  Created by Minakshi Bawa on 29/01/18.
//  Copyright © 2018 OrganisationName. All rights reserved.
//

import UIKit

class DABaseViewC: UIViewController {

    //MARK: - View LifeCycle Methods - 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- ----------UIAlertController Methods----------
    func showOkAlert(withMessage message: String)
    {
        let alert = UIAlertController(title: kAppName, message: message, preferredStyle: .alert)
        let okAction =  (UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showOkAlert(withMessage message: String, andHandler handler:@escaping () -> Void)
    {
        let alert = UIAlertController(title: kAppName, message: message, preferredStyle: .alert)
        let okAction =  UIAlertAction(title: "Ok", style: .default)
        { (action) -> Void in
            return handler()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

extension UITableViewCell
{
    static func identifier() -> String
    {
        return String(describing: self)
    }
}
