//
//  MontyMoney.swift
//  TablePractice
//
//  Created by 別所大輝 on 2019/07/17.
//  Copyright © 2019 daiki. All rights reserved.
//

import UIKit

class MontyMoney: UIViewController {
    
    var moneyDataStructMonthArray = [moneyDataStructMonth]()        // 月別を計算する構造体の配列
    
    // 各月支出額合計
    var sumMonth: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    @IBOutlet weak var lbOneTotalPrice: UILabel!
    @IBOutlet weak var lbTwoTotalPrice: UILabel!
    @IBOutlet weak var lbThreeTotalPrice: UILabel!
    @IBOutlet weak var lbFourTotalPrice: UILabel!
    @IBOutlet weak var lbFiveTotalPrice: UILabel!
    @IBOutlet weak var lbSixTotalPrice: UILabel!
    @IBOutlet weak var lbSevenTotalPrice: UILabel!
    @IBOutlet weak var lbeightTotalPrice: UILabel!
    @IBOutlet weak var lbNineTotalPrice: UILabel!
    @IBOutlet weak var lbTenTotalPrice: UILabel!
    @IBOutlet weak var lbElevenTotalPrice: UILabel!
    @IBOutlet weak var lbTewlveTotalPrice: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sumMonth = sumMonthPrice()
        
        printMontthPriceTotal()
        
        
    }
    
    // 構造体から月を取得し、月別合計金額を求める
    func sumMonthPrice() -> Array<Int> {
        
        // 構造体から月を取得し、月別合計金額を求める
        for moneyDataStructMonthArrayToFor in moneyDataStructMonthArray {
            
            let monthNumber = moneyDataStructMonthArrayToFor.contentsDateMonth
            
            switch  monthNumber {
            case 1:
                sumMonth[0] += moneyDataStructMonthArrayToFor.contentsPrice
            case 2:
                sumMonth[1] += moneyDataStructMonthArrayToFor.contentsPrice
            case 3:
                sumMonth[2] += moneyDataStructMonthArrayToFor.contentsPrice
            case 4:
                sumMonth[3] += moneyDataStructMonthArrayToFor.contentsPrice
            case 5:
                sumMonth[4] += moneyDataStructMonthArrayToFor.contentsPrice
            case 6:
                sumMonth[5] += moneyDataStructMonthArrayToFor.contentsPrice
            case 7:
                sumMonth[6] += moneyDataStructMonthArrayToFor.contentsPrice
            case 8:
                sumMonth[7] += moneyDataStructMonthArrayToFor.contentsPrice
            case 9:
                sumMonth[8] += moneyDataStructMonthArrayToFor.contentsPrice
            case 10:
                sumMonth[9] += moneyDataStructMonthArrayToFor.contentsPrice
            case 11:
                sumMonth[10] += moneyDataStructMonthArrayToFor.contentsPrice
            case 12:
                sumMonth[11] += moneyDataStructMonthArrayToFor.contentsPrice
            default:
                break
            }
            
        }
        
        return sumMonth
        
    }
    
    // 月別に表示する関数
    func printMontthPriceTotal() {
        lbOneTotalPrice.text = String(sumMonth[0]) + "円"
        lbTwoTotalPrice.text = String(sumMonth[1]) + "円"
        lbThreeTotalPrice.text = String(sumMonth[2]) + "円"
        lbFourTotalPrice.text = String(sumMonth[3]) + "円"
        lbFiveTotalPrice.text = String(sumMonth[4]) + "円"
        lbSixTotalPrice.text = String(sumMonth[5]) + "円"
        lbSevenTotalPrice.text = String(sumMonth[6]) + "円"
        lbeightTotalPrice.text = String(sumMonth[7]) + "円"
        lbNineTotalPrice.text = String(sumMonth[8]) + "円"
        lbTenTotalPrice.text = String(sumMonth[9]) + "円"
        lbElevenTotalPrice.text = String(sumMonth[10]) + "円"
        lbTewlveTotalPrice.text = String(sumMonth[11]) + "円"
    }
    

}
