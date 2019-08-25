//
//  MoneyView.swift
//  TablePractice
//
//  Created by 別所大輝 on 2019/07/03.
//  Copyright © 2019 daiki. All rights reserved.
//

import UIKit

class MoneyView: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    var arrayMoneyDataName = [String]()         // 商品名の配列
    var arrayMoneyDataPrice = [Int]()           // 商品金額の配列
    var arrayMoneyDataImageName = [String]()    // 商品画像名の名前
    var rowNumber: Int!     // 行数
    
    // 遷移前画面から受け取るための値
    var schedules = [Date: [moneyDataStruct]]()
    var dateOrder = [Date]()
    
    private var formatter: DateFormatter  {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .none
        f.locale = Locale(identifier: "ja_JP")
        return f
    }
    
    private var timeFormatter: DateFormatter  {
        let f = DateFormatter()
        f.dateStyle = .none
        f.timeStyle = .short
        f.locale = Locale(identifier: "ja_JP")
        return f
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // 【必須】設定（セクションの行数）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let targetDate = dateOrder[section]
        return schedules[targetDate, default: []].count
        
    }
    
    // 【必須】設定（セル）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cl = tableView.dequeueReusableCell(withIdentifier:
            "ItemTableViewCell", for: indexPath) as? ItemTableViewCell else {
                return UITableViewCell()
        }
        
        let targetDate = dateOrder[indexPath.section]
        guard let plan = schedules[targetDate]?[indexPath.row] else {
            return cl
        }
        
        cl.lbContentsName.text = plan.contentsName
        cl.lbContentsPrice.text = String(plan.contentsPrice) + "円"
        cl.ivContents.image = UIImage(named: plan.contentsImageName)
        
//        cl.lbContentsName.text = arrayMoneyDataName[indexPath.row]
//        cl.lbContentsPrice.text = String(arrayMoneyDataPrice[indexPath.row])
//        cl.ivContents.image = UIImage(named: arrayMoneyDataImageName[indexPath.row])
        
        return cl
    }
    
    ////
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let targetDate = dateOrder[section]
        
        let label = UILabel()
        label.backgroundColor = .lightGray
        label.textColor = .white
        
        label.text = formatter.string(from: targetDate)
        
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return schedules.keys.count
    }
    
    ////

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}

