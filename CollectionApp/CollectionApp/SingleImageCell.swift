//
//  SingleImageCell.swift
//  CollectionApp
//
//  Created by Rex Chen on 2021/3/9.
//

import UIKit
import SDWebImage

protocol SingleImageCellDelegate {
    func didCellImageLoadedAt(cell:SingleImageCell)
}

class SingleImageCell: UICollectionViewCell {
    
    @IBOutlet var profileImage:UIImageView!
    @IBOutlet var widthCts:NSLayoutConstraint!
    @IBOutlet var heightCts:NSLayoutConstraint!
    
    var delegate:SingleImageCellDelegate?
    var ratio:CGFloat = 1.0
    
    class func nibName()->String {
        
        return "SingleImageCell"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        widthCts.isActive = false
        heightCts.isActive = false
    }
    
    func setWidth(width:CGFloat) {
        
        widthCts.constant = width
        widthCts.isActive = true
        heightCts.constant = width / ratio
        heightCts.isActive = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.orange
    }
    
    func setData(dic:CellRow) {
        
        let urlString:String = dic.url
        let url:URL? = URL(string: urlString)
        profileImage.contentMode = .scaleAspectFit
        profileImage.layer.borderWidth = 1 
        profileImage.sd_setImage(with: url ?? nil,
                                 placeholderImage: UIImage(named: "PlaceHolder"),
                                 options: .highPriority) { (image, error, cacheType, url) in
            
            self.ratio = 1.0
            if let theImage = image {
                self.ratio = theImage.size.width / theImage.size.height
            }
            if let theDelegate = self.delegate {
                theDelegate.didCellImageLoadedAt(cell: self)
            }
        }
    }
    
}
