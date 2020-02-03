//
//  CustomTabViewController.swift
//  Assignment
//
//  
//  Copyright © 2018 Nikhil Dhavale. All rights reserved.
//

import UIKit
enum TabSection {
    case List
    case Fav
}
class CustomTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"logout"), style: .done, target: self, action: #selector(self.logOut))


    }
    @objc func logOut(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? CountryDetailViewController {
            if let country = sender as? Country {
                destination.country = country
            }
            else if let favCountry = sender as? FavCountry {
                destination.favCountry = favCountry
            }
        }
    }
    

}
