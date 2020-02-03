//
//  NetworkSession.swift
//  Assignment
//
//  
//  Copyright © 2018 Nikhil Dhavale. All rights reserved.
//

import Foundation

class NetworkSession {
    var sucessBlock : (Data) -> Void
    var failureBlock : (Error) -> Void
    init(sucessBlock:@escaping (Data)->Void, failureBlock:@escaping (Error)->Void) {
        self.sucessBlock = sucessBlock
        self.failureBlock = failureBlock
    }
    func setUpGetRequest(url:URL){
        let session = URLSession.shared
        session.dataTask(with: url, completionHandler: {(data,response,error) in
            if data != nil {
                self.sucessBlock(data!)
            }
            else if error != nil {
                self.failureBlock(error!)
            }
            
        }).resume()
    }
}
