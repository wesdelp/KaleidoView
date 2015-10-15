//
//  ViewController.swift
//  KaleidoView
//
//  Created by Wesley Delp on 10/13/15.
//  Copyright © 2015 wesdelp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        let topView = self.view as! kaleidoDrawView
        topView.startDrawing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

