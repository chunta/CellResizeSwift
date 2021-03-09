//
//  ViewController.swift
//  CollectionApp
//
//  Created by Rex Chen on 2021/3/9.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onImageCollectionView() {

        self.navigationController?.pushViewController(SingleImageViewController.init(), animated: true)
    }
    
    @IBAction func onImageTextCollectionView() {
        
    }
}

