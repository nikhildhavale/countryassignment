//
//  FavouritiesListViewController.swift
//  Assignment
//
//  
//  Copyright © 2018 Nikhil Dhavale. All rights reserved.
//

import UIKit
import CoreData
class FavouritiesListViewController: UIViewController,UISearchBarDelegate {
    var tabSection = TabSection.Fav

    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.faveAdded(notification:)), name: DatabaseOperation.favAdded, object: nil)
        loadData(fetchResultController: DatabaseModel.shared.getFetchResultController())

    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.navigationItem.title = Title.Favourities
        
        
    }
   @objc func faveAdded(notification:Notification){
        loadData(fetchResultController: DatabaseModel.shared.getFetchResultController())
    }
    @objc func deleteItem(button:UIButton){
        let indexPath = IndexPath(row: button.tag, section: 0)
        if self.traitCollection.userInterfaceIdiom == .pad{
            if let countryCollectionCountroller = self.childViewControllers[1] as? CountryCollectionViewController {
                if let favCountry = countryCollectionCountroller.fetchResultController.object(at: indexPath) as? FavCountry{
                    DatabaseModel.shared.deleteFavCountry(favCountry: favCountry)
                }
            }
        }
        if let countryController = self.childViewControllers.first as? CountryTableViewController {
            if let favCountry = countryController.fetchResultController.object(at: indexPath) as? FavCountry{
                DatabaseModel.shared.deleteFavCountry(favCountry: favCountry)

            }
        }
        loadWithSearch()
    }
    func loadWithSearch(){
        if let searchString = searchBar.text {
            if searchString.count == 0 {
                loadData(fetchResultController: DatabaseModel.shared.getFetchResultController())
                
            }else{
                loadData(fetchResultController: DatabaseModel.shared.getFetchResultControllerWithSearch(name: searchString))
                
            }
        }
        else{
            loadData(fetchResultController: DatabaseModel.shared.getFetchResultController())
            
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchText.count == 0 {
            loadData(fetchResultController: DatabaseModel.shared.getFetchResultController())

        }else{
            loadData(fetchResultController: DatabaseModel.shared.getFetchResultControllerWithSearch(name: searchText))

        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        loadWithSearch()
        
    }
    /// LoadData with fectch controller and reload data on enum set
    func loadData(fetchResultController:NSFetchedResultsController<NSFetchRequestResult>){
        if self.traitCollection.userInterfaceIdiom == .pad{
            if let countryCollectionCountroller = self.childViewControllers[1] as? CountryCollectionViewController {
                countryCollectionCountroller.fetchResultController = fetchResultController

                countryCollectionCountroller.tabSection = .Fav
            }
        }
        if let countryController = self.childViewControllers.first as? CountryTableViewController {
            countryController.fetchResultController = fetchResultController
            countryController.tabSection = .Fav
            
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
