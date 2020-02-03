//
//  CountryCollectionViewController.swift
//  Assignment
//
//  Created by Nikhil Modi on 3/6/18.
//  Copyright © 2018 Nikhil Dhavale. All rights reserved.
//

import UIKit
import CoreData
/// This class is used to show the country items in grid mainly used in iPad
class CountryCollectionViewController: UICollectionViewController {
    var countries = [Country](){
        didSet{
            collectionView?.reloadData()
        }
    }
    var fetchResultController = DatabaseModel.shared.getFetchResultController()
    var tabSection = TabSection.List{
        didSet{
            if tabSection == .Fav{
                do{
                    try fetchResultController.performFetch()
                    collectionView?.reloadData()
                    
                    
                }
                catch{
                    
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let collectionFlowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            collectionFlowLayout.estimatedItemSize = CGSize(width: 10, height: 10)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if tabSection == .List {
        return countries.count
        }else{
            return fetchResultController.sections?[section].numberOfObjects ?? 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        if tabSection == .List {
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryBoardConstants.CountryCellIdentifier, for: indexPath) as! CountryCollectionViewCell
            cell.configureUI(country: countries[indexPath.row], target: self.parent as Any,index: indexPath.row)
            return cell

        }
        else{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryBoardConstants.FavCountryCellIdentifier, for: indexPath) as! FavCollectionViewCell
            if let favCountry = fetchResultController.object(at: indexPath) as? FavCountry {
                cell.configureFavUI(favCountry: favCountry, indexPath: indexPath,target: self.parent as Any)
            }
            return cell
        }
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if tabSection == .List {
            let country = countries[indexPath.row]
            self.parent?.parent?.performSegue(withIdentifier: StoryBoardConstants.showDetails, sender: country)
        }
        else{
            if let favCountry = fetchResultController.object(at: indexPath) as? FavCountry {
                self.parent?.parent?.performSegue(withIdentifier: StoryBoardConstants.showDetails, sender: favCountry)
            }
        }
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
