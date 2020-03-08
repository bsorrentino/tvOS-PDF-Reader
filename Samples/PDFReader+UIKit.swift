//
//  PDFView+UIKit.swift
//  Samples
//
//  Created by Bartolomeo Sorrentino on 06/03/2020.
//  Copyright © 2020 mytrus. All rights reserved.
//

import SwiftUI
import PDFReader


struct PDFSinglePageView: UIViewRepresentable {
    
    typealias UIViewType = PDFPageView
    
    var document : PDFDocument
    var pageNumber: Int
    var frame: CGRect
    
    /// Creates a `UIView` instance to be presented.
    func makeUIView(context: Context) -> UIViewType {
        
        PDFPageView( frame: frame, document: document, pageNumber: pageNumber, backgroundImage: nil, pageViewDelegate: nil)
    }

    /// Updates the presented `UIView` (and coordinator) to the latest
    /// configuration.
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
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
