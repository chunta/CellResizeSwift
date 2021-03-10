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
    
    private var model:[CellRow]?
    
    func requestData() {
        
        let session = URLSession.shared
        let r:Int = Int.random(in: 0...200)
        let url = URL(string: "https://dl.dropboxusercontent.com/s/uq2wxwn9intgzj5/pageHouzz.json?r=" + String(r))!
        let task = session.dataTask(with: URLRequest(url: url)) { [self] (data, response, error) in
            if let theDelegate = self.delegate {
                model = []
                do {
                    model = try JSONDecoder().decode(Array<CellRow>.self, from: data!)
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
    
    func modelDataAt(index:Int)->CellRow {
        
        if let theModel = model {
            if (theModel.count > index) {
                return theModel[index]
            }
        }
        return CellRow.init(firstName: "", url: "", lastName: "")
    }
}
