//
//  CountryTableViewController.swift
//  Assignment
//
//  
//  Copyright © 2018 Nikhil Dhavale. All rights reserved.
//

import UIKit
import CoreData
// This class is used to show items in Table mainly used in iPhone and split view in case of iPad
class CountryTableViewController: UITableViewController {
    var countries = [Country](){
        didSet{
            tableView?.reloadData()
        }
    }
    var fetchResultController = DatabaseModel.shared.getFetchResultController()
    /// On section selection as Fav then query FetchController and reload table data
    var tabSection = TabSection.List
    {
        didSet{
            if tabSection == .Fav{
                do{
                    try fetchResultController.performFetch()
                    tableView?.reloadData()


                }
                catch{
                    
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "FavCountryTableViewCell", bundle: nil), forCellReuseIdentifier: StoryBoardConstants.FavCountryCellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if tabSection == .List {
        return countries.count
        }
        else{
           return fetchResultController.sections?[section].numberOfObjects ?? 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tabSection == .List {
            let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoardConstants.CountryCellIdentifier, for: indexPath) as! CountryTableViewCell
            cell.configureUI(country: countries[indexPath.row], target: self.parent as Any, index: indexPath.row)
            
            return cell
        }
        else{ // fav
            let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoardConstants.FavCountryCellIdentifier, for: indexPath) as! FavCountryTableViewCell
            if let favCountry = fetchResultController.object(at: indexPath) as? FavCountry {
                cell.configureFavUI(favCountry: favCountry, indexPath: indexPath, target: self.parent as Any)
            }
            
            return cell
        }

    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tabSection == .List
        {
        let country = countries[indexPath.row]
        self.parent?.parent?.performSegue(withIdentifier: StoryBoardConstants.showDetails, sender: country)
        }
        else{
            if let favCountry = fetchResultController.object(at: indexPath) as? FavCountry {
                self.parent?.parent?.performSegue(withIdentifier: StoryBoardConstants.showDetails, sender: favCountry)
            }
            
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
