//
//  PDFDocumentObject.swift
//  Samples
//
//  Created by softphone on 12/07/21.
//  Copyright © 2021 mytrus. All rights reserved.
//

import Foundation
import UIKit
class PDFDocumentObject : ObservableObject {
    
    var pages = [UIImage]()
    var doc:PDFDocument?
    
    public init(url: URL, password: String? = nil) {
    
        doc = PDFDocument(url: url)
        
        // doc?.loadPages()
        
        doc?.allPageImages { images in
            self.pages = images
        }
    }
}

