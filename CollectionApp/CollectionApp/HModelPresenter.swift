//
//  HModelPresenter.swift
//  CollectionApp
//
//  Created by Rex Chen on 2021/3/9.
//

import Foundation

protocol HModelPresenterDelegate {
    
    func didRequestCompleted()
}

class HModelPresenter {
    
    var delegate:HModelPresenterDelegate?
    
    private var model:[Any]?
    
    func requestData() {
        
        let session = URLSession.shared
        let url = URL(string: "https://dl.dropboxusercontent.com/s/uq2wxwn9intgzj5/pageHouzz.json")!
        let task = session.dataTask(with: URLRequest(url: url)) { [self] (data, response, error) in

            if let theDelegate = self.delegate {
                do {
                    model = try (JSONSerialization.jsonObject(with: data!, options: []) as? [Any])
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
                theDelegate.didRequestCompleted()
            }
        }
        task.resume()
    }
    
    func modelCount()->Int {
        if model != nil {
            return (model!).count
        }
        return 0
    }
    
    func modelDataAt(index:Int)->[String:Any] {
        
        return model![index] as! [String:Any]
    }
}
