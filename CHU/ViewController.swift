//
//  ViewController.swift
//  CHU
//
//  Created by xuezhaofeng on 2019/1/1.
//  Copyright © 2019 xuezhaofeng. All rights reserved.
//

import UIKit

let phoneNumber = ""
let stoken = ""

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchInfo()
    }

    private func fetchInfo() {
        let infoRequest = URLRequest(url: URL(string: "https://alipay.10010.com/mobileWeChatApplet/operationservice/queryOcsPackageFlowLeftContent.htm?mobile=\(phoneNumber)&stoken=\(stoken)")!)
        print("infoURL: \(infoRequest)")
        URLSession.shared.dataTask(with: infoRequest) { (data, response, error) in
            print("response")
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            print(json)
        }.resume()
    }
}

