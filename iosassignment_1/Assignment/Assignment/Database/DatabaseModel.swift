//
//  DatabaseModel.swift
//  Assignment
//
//  Created by Nikhil Modi on 3/6/18.
//  Copyright © 2018 Nikhil Dhavale. All rights reserved.
//

import Foundation
import CoreData
struct EntityName {
     static let User = "User"
    static let Country = "FavCountry"
    static let Info = "FavCountryInfo"
    static let language = "FavLanguage"
    
}
struct DatabaseOperation {
    static let favAdded = NSNotification.Name("FavAdded")
}
/// This class is singleton class to handle all database operations
class DatabaseModel {
  static let shared = DatabaseModel(dataModelContext: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    var dataModelContext:NSManagedObjectContext
  //  var info:FavCountryInfo
    init(dataModelContext:NSManagedObjectContext) {
        self.dataModelContext = dataModelContext
      //  self.info = NSEntityDescription.insertNewObject(forEntityName: EntityName.Info, into: dataModelContext) as! FavCountryInfo
        
    }
    func getObjectInstance(objectName:String) -> NSManagedObject{
        return NSEntityDescription.insertNewObject(forEntityName: objectName, into: self.dataModelContext)
    }
    /// This function inserts user info on successfully signup
    func insertUser(email:String,password:String) -> Bool{
        if let user = getObjectInstance(objectName: EntityName.User) as? User{
            user.email = email
            user.password = password
            do{
               try self.dataModelContext.save()
                return true

            }
            catch{
                print(error)
                return false
            }
        }
        return false
    }
    /// This function validates credentials
    func checkCredentials(email:String,password:String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entityDescription = NSEntityDescription.entity(forEntityName: "User", in: self.dataModelContext)
        fetchRequest.entity = entityDescription
        let predicate = NSPredicate(format: "email=%@ AND password=%@", email,password)
        fetchRequest.predicate = predicate
     
        do{
            
            return try self.dataModelContext.count(for: fetchRequest) > 0
        }
        catch{
            return false
        }
    }
    /**
     This funcation checks is user exists for signup
     - parameter userName - email
     */
    func checkIfUserExists(userName:String) -> Bool{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entityDescription = NSEntityDescription.entity(forEntityName: "User", in: self.dataModelContext)
        fetchRequest.entity = entityDescription
        let predicate = NSPredicate(format: "email=%@", userName)
        fetchRequest.predicate = predicate
        
        do{
            
            return try self.dataModelContext.count(for: fetchRequest) > 0
        }
        catch{
            return false
        }
    }
    /// This function check if country exists to avoid duplication
    func checkIfCountryExists(country:Country) ->Bool{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entityDescription = NSEntityDescription.entity(forEntityName: "FavCountry", in: self.dataModelContext)
        fetchRequest.entity = entityDescription
        let predicate = NSPredicate(format: "name=%@", country.name ?? "")
        fetchRequest.predicate = predicate
        
        do{
            
            return try self.dataModelContext.count(for: fetchRequest) > 0
        }
        catch{
            return false
        }
    }
    /// This function saves a country to be favourted
    func saveFavCountry(country:Country)  {
        if !checkIfCountryExists(country: country){
            guard let favCountry = getObjectInstance(objectName: EntityName.Country) as? FavCountry, let info = getObjectInstance(objectName: EntityName.Info) as? FavCountryInfo else {
                return
            }
            
            favCountry.name = country.name
            favCountry.capital = country.capital
            favCountry.region = country.region
            info.currencyCode = country.currencycodeName
            info.currencyName = country.currencyName
            info.currencySymbol = country.currencysymbol
            info.flagURL = country.flagURL
            if country.bordersName.count > 0 {
                info.borders = country.bordersName.joined(separator: ",")
            }
            favCountry.info = info
            for language in country.languageArray {
                guard let favLanguage = getObjectInstance(objectName: EntityName.language) as? FavLanguage else{
                    continue
                }
                favLanguage.languageName = language.languageName
                favLanguage.languageNative = language.languageNative
                favCountry.addToLanguages(favLanguage)
            }
            dataModelContext.performAndWait {
                do{
                    if dataModelContext.hasChanges {
                        try dataModelContext.save()

                    }
                }
                catch{
                    
                }
            }
            NotificationCenter.default.post(name: DatabaseOperation.favAdded, object: nil)
        }
    }
    /// This function will delete fav country
    func deleteFavCountry(favCountry:FavCountry){
        dataModelContext.delete(favCountry)
    }
    /// This function will return controller with all favourities
    func getFetchResultController() -> NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entityDescription = NSEntityDescription.entity(forEntityName: EntityName.Country, in: self.dataModelContext)
        fetchRequest.entity = entityDescription
        fetchRequest.sortDescriptors = [NSSortDescriptor(key:"name",ascending:true)]
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.dataModelContext, sectionNameKeyPath: nil, cacheName: nil)
    }

    /**
     This will give you favourities based on country searching key
     - parameter name - search value
     */
    func getFetchResultControllerWithSearch(name:String) -> NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entityDescription = NSEntityDescription.entity(forEntityName: EntityName.Country, in: self.dataModelContext)
        fetchRequest.entity = entityDescription
        fetchRequest.predicate = NSPredicate(format: "name CONTAINS %@", name)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key:"name",ascending:true)]
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.dataModelContext, sectionNameKeyPath: nil, cacheName: nil)
    }
    
}
