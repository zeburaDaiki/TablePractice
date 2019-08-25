//
//  ViewController.swift
//  TablePractice
//
//  Created by 別所大輝 on 2019/07/02.
//  Copyright © 2019 daiki. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
   
    // 日付入力
    @IBOutlet weak var tfDate: UITextField!
    // 商品名入力
    @IBOutlet weak var tfContents: UITextField!
    // 金額入力
    @IBOutlet weak var tfmoney: UITextField!
    // 項目選択画面
    @IBOutlet weak var tfImage: UITextField!
    
    
    @IBOutlet weak var doButtonOutlet: UIButton!
    
    var moneyData: MoneyData!               // MoneyData型のオブジェクトを用意
    var moneyDataArray = [MoneyData]()      // MoneyData型のオブジェクトを配列で用意
    var arrayMoneyDataName = [String]()     // 商品入力画面から受けとった値を配列
    var arrayMoneyDataPrice = [Int]()       // 金額入力画面から受けとった値を配列
    var arrayMoneyDataImageName = [String]()     // 項目選択画面から受けとった値を配列
    
    var moneyDataStructArray = [moneyDataStruct]()        // クラスから配列に変更した値を構造体の配列に代入
    var schedules = [Date: [moneyDataStruct]]()           // 構造体の値を辞書型に変更
    var dateOrder = [Date]()                              // Date型の配列を用意
    
    
    var moneyDataStructMonthArray = [moneyDataStructMonth]()        // 月別を計算する構造体の配列
    
    // イメージピッカー&イメージビュー
    let pickerView = UIPickerView()
    let arrayImageJapaneseName = ["","食費","通信費","交通費","外食","レジャー","ジム","その他"]
    
    //  デートピッカー
    let datePicker = UIDatePicker()
    
    var buttonNumber = 0    // ボタンが押された回数
    
//    var tfNumber = 0        // テキストフィールドにすべて適切な値があるかどうか
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfmoney.keyboardType = UIKeyboardType.numberPad     // 数値だけ入力するようにする
//        doButtonOutlet.isEnabled = false                    // 入力画面が全部記入されない限りボタンOFF
//        doButtonOutlet.alpha = 0.2                          // ボタンOFFの時は透明
 
        
        // 金額入力テキストフィールド
        moneyTexrField()
        
        // デートピッカー
        createDatePicker()
        
        // 商品の画像ピッカー
        createImageNamePicker()
        
        
    }
    
    func moneyTexrField() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        let doneButton   = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(ViewController.doneMoneyPressed))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.cancelMoneyPressed))
        let spaceButton  = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        tfmoney.inputAccessoryView = toolBar
        
    }
    
    // Done
    @objc func doneMoneyPressed() {
        view.endEditing(true)
    }
    
    // Cancel
    @objc func cancelMoneyPressed() {
        tfImage.text = ""
        view.endEditing(true)
    }

    
    
    // デートピッカー
    ////
    func createDatePicker(){
        
        // DatePickerModeをDate(日付)に設定
        datePicker.datePickerMode = .date
        
        // DatePickerを日本語化
        datePicker.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        
        // textFieldのinputViewにdatepickerを設定
        tfDate.inputView = datePicker
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        let doneButton   = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(ViewController.doneClicked))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.canceClicked))
        let spaceButton  = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        tfDate.inputAccessoryView = toolBar
    }
    
    @objc func doneClicked(){
        let dateFormatter = DateFormatter()
        
        // 持ってくるデータのフォーマットを設定
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale    = NSLocale(localeIdentifier: "ja_JP") as Locale?
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        // textFieldに選択した日付を代入
        tfDate.text = dateFormatter.string(from: datePicker.date)
        // キーボードを閉じる
        view.endEditing(true)
    }
    
    // Cancel
    @objc func canceClicked() {
        tfDate.text = ""
        view.endEditing(true)
    }
    ////
    
    // 商品画像選択ピッカー
    ////
    func createImageNamePicker() {
        pickerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: pickerView.bounds.size.height)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let vi = UIView(frame: pickerView.bounds)
        vi.backgroundColor = UIColor.white
        vi.addSubview(pickerView)
        
        tfImage.inputView = vi
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        let doneButton   = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(ViewController.donePressed))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.cancelPressed))
        let spaceButton  = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        tfImage.inputAccessoryView = toolBar
        
    }
    
    //    // Done
    @objc func donePressed() {
        view.endEditing(true)
    }
    
    // Cancel
    @objc func cancelPressed() {
        tfImage.text = ""
        view.endEditing(true)
    }
    
    ////
    
    // MARK: - UIPickerViewDataSourceメソッド
    // Pickeで必須の処理
    // 【必須】設定（コンポーネント数）
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // 【必須】設定（コンポーネントの行数）
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayImageJapaneseName.count
    }
    
    // MARK: - UIPickerViewDelegateメソッド
    // セルの設定（文字列）
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        return arrayImageJapaneseName[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        
        tfImage.text = arrayImageJapaneseName[row]
        
    }
    
    
    @IBAction func tfSetDate(_ sender: Any) {
    }
    
    
    @IBAction func tfSetContents(_ sender: Any) {
    }
    
    
    
    @IBAction func tfSetMoney(_ sender: Any) {
    }
    
    
    
    @IBAction func tfSetKoumoku(_ sender: Any) {
    }
    
    
    /*
     
    // 日付入力テキストフィールド
    @IBAction func tfSetDate(_ sender: Any) {
        // 日付入力画面に値がある場合
        if tfContents.text != "" {
            tfNumber += 1
        }
        
        // 入力画面が全部記入されたらボタンON
        if tfNumber == 4 {
            doButtonOutlet.isEnabled = true
            doButtonOutlet.alpha = 1.0
        }
    }
    
    // 商品名入力テキストフィールド
    @IBAction func tfSetContents(_ sender: Any) {
        // 商品入力画面に値がある場合
        if tfContents.text != "" {
            tfNumber += 1
        }
        
        // 入力画面が全部記入されたらボタンON
        if tfNumber == 4 {
            doButtonOutlet.isEnabled = true
            doButtonOutlet.alpha = 1.0
        }
        
    }
 
 
    // 金額入力テキストフィールド
    @IBAction func tfSetMoney(_ sender: Any) {
        // 金額入力画面にInt型のがある場合
        let tfmoneyInt = Int(tfmoney.text ?? "0")!
        if tfmoneyInt > 0 {
            tfNumber += 1
        }
        
        // 入力画面が全部記入されたらボタンON
        if tfNumber == 4 {
            doButtonOutlet.isEnabled = true
            doButtonOutlet.alpha = 1.0
        }
    }
    
    
    // 項目選択テキストフィールド
    @IBAction func tfSetKoumoku(_ sender: Any) {
        // 項目選択画面に値がある場合
        if tfContents.text != "" {
            tfNumber += 1
        }
        
        // 項目選択画面がが全部記入されたらボタンON
        if tfNumber == 4 {
            doButtonOutlet.isEnabled = true
            doButtonOutlet.alpha = 1.0
        }
        
    }
 
    */
    
    
    // 日本語で設定されている文字列を画像で扱える文字列に変換
    func changeImageName(imageName: String) -> String {
        
        var englishImageName: String = ""
        
        switch tfImage.text {
        case "":
            englishImageName = "nil"
        case "食費":
            englishImageName = "food"
        case "通信費":
            englishImageName = "smartphone"
        case "交通費":
            englishImageName = "train"
        case "外食":
            englishImageName = "eatout"
        case "レジャー":
            englishImageName = "rezya"
        case "ジム":
            englishImageName = "zim"
        case "その他":
            englishImageName = "hatena"
        default:
            break
        }
        
        return englishImageName
        
    }
    
    
    // 決定ボタン押下
    @IBAction func doButton(_ sender: UIButton) {
        
        // テキストフィールドに入力された値をMoneyDataクラスにセット
        moneyData = MoneyData(
            contentsDate: tfDate.text!,
            contentsName: tfContents.text!,
            contentsPrice: Int(tfmoney.text!) ?? 0,
            contentsImageName: changeImageName(imageName: tfImage.text!)
        )
        
        // moneyDataを配列moneyArrayに代入
        moneyDataArray.append(moneyData)
        // String型の配列にmoneyArrayを代入していく(商品名)
        arrayMoneyDataName.append(moneyDataArray[buttonNumber].contentsName)
        // Int型の配列にmoneyArrayを代入していく(金額)
        arrayMoneyDataPrice.append(moneyDataArray[buttonNumber].contentsPrice)
        // String型の配列にmoneyArrayを代入していく(項目選択画面)
        arrayMoneyDataImageName.append(moneyDataArray[buttonNumber].contentsImageName)
        
        let f = DateFormatter()
        f.dateFormat = "yyyy/MM/dd"
        
        if moneyData.contentsDate == "" {
            moneyData.contentsDate = "2000/01/01"
        }

        //  クラスから構造体に変更
        let moneyDataStructValue = moneyDataStruct(
            contentsDate: f.date(from: moneyData.contentsDate)!,
            contentsName: moneyData.contentsName,
            contentsPrice: moneyData.contentsPrice,
            contentsImageName: moneyData.contentsImageName
        )
        
        ////////
        // Date型をString型に変更し、月のみ表示
        // クラスから月別の構造体に変更
        let f2 = DateFormatter()
        f2.dateFormat = "MM"
        let tuki = Int(f2.string(from: moneyDataStructValue.contentsDate)) ?? 0
        
        // 構造体に代入(月のみ)
        let moneyDataStructMonthValue = moneyDataStructMonth(
            contentsDateMonth: tuki,
            contentsName: moneyData.contentsName,
            contentsPrice: moneyData.contentsPrice,
            contentsImageName: moneyData.contentsImageName
        )
        
        // 構造体(月のみ)の配列に代入
        moneyDataStructMonthArray.append(moneyDataStructMonthValue)
        
        ////////
        
        moneyDataStructArray.append(moneyDataStructValue)
        
        schedules = Dictionary(grouping: moneyDataStructArray) { moneyDataStructArrayToChange -> Date in
            f.dateFormat = "yyyy/MM/dd"
            let s = f.string(from: moneyDataStructArrayToChange.contentsDate)
            return f.date(from: s)!
            }
            .reduce(into: [Date: [moneyDataStruct]]()) { dic, tuple in
                dic[tuple.key] = tuple.value.sorted { $0.contentsDate < $1.contentsDate }
        }
        
        // 日付順を保持するための配列
        dateOrder = Array(schedules.keys).sorted { $0 < $1 }
        
        buttonNumber += 1
                
        // 商品入力画面・金額入力画面リセット
        tfContents.text = ""
        tfmoney.text = nil
        tfImage.text = ""
        tfDate.text = ""
        
        /*
        // ボタンを初期設定に戻す
        doButtonOutlet.isEnabled = false
        doButtonOutlet.alpha = 0.2
        
        tfNumber = 0
         */
        
    }
    
    // リセットボタン
    @IBAction func doResetButton(_ sender: Any) {
        
        // 配列に入っている値を全削除
        moneyDataArray.removeAll()
        arrayMoneyDataName.removeAll()
        arrayMoneyDataPrice.removeAll()
        arrayMoneyDataImageName.removeAll()
        moneyDataStructMonthArray.removeAll()
        schedules.removeAll()
        dateOrder.removeAll()
        moneyDataStructArray.removeAll()
        
        
        // 入力画面リセット
        tfContents.text = ""
        tfmoney.text = nil
        tfImage.text = ""
        tfDate.text = ""
        
        
        // ボタンを押された回数しリセット
        buttonNumber = 0
        // tfNumber = 0
        
    }
    
    // 画面遷移時
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let sid = segue.identifier else {
            return
        }
        
        // 画面の遷移時
        // 家計簿画面
        if sid == "sample" {
            
            // 遷移先画面のインスタンス取得
            let vw = segue.destination as! MoneyView
            
            // 遷移先のクラスのプロパティに値をセット
            vw.arrayMoneyDataName = arrayMoneyDataName      // 商品名
            vw.arrayMoneyDataPrice = arrayMoneyDataPrice    // 商品の値段
            vw.arrayMoneyDataImageName = arrayMoneyDataImageName         // 商品の画像選択
            vw.rowNumber = moneyDataArray.count
            
            vw.schedules = schedules
            vw.dateOrder = dateOrder
            
        }
        
        // 月別画面
        if sid == "month" {
            
            // 遷移先画面のインスタンス取得
            let vw = segue.destination as! MontyMoney
            vw.moneyDataStructMonthArray = moneyDataStructMonthArray
            
        }
        
    }
    

}



