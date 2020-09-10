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
        
        testserver()
    }

    func echoService(client c:TCPClient)
    {
        print("newclient from:\(c.addr)[\(c.port)]")
        let data = c.read(1024*10)
        
        if let d = data
        {
            let result:String = String(bytes: d, encoding: String.Encoding.utf8)!
            print(result)
        }
        
        let responseData = "Hello".data(using: .utf8)
        let _ = c.send(data: responseData!)
        let _ = c.close()
    }
    
    func testserver()
    {
        let server:TCPServer = TCPServer(addr: "127.0.0.1", port: 8080)
        let (success, msg) = server.listen()
        if success
        {
            while true
            {
                if let client = server.accept()
                {
                    echoService(client: client)
                }
                else
                {
                    print("accept error")
                }
            }
        }
        else
        {
            print(msg)
        }
    }


}

