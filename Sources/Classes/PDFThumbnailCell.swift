//
//  PDFThumbnailCell.swift
//  PDFReader
//
//  Created by Ricardo Nunez on 7/9/16.
//  Copyright © 2016 AK. All rights reserved.
//

import UIKit

/// An individual thumbnail in the collection view
internal final class PDFThumbnailCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageView = UIImageView()
        self.imageView?.frame.size = frame.size
        self.imageView?.contentMode = .scaleAspectFill
        self.addSubview(self.imageView!)
     }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
