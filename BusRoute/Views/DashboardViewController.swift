//
//  DashboardViewController.swift
//  BusRoute
//
//  Created by Mayank Mathur on 24/02/21.
//  Copyright © 2021 Mayank Mathur. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Bus Routes"
    }
    
    @IBAction func onTapShowBusRoutesButton(_ sender: UIButton) {        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let busRouteVC = storyboard.instantiateViewController(withIdentifier: "BusRouteViewController") as! BusRouteViewController
        self.present(busRouteVC, animated: true, completion: nil)
    }
}
