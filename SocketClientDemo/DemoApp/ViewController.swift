//
//  ViewController.swift
//  Created by hdjc8.com on 2020/10/20
//

import UIKit
import Foundation
import Darwin.C

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .roundedRect)
        button.frame = CGRect(x: 0, y: 0, width: 414, height: 44)
        
        button.center = self.view.center
        button.titleLabel?.font = .systemFont(ofSize: 28)
        
        button.tintColor = UIColor.white
        button.setTitle("Client connect server", for: .normal)
        
        button.addTarget(self, action: #selector(clientConnect(_:)), for: .touchUpInside)
        
        self.view.backgroundColor = UIColor.orange
        self.view.addSubview(button)
    }
    
    @objc func clientConnect(_ button:UIButton)
    {
        let client:TCPClient = TCPClient(addr: "127.0.0.1", port: 8080)
        let (success, errmsg) = client.connect(timeout: 5)
        if success
        {
            let (success, errmsg) = client.send(str:"AA BB CC DD" )
            if success
            {
                let data = client.read(1024*10)
                if let d = data
                {
                    let xmlStr:String = String(bytes: d, encoding: String.Encoding.utf8)!
                    let alert = UIAlertController(title: "Load data", message: xmlStr, preferredStyle: .alert)
                    
                    let yes = UIAlertAction(title: "Yes", style: .default, handler: nil)
                    
                    alert.addAction(yes)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else
            {
                let alert = UIAlertController(title: "Error", message: errmsg, preferredStyle: .alert)
                
                let yes = UIAlertAction(title: "Yes", style: .default, handler: nil)
                
                alert.addAction(yes)
                self.present(alert, animated: true, completion: nil)
                print(errmsg)
            }
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: errmsg, preferredStyle: .alert)
            
            let yes = UIAlertAction(title: "Yes", style: .default, handler: nil)
            
            alert.addAction(yes)
            self.present(alert, animated: true, completion: nil)
            print(errmsg)
        }
    }


}

