//
//  CHUUserInfo.swift
//  CHUToday
//
//  Created by xuezhaofeng on 2019/1/6.
//  Copyright © 2019 xuezhaofeng. All rights reserved.
//

import Foundation

enum CHUUserInfoType: String, Decodable {
    case fee = "fee"
    case flow = "flow"
    case voice = "voice"
    case free = "free"
}

struct CHUUserInfoItem: Decodable {
    let unit: String
    let persent: String
    let number: String
    let type: CHUUserInfoType
    let remainTitle: String
    let isWarn: String
}

struct CHUUserInfo: Decodable {
    let flush_date_time: String
    let dataList: [CHUUserInfoItem]
}

enum CHUFeePolicyType: String, Decodable {
    //语音
    case talk = "1"
    // 短信
    case text = "2"
    // 流量
    case data = "3"
}

struct CHUFeePolicy: Decodable {
    let addUpItemName: String
    let elemType: CHUFeePolicyType
    let canUseResourceVal: String
}

struct CHUFeeList: Decodable {
    let woFeePolicy: [CHUFeePolicy]
}
