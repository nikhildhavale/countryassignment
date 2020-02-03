//
//  CountryListViewController.swift
//  Assignment
//
//  
//  Copyright © 2018 Nikhil Dhavale. All rights reserved.
//

import UIKit

class CountryListViewController: UIViewController {
    var countries = [Country]()
    var tabSection = TabSection.List
    override func viewDidLoad() {
        super.viewDidLoad()
        let networkSession = NetworkSession(sucessBlock: { (data) in
            do{
                if let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String:Any]]{
                    self.countries = Country.parseCountries(dictionaryArray: dictionary)
                    
                    DispatchQueue.main.async {
                        self.setCountryData()
                    }
                }
            }
            catch{
                
            }

            }, failureBlock: {(error ) in
                DispatchQueue.main.async {
                    self.showAlertOK(title: "Error", message: error.localizedDescription)
                }
                
        })
        networkSession.setUpGetRequest(url: NetworkConstant.AllCountriesURL)
    }
    /// set the data to child controllers on recieving response from the server
    func setCountryData(){
        if self.traitCollection.userInterfaceIdiom == .pad{
            if let countryCollectionCountroller = self.childViewControllers[1] as? CountryCollectionViewController {
                countryCollectionCountroller.countries = countries
                countryCollectionCountroller.tabSection = .List
            }
        }
        if let countryController = self.childViewControllers.first as? CountryTableViewController {
                countryController.countries = countries
            countryController.tabSection = .List
            
        }

    }
    /// Save favourities data in database
    @objc func saveToFavourities(button:UIButton){
        DatabaseModel.shared.saveFavCountry(country: countries[button.tag])
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.parent?.navigationItem.title = Title.CountriesTitle

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
