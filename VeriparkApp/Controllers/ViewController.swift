//
//  ViewController.swift
//  VeriparkApp
//
//  Created by Samet Bugra Oktay on 5.08.2021.
//

import UIKit

class ViewController: UIViewController {
   
    private var stocks: StocksResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AuthManager.shared.handshake(completion: {result in
            if result {
                print("OK")
            }else {
                print("Failed to handshake")
            }
        })

        
    }
    

    @IBAction func buttonClicked(_ sender: Any) {
        performSegue(withIdentifier: "stocksList", sender: self)
        
    }
    

}




