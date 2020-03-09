//
//  PDFView+UIKit.swift
//  Samples
//
//  Created by Bartolomeo Sorrentino on 06/03/2020.
//  Copyright © 2020 mytrus. All rights reserved.
//

import SwiftUI
import PDFReader

class PDFPageViewController : UIViewController {
    
    var pages = Array<PDFPageView>()
    var document : PDFDocument
    
    var currentPageIndex:Int = 0 {
        didSet {
            if( oldValue == currentPageIndex ) {
                return
            }
            if( oldValue > 0 ) {
                let view = pages[oldValue - 1]
                view.removeFromSuperview()

                print( "remove view at index \(oldValue)" )
            }
            if( currentPageIndex > 0 ) {
                
                if( !pages.indices.contains(currentPageIndex-1) ) {
                    
                    print( "create view at index \(currentPageIndex)" )

                    let view = PDFPageView( frame: self.view.frame,
                                     document: document,
                                     pageNumber: currentPageIndex-1,
                                     backgroundImage: nil,
                                     pageViewDelegate: nil)
                    
                    pages.append( view )
                    self.view.addSubview(view)

                }
                else {
                    print( "reuse view at index \(currentPageIndex)" )

                    let view = pages[currentPageIndex - 1]
                    self.view.addSubview(view)
                }

            }
        }
    }
    
    init( document:PDFDocument ) {
        self.document = document

        super.init(nibName:nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

struct PDFDocumentView : UIViewControllerRepresentable {
    var document : PDFDocument
    @Binding var pageSelected:Int
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<PDFDocumentView>) -> UIViewControllerType {
        PDFPageViewController( document: document )
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<PDFDocumentView>) {
    
        uiViewController.currentPageIndex = pageSelected
    }
    
    
    typealias UIViewControllerType = PDFPageViewController
    

    
}

struct PDFSinglePageView: UIViewRepresentable {
    
    typealias UIViewType = PDFPageView
    
    var document : PDFDocument
    var pageNumber: Int
    var frame: CGRect
    
    /// Creates a `UIView` instance to be presented.
    func makeUIView(context: Context) -> UIViewType {
        
        print( "Binding.makeUIView" )
        return PDFPageView( frame: frame, document: document, pageNumber: pageNumber, backgroundImage: nil, pageViewDelegate: nil)
    }

    /// Updates the presented `UIView` (and coordinator) to the latest
    /// configuration.
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print( "Binding.updateUIView" )
    }

}



struct PDFThumbnailCollectionView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = PDFThumbnailCollectionViewController
    
    var document : PDFDocument
    
    /// Creates a `UIViewController` instance to be presented.
    func makeUIViewController(context: Context) -> UIViewControllerType {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        
        let controller =
            PDFThumbnailCollectionViewController(collectionViewLayout: layout )
        
        controller.document = document
        controller.currentPageIndex = 1
        
        
        return controller
        
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<PDFThumbnailCollectionView>) {
        
    }
    

}
