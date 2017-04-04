//
//  TabVIewController.swift

//
//  Created by Sandeep Penchala on 3/11/17.
//  Copyright © 2017 Sandeep Penchala. All rights reserved.
//

import Foundation
import UIKit
import SafariServices
class TabBarController: UITabBarController {
    
    @IBAction func purchase(_ sender: Any) {
        let svc = SFSafariViewController(url: NSURL(string: Constants.homePage) as! URL, entersReaderIfAvailable: true)
        self.present(svc, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
