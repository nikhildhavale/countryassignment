//
//  FavCollectionViewCell.swift
//  Assignment
//
//  Created by Nikhil Modi on 3/7/18.
//  Copyright © 2018 Nikhil Dhavale. All rights reserved.
//

import UIKit
import SVGKit
struct ImageUI {
    static let maxDimension:CGFloat = 88
}
class FavCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var flagImageheightConstraint: NSLayoutConstraint!
    @IBOutlet weak var flagImageWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryInfo: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    /**
     This function is used to configure ui of collectioncell
     
     - parameter favCountry -  country instance from database
     - parameter target  -  This target is used to handle callbacks of fav button click
     - parameter indexPath   -  The indexPath's row is set to tag of button which will help in callback to map the country
     that needs to be favourited
     */
    func configureFavUI(favCountry:FavCountry,indexPath:IndexPath,target:Any){
        countryInfo.attributedText = favCountry.getBasicInfo()
        let  networkSession = NetworkSession(sucessBlock: {(data) in
            DispatchQueue.main.async {
                let svgImage = SVGKImage(data: data)
                self.flagImageView.image = svgImage?.uiImage
            }
            
        }, failureBlock: {(error) in
            
            
        })
        if let flagURL = favCountry.info?.flagURL {
            networkSession.setUpGetRequest(url: URL(string:flagURL)!)
        }
        deleteButton.tag = indexPath.row
        deleteButton.addTarget(target, action: #selector(FavouritiesListViewController.deleteItem(button:)), for: .touchUpInside)
        
    }
    
}
