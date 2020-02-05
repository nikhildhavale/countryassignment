//
//  Country.swift
//  Assignment
//
//  
//  Copyright © 2018 Nikhil Dhavale. All rights reserved.
//

import Foundation
import UIKit
class Language{
    var languageName:String?
    var languageNative:String?
}
class Country {
    var name:String?
    var capital:String?
    var region:String?
    var currencyName:String?
    var currencycodeName:String?
    var currencysymbol:String?
    var languageArray = [Language]()
    var bordersName = [String]()
    var flagURL:String?
    /// Convert json item to Country
    static func parseCountry(dictionary:[String:Any]) -> Country {
        let country = Country()
        country.name = dictionary["name"] as? String
        country.capital = dictionary["capital"] as? String
        country.region = dictionary["region"] as? String
        country.currencyName = dictionary["code"] as? String
        if let currenyDictionaryArray = dictionary["currencies"] as? [[String:Any]]{
            if let currencyDictionary = currenyDictionaryArray.first {
                country.currencyName = currencyDictionary["name"] as? String
                country.currencycodeName = currencyDictionary["code"] as? String
                country.currencysymbol = currencyDictionary["symbol"] as? String
            }
            
        }
        if let languageDictionaryArray = dictionary["languages"] as? [[String:Any]]{
            for languageDictionary in languageDictionaryArray {
                let language = Language()
                language.languageName = languageDictionary["name"] as? String
                language.languageNative = languageDictionary["nativeName"] as? String
                country.languageArray.append(language)
            }
        }
        if let regionalDictionaryArray = dictionary["regionalBlocs"] as? [[String:Any]]{
            for regionalDictionary in regionalDictionaryArray {
                if let name = regionalDictionary["name"] as? String {
                    country.bordersName.append(name)
                }
            }
        }
        country.flagURL = dictionary["flag"] as? String
        
        return country
    }
    /// Convert json array to country Array
    static func parseCountries(dictionaryArray:[[String:Any]]) -> [Country]{
        var countryArray = [Country]()
        for dictionary in dictionaryArray {
            let country  = parseCountry(dictionary: dictionary)
            countryArray.append(country)
        }
        return countryArray
    }
    /// Show complete country info used in country detail
    func completeCountryInfo() -> NSMutableAttributedString{
        let completeCountryInfoString = NSMutableAttributedString()
        /// country name
        completeCountryInfoString.append(NSAttributedString.mainAttributedString(string: name))
        completeCountryInfoString.append(NSAttributedString.itemAttributedString(string: capital))
        completeCountryInfoString.append(NSAttributedString.itemAttributedString(string: region))
        // currency info
        completeCountryInfoString.append(NSAttributedString.mainAttributedString(string: "Currency"))
        completeCountryInfoString.append(NSAttributedString.itemAttributedString(string: currencyName))
        completeCountryInfoString.append(NSAttributedString.itemAttributedString(string: currencysymbol))
        completeCountryInfoString.append(NSAttributedString.itemAttributedString(string: currencycodeName))
        // Language
        if languageArray.count != 0 {
            completeCountryInfoString.append(NSAttributedString.mainAttributedString(string: "Language"))
            for language in languageArray {
                completeCountryInfoString.append(NSAttributedString.itemAttributedString(string: language.languageName))
                completeCountryInfoString.append(NSAttributedString.itemAttributedString(string: language.languageNative))
            }
        }
        if bordersName.count != 0 {
            completeCountryInfoString.append(NSAttributedString.mainAttributedString(string: "Borders"))
            for borderString in bordersName {
                completeCountryInfoString.append(NSAttributedString.itemAttributedString(string: borderString))
            }
        }

      //  completeCountryInfoString.append(self.itemAttributedString(string: "\n"))
        return completeCountryInfoString
    }
    /// Return AttributedString to show info in item cell
    func getBasicCountryInfo() -> NSMutableAttributedString{
        let countryInfo = NSMutableAttributedString()
        if name != nil {
            let countryName = NSAttributedString(string: name!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.black,NSAttributedString.Key.font:FontConstant.defaultBoldFont])
            countryInfo.append(countryName)
        }
        countryInfo.append(NSAttributedString.itemNonBoldAttributedString(string: capital))
        countryInfo.append(NSAttributedString.itemNonBoldAttributedString(string: region))
        return countryInfo
    }
}
