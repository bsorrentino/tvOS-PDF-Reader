//
//  PDFThumbnailCollectionViewController.swift
//  PDFReader
//
//  Created by Ricardo Nunez on 7/9/16.
//  Copyright © 2016 AK. All rights reserved.
//

import UIKit

/// Delegate that is informed of important interaction events with the current thumbnail collection view
public protocol PDFThumbnailControllerDelegate: AnyObject {
    /// User has tapped on thumbnail
    func didSelectIndexPath(_ indexPath: IndexPath)
}

/// Bottom collection of thumbnails that the user can interact with
//internal
public
final class PDFThumbnailCollectionViewController: UICollectionViewController {

     /// Preferred size of each cell
    public var cellSize = CGSize(width: 100, height: 200)

    /// Current document being displayed
    public var document: PDFDocument!

    /// Current page index being displayed
    public var currentPageIndex: Int = 0 {
        didSet {
            guard let collectionView = collectionView else { return }
            guard let pageImages = pageImages else { return }
            guard pageImages.count > 0 else { return }
            let curentPageIndexPath = IndexPath(row: currentPageIndex, section: 0)
            if !collectionView.indexPathsForVisibleItems.contains(curentPageIndexPath) {
                collectionView.scrollToItem(at: curentPageIndexPath, at: .centeredHorizontally, animated: true)
            }
            collectionView.reloadData()
        }
    }

    /// Calls actions when certain cells have been interacted with
    weak var delegate: PDFThumbnailControllerDelegate?

    /// Small thumbnail image representations of the pdf pages
    private var pageImages: [UIImage]? {
        didSet {
            collectionView?.reloadData()
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(PDFThumbnailCell.self, forCellWithReuseIdentifier: "Cell")

        DispatchQueue.global(qos: .background).async {
            self.pageImages = self.document.allPageImages
        }
    }

    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageImages?.count ?? 0
    }

    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PDFThumbnailCell

        cell.imageView?.image = pageImages?[indexPath.row]
        cell.alpha = currentPageIndex == indexPath.row ? 1 : 0.2

        return cell
    }

    @objc func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return cellSize
    }

    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectIndexPath(indexPath)
    }
}
