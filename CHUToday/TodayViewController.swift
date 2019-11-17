//
//  TodayViewController.swift
//  CHUToday
//
//  Created by xuezhaofeng on 2019/1/1.
//  Copyright © 2019 xuezhaofeng. All rights reserved.
//

import UIKit
import NotificationCenter
import PromiseKit

let phoneNumber = ""
let stoken = ""

class TodayViewController: UIViewController {
     
    @IBOutlet weak var updateTimeLabel: UILabel!
    @IBOutlet weak var remindCallChargeLabel: UILabel!
    @IBOutlet weak var remindCellularDataLabel: UILabel!
    @IBOutlet weak var remindCallTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension TodayViewController: NCWidgetProviding {
    func widgetPerformUpdate(completionHandler: @escaping (NCUpdateResult) -> Void) {
        self.updateTimeLabel.text = "数据加载中..."
        
        let feeRequest = URLRequest(url: URL(string: "https://mina.10010.com/wxapplet/bind/getIndexData/alipay/alipaymini?user_id=\(phoneNumber)")!)
        let dataFlowRequest = URLRequest(url: URL(string: "https://mina.10010.com/wxapplet/bind/getCombospare/alipay/alipaymini?stoken=\(stoken)&user_id=\(phoneNumber)")!)
        
        
        firstly {
            when(fulfilled: URLSession.shared.dataTask(.promise, with: feeRequest), URLSession.shared.dataTask(.promise, with: dataFlowRequest))
        }.map { (r0, r1) in
            return (try JSONDecoder().decode(CHUUserInfo.self, from: r0.data), try JSONDecoder().decode(CHUFeeList.self, from: r1.data))
        }.done { (userInfo, feeList) in
            self.updateTimeLabel.text = userInfo.flush_date_time
            // 剩余话费
            if let fee = userInfo.dataList.filter({ (item) -> Bool in item.type == .free }).first {
                self.remindCallChargeLabel.text = "\(fee.number) \(fee.unit)"
            }
            
            // 剩余通话
            if let voice = userInfo.dataList.filter({ (item) -> Bool in item.type == .voice }).first {
                self.remindCallTimeLabel.text = "\(voice.number) \(voice.unit)"
            }
            
            // 剩余流量
            let cellularData = feeList.woFeePolicy.filter{ $0.elemType == .data}.reduce(0, { (result, item) -> (Float) in
                return result + (Float(item.canUseResourceVal) ?? 0)
            })
            self.remindCellularDataLabel.text = "\(cellularData) MB"
            completionHandler(.newData)
        }.catch { error in
            self.updateTimeLabel.text = "数据请求错误"
            print("Json Decoder Error: \(error)")
            completionHandler(.failed)
        }
    }
}
