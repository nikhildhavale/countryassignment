//
//  CountryDetailViewController.swift
//  Assignment
//
//  
//  Copyright © 2018 Nikhil Dhavale. All rights reserved.
//

import UIKit
import WebKit
import SVGKit
class CountryDetailViewController: UIViewController {

    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var flagHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var countryInfo: UILabel!
    @IBOutlet weak var FlagView: UIImageView!
    var country:Country?
    var favCountry:FavCountry?
    var networkSession:NetworkSession?
    override func viewDidLoad() {
        super.viewDidLoad()
        widthConstraint.constant = UIScreen.main.bounds.width - 100
        networkSession = NetworkSession(sucessBlock: {(data) in
            DispatchQueue.main.async {
                let svgImage = SVGKImage(data: data)
                self.FlagView.image = svgImage?.uiImage
                if let size = self.FlagView.image?.size{
                    self.flagHeightConstraint.constant = self.widthConstraint.constant * size.height/size.width

                }
            }
            
        }, failureBlock: {(error) in
            
            
        })
        if let flagString = country?.flagURL{
            networkSession?.setUpGetRequest(url: URL(string:flagString)!)
            countryInfo.attributedText = country?.completeCountryInfo()
            starImage.isHidden = true
        }
        else if let flagString = favCountry?.info?.flagURL{
            networkSession?.setUpGetRequest(url: URL(string:flagString)!)
            countryInfo.attributedText = favCountry?.getCompleteInfo()
            starImage.isHidden = false

        }
        countryInfo.backgroundColor = UIColor.clear
    }
    override func viewWillAppear(_ animated: Bool) {
        

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
