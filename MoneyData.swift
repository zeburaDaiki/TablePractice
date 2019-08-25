//
//  MoneyData.swift
//  TablePractice
//
//  Created by 別所大輝 on 2019/07/02.
//  Copyright © 2019 daiki. All rights reserved.
//

import Foundation

// 日付がDate型の構造体
struct moneyDataStruct {
    
    // 商品購入日付
    var contentsDate: Date
    // 商品名
    var contentsName: String
    // 商品の金額
    var contentsPrice: Int
    // 商品の種類選択
    var contentsImageName: String
    
}

// 日付が月のみの構造体
struct moneyDataStructMonth {
    
    // 商品購入日付
    var contentsDateMonth: Int
    // 商品名
    var contentsName: String
    // 商品の金額
    var contentsPrice: Int
    // 商品の種類選択
    var contentsImageName: String
    
}


class MoneyData {
    
    // 商品購入日付
    var contentsDate: String
    // 商品名
    var contentsName: String
    // 商品の金額
    var contentsPrice: Int
    // 商品の種類選択
    var contentsImageName: String
    
    var moneyDataCount = 0
    
    init(contentsDate: String, contentsName: String, contentsPrice: Int, contentsImageName: String) {
        
        self.contentsDate = contentsDate
        self.contentsName = contentsName
        self.contentsPrice = contentsPrice
        self.contentsImageName = contentsImageName
        moneyDataCount += 1
    
    }

}
