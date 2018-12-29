//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Angela Yu on 23/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    var currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var currentSymbolArray = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var finalURL = ""
    
    var currencySelected = ""

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.currencyPicker.delegate = self
        self.currencyPicker.dataSource = self
        
    }

    
    //TODO: Place your 3 UIPickerView delegate methods here
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
   
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(currencyArray[row])
        finalURL = baseURL + currencyArray[row]
        
        currencySelected = currentSymbolArray[row]
       getBitcoin(url: finalURL)
    }
    
    
 
//    //MARK: - Networking
//    /***************************************************************/
    func getBitcoin(url: String) {
        Alamofire.request(url, method: .get).responseJSON { (response) in
            if response.result.isSuccess {
                let bittcoinReult: JSON = JSON(response.result.value!)
                print(bittcoinReult)
                self.createBitcoinData(json: bittcoinReult)
            }else {
                self.bitcoinPriceLabel.text = "error"
            }
        }
    }
    

//    //MARK: - JSON Parsing
//    /***************************************************************/
    func createBitcoinData(json: JSON) {
        if let currentBitcoin = json["ask"].double {
            bitcoinPriceLabel.text = "\(currencySelected)\(currentBitcoin)"
        }else {
            bitcoinPriceLabel.text = "Something wrong"
        }
        
        
    }

    


}

