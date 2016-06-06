//
//  ViewController.swift
//  VoucherifySwiftSdk
//
//  Created by marcin.polak on 06/02/2016.
//  Copyright (c) 2016 marcin.polak. All rights reserved.
//

import UIKit
import VoucherifySwiftSdk

class ViewController: UIViewController {

    var client: VoucherifyClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        client = VoucherifyClient(clientId: "011240bf-d5fc-4ef1-9e82-11eb68c43bf5", clientToken: "9e2230c5-71fb-460a-91c6-fbee64707a20")
            
        client?.validateVoucher("test") { (response) in
            debugPrint(response)
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}