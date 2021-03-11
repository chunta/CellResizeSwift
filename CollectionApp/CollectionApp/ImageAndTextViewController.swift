//
//  ImageAndTextViewController.swift
//  CollectionApp
//
//  Created by chunta on 2021/3/10.
//

import UIKit

class ImageAndTextViewController: UIViewController,
                                  UICollectionViewDelegate,
                                  UICollectionViewDataSource,
                                  HModelPresenterDelegate,
                                  ImageTextCellDelegate {

    var collectionView: UICollectionView!
    var hmodelPresenter: HModelPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let collectionViewLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100),
                                               collectionViewLayout: collectionViewLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.borderWidth = 1
        collectionView.backgroundColor = UIColor.yellow
        self.view.addSubview(collectionView)
        
        collectionView.register(UINib.init(nibName: ImageTextCell.xibName(), bundle: nil),
                                forCellWithReuseIdentifier: ImageTextCell.xibName())
        
        hmodelPresenter = HModelPresenter.init()
        hmodelPresenter.delegate = self
        hmodelPresenter.requestData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.frame = self.view.bounds
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return hmodelPresenter.modelCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:ImageTextCell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageTextCell.xibName(), for: indexPath) as! ImageTextCell
        let cellData:CellRow = hmodelPresenter.modelDataAt(index: indexPath.row)
        cell.delegate = self
        cell.setWidth(width: UIScreen.main.bounds.size.width)
        cell.setCellData(dic: cellData)
        return cell
    }
    
    func didRequestCompleted() {
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func didCellImageLoadedAt(cell: ImageTextCell) {

        if (collectionView.visibleCells.count > 0) {
            
            let indexOfCell:Int? = collectionView.visibleCells.firstIndex(where: {$0 == cell})
            if (indexOfCell != nil) {
                collectionView.reloadData()
                collectionView.collectionViewLayout.invalidateLayout()
            }
        }
    }
    
    
}
