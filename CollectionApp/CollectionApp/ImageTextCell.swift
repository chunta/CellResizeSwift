//
//  ImageTextCell.swift
//  CollectionApp
//
//  Created by chunta on 2021/3/10.
//

import UIKit

protocol ImageTextCellDelegate {
    func didCellImageLoadedAt(cell:ImageTextCell)
}

class ImageTextCell: UICollectionViewCell {

    @IBOutlet var profileImage:UIImageView!
    @IBOutlet var summaryText:UILabel!
    @IBOutlet var helpContentWidthCts:NSLayoutConstraint!
    @IBOutlet var helpContentHeightCts:NSLayoutConstraint!
        
    @IBOutlet var imageWidthCts:NSLayoutConstraint!
    @IBOutlet var imageHeightCts:NSLayoutConstraint!
    
    var delegate:ImageTextCellDelegate?
    var ratio:CGFloat = 1
    var cellWidth:CGFloat = 100
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        helpContentWidthCts.isActive = false
        helpContentHeightCts.isActive = false
        imageWidthCts.isActive = false
        imageHeightCts.isActive = false
    }

    func setWidth(width:CGFloat) {
        
        cellWidth = width
        
        helpContentWidthCts.constant = width
        
        // Total height
        let imageH:CGFloat = (width / 2) * ratio
        summaryText.sizeToFit()
        let textH:CGFloat = summaryText.bounds.size.height
        helpContentHeightCts.constant = imageH + textH
        
        imageWidthCts.constant = width / 2
        imageHeightCts.constant = imageH
        
        helpContentWidthCts.isActive = true
        helpContentHeightCts.isActive = true
        imageWidthCts.isActive = true
        imageHeightCts.isActive = true
    }
    
    func setCellData(dic:CellRow) {
        
        let lastNameString:String = dic.lastName
        summaryText.text = lastNameString
        
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
            
            self.setWidth(width: self.cellWidth)
            
            if let theDelegate = self.delegate {
                theDelegate.didCellImageLoadedAt(cell: self)
            }
        }
    }
    
    class func xibName()->String {
        return "ImageTextCell"
    }
}
