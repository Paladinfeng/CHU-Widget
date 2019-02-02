//
//  TodayViewController.swift
//  CHUToday
//
//  Created by xuezhaofeng on 2019/1/1.
//  Copyright © 2019 xuezhaofeng. All rights reserved.
//

import UIKit
import NotificationCenter
import Alamofire

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
        AF.request("https://alipay.10010.com/mobileWeChatApplet/home/queryUserInfo.htm", method: .get, parameters: ["mobile": phoneNumber, "stoken": stoken]).responseJSON { (response) in
            guard response.error == nil else {
                self.updateTimeLabel.text = "数据请求错误"
                completionHandler(.failed)
                return
            }
            do {
                let userInfo = try JSONDecoder().decode(CHUUserInfo.self, from: response.data!)
                self.updateTimeLabel.text = userInfo.flush_date_time
                if let fee = userInfo.dataList.filter({ (item) -> Bool in item.type == .fee }).first {
                    self.remindCallChargeLabel.text = "\(fee.number) \(fee.unit)"
                }
                if let flow = userInfo.dataList.filter({ (item) -> Bool in item.type == .flow }).first {
                    self.self.remindCellularDataLabel.text = "\(flow.number) \(flow.unit)"
                }
                if let voice = userInfo.dataList.filter({ (item) -> Bool in item.type == .voice }).first {
                    self.self.remindCallTimeLabel.text = "\(voice.number) \(voice.unit)"
                }
                completionHandler(.newData)
            } catch {
                self.updateTimeLabel.text = "数据解析错误"
                print("Json Decoder Error: \(error)")
                completionHandler(.failed)
            }
        }
    }
}
