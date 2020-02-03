//
//  CountryTableViewCell.swift
//  Assignment
//
//  
//  Copyright © 2018 Nikhil Dhavale. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    @IBOutlet weak var favButton: UIButton!

    @IBOutlet weak var labelText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    /**
     This function is used to configure ui of tableviewcell
     
     - parameter country -  country instance from server
     - parameter target  -  This target is used to handle callbacks of fav button click
     - parameter index   -  This index is set to tag of button which will help in callback to map the country
     that needs to be favourited
     */
    func configureUI(country:Country,target:Any,index:Int){
        labelText.attributedText = country.getBasicCountryInfo()
        favButton.tag = index
        favButton.addTarget(target, action: #selector(CountryListViewController.saveToFavourities(button:)), for: .touchUpInside)
    }
    /// This function is not used. Since Fav cell is different in xib
    func configureFavUI(country:FavCountry){
        labelText.attributedText = country.getBasicInfo()

    }

}
