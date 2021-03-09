//
//  SingleImageViewController.swift
//  CollectionApp
//
//  Created by Rex Chen on 2021/3/9.
//

import UIKit

class SingleImageViewController: UIViewController,
                                 UICollectionViewDelegate,
                                 UICollectionViewDataSource,
                                 UICollectionViewDelegateFlowLayout,
                                 HModelPresenterDelegate,
                                 SingleImageCellDelegate {
    
    var collectionView:UICollectionView!
    var hmodelPresenter:HModelPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout)
        collectionView.layer.borderWidth = 1
        collectionView.backgroundColor = UIColor.yellow
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
                
        collectionView.register(UINib.init(nibName: SingleImageCell.nibName(), bundle: nil),
                                forCellWithReuseIdentifier: SingleImageCell.nibName())
        
        hmodelPresenter = HModelPresenter.init()
        hmodelPresenter.delegate = self
        hmodelPresenter.requestData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.frame = self.view.bounds
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return hmodelPresenter.modelCount()
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:SingleImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: SingleImageCell.nibName(), for: indexPath) as! SingleImageCell
        let dic:[String:Any] = hmodelPresenter.modelDataAt(index: indexPath.row)
        cell.delegate = self
        cell.setData(dic: dic)
        cell.setWidth(width: UIScreen.main.bounds.width)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func didRequestCompleted() {
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func didCellImageLoadedAt(cell: SingleImageCell) {
        
        if (collectionView.visibleCells.count > 0) {
            
            let indexOfCell:Int? = collectionView.visibleCells.firstIndex(where: {$0 == cell})
            if (indexOfCell != nil) {
                collectionView.reloadData()
                collectionView.collectionViewLayout.invalidateLayout()
            }
        }
    }

}
