//
//  Constants.swift
//  Assignment
//
//  
//  Copyright © 2018 Nikhil Dhavale. All rights reserved.
//

import Foundation
import UIKit
struct ColorConstants {
    static let NavigationColor = UIColor(red: 235/255, green: 25/255, blue: 90/255, alpha: 1.0)
    static let TabbarColor = UIColor(red: 65/255, green: 65/255, blue: 65/255, alpha: 1.0)
    static let LightBackgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
    static let DarkBackgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
    static let IconsGreyColor = UIColor(red: 140/255, green: 140/255, blue: 140/255, alpha: 1.0)
    static let TextColor = UIColor(red: 65/255, green: 65/255, blue: 65/255, alpha: 1.0)

}

struct PlaceHolderText {
    static let UserName = "User name"
    static let Password = "Password"
    static let ConfirmPassword = "Confirm password"
}
struct StoryBoardConstants {
    static let AuthenticationSuccess = "authenticationSegue"
    static let CountryCellIdentifier = "countryCellIdentifier"
    static let showDetails = "showDetails"
    static let FavCountryCellIdentifier = "favCountryCellIdentifier"
}
struct NetworkConstant {
    static let AllCountriesURL = URL(string:"https://restcountries.eu/rest/v2/all")!
}
struct FontConstant {
    static let defaultFont = UIFont.systemFont(ofSize: 20)
    static let defaultBoldFont = UIFont.systemFont(ofSize: 20, weight: .bold)
    static let defaultBoldFontHigher = UIFont.systemFont(ofSize: 22, weight: .bold)

}
struct Title {
    static let CountriesTitle = "Countries"
    static let Favourities = "Favourities"
}
