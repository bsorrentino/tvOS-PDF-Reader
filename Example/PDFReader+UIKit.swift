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
    
    var currentPageIndex:Int = 0{
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
        
        let controller = PDFPageViewController( document: document )
        controller.currentPageIndex = pageSelected
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<PDFDocumentView>) {
    
        uiViewController.currentPageIndex = pageSelected
    }
    
    
    typealias UIViewControllerType = PDFPageViewController
    

    
}

