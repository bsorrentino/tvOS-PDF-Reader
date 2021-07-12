//
//  PDFReader+OHPDFPage.swift
//  Example
//
//  Created by Bartolomeo Sorrentino on 10/03/2020.
//  Copyright © 2020 mytrus. All rights reserved.
//

import UIKit
import OHPDFImage

public class OHPDF {

    public class Document {
        
        internal var document:OHPDFDocument
        
        var pageCount:Int {
            document.pagesCount
        }

        var allPageNumbers:Array<Int> {
            ( pageCount == 0 ) ? Array() : Array(1...pageCount)
        }
        
        init( fromUrl url:URL ) {
            self.document = OHPDFDocument(url: url)
        }

        init( fromData data:Data ) {
            self.document = OHPDFDocument(data: data)
        }
        
        internal func getVectorImage( at index:Int  ) -> OHVectorImage? {
            if( index <= 0 || index > pageCount ) {
                return nil
            }
            let page = document.page(at: index)
            
            let vImage = OHVectorImage(pdfPage: page)

            return vImage
        }
        
        func getPageImage( at index:Int, withSize size:CGSize ) -> UIImage? {
            guard let vImage = getVectorImage( at:index ) else {
                return nil
            }
            
            return vImage.render(at: size)
        }

        func getPageImage( at index:Int, withSizeThatFits size:CGSize ) -> UIImage? {
            guard let vImage = getVectorImage( at:index ) else {
                return nil
            }
            
            return vImage.render(atSizeThatFits: size)
        }
    }

}

extension OHPDF.Document {
    
    public static func createFormBundle( resource:String ) ->  OHPDF.Document {
        let documentURL = Bundle.main.url(forResource: resource, withExtension: "pdf")
        let document =  OHPDF.Document(fromUrl: documentURL!)
        return document
    }
}

