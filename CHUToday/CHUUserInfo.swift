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
