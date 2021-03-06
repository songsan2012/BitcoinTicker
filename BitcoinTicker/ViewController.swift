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

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
//    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    let currencyArray = ["btc", "ltc","doge","eth","powr"]
    
    var finalURL = ""
    var selectedAltCoin = ""
    
    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        currencyPicker . UIPickerViewDataSource = self
//        UIPickerViewDelegate = self

        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        
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
//        print(row)
        print(currencyArray[row])
        
        //finalURL = baseURL + currencyArray[row]
        selectedAltCoin = currencyArray[row]
        
        finalURL = "https://www.coinspot.com.au/pubapi/latest"
        print("FinalURL is \(finalURL)")
        
        getBitcoinData(url: finalURL)
        
    }
    

    
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
//    func getWeatherData(url: String, parameters: [String : String]) {
    func getBitcoinData(url: String) {
        
//        Alamofire.request(url, method: .get, parameters: parameters)
//            .responseJSON { response in
//                if response.result.isSuccess {
//
//                    print("Sucess! Got the weather data")
//                    let weatherJSON : JSON = JSON(response.result.value!)
//
//                    self.updateWeatherData(json: weatherJSON)
//
//                } else {
//                    print("Error: \(String(describing: response.result.error))")
//                    self.bitcoinPriceLabel.text = "Connection Issues"
//                }
//            }
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {

                    print("Sucess! Got the bitcoin data")
                    let bitcoinJSON : JSON = JSON(response.result.value!)

//                    self.updateWeatherData(json: weatherJSON)
                    self.updateBitcoinData(json: bitcoinJSON)

                } else {
                    print("Error: \(String(describing: response.result.error))")
                    self.bitcoinPriceLabel.text = "Connection Issues"
                }
            }

    }

    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    func updateBitcoinData(json : JSON) {

        //if let tempResult = json["main"]["temp"].double {

//        weatherData.temperature = Int(round(tempResult!) - 273.15)
//        weatherData.city = json["name"].stringValue
//        weatherData.condition = json["weather"][0]["id"].intValue
//        weatherData.weatherIconName =    weatherData.updateWeatherIcon(condition: weatherData.condition)
        //}
        
        // -- Just get the bitcoin data for now
        let apiStatus = json["status"]
//        let bitcoinPrice = json["prices"]["btc"]["last"]
        let bitcoinPrice = json["prices"][selectedAltCoin]["last"]
        
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        
        var bitcoinPriceCurrency = numberFormatter.string(for: bitcoinPrice)
        
        print ("apiStatus: \(apiStatus)")
        print ("bitcoinPrice: \(bitcoinPrice)")
        print ("bitcoinPriceCurrency: \(bitcoinPriceCurrency)")
        
        // -- Display the day if apiStatus = "OK"
        if apiStatus == "ok" {
            bitcoinPriceLabel.text = "\(bitcoinPrice)"
        }
        

//        updateUIWithWeatherData()
    }
    




}

