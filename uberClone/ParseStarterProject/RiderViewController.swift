//
//  RiderViewController.swift
//  ParseStarterProject
//
//  Created by Tyler Swartz on 12/12/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class RiderViewController: UIViewController {

    override func viewDidLoad() {

        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "logoutRider" {

            PFUser.logOut()
            
        }
        
    }
    
}
