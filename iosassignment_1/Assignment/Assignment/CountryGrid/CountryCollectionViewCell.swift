//
//  CountryCollectionViewCell.swift
//  Assignment
//
//  Created by Nikhil Modi on 3/6/18.
//  Copyright © 2018 Nikhil Dhavale. All rights reserved.
//

import UIKit

class CountryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var countryInfo: UILabel!
    @IBOutlet weak var favButton: UIButton!
    /**
     This function is used to configure ui of collectionviewcell
     
     - parameter country -  country instance from server
     - parameter target  -  This target is used to handle callbacks of fav button click
     - parameter index   -  This index is set to tag of button which will help in callback to map the country
     that needs to be favourited
     */
    func configureUI(country:Country,target:Any,index:Int){
        countryInfo.attributedText = country.getBasicCountryInfo()
        favButton.tag = index
   favButton.addTarget(target, action: #selector(CountryListViewController.saveToFavourities(button:)), for: .touchUpInside)
        
    }
    
    /// This function is not used since different cell is used for collection view 
    func configureUI(favCountry:FavCountry){
        countryInfo.attributedText = favCountry.getBasicInfo()
        
    }
}
