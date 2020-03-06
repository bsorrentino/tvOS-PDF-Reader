//
//  ContentView.swift
//  Samples
//
//  Created by softphone on 01/03/2020.
//  Copyright © 2020 mytrus. All rights reserved.
//

import SwiftUI
import PDFReader
struct ContentView: View {
    
    var document:PDFDocument
    
    var body: some View {
        
        HStack {
            PDFThumbnailCollectionView( document:self.document )
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                        PDFSinglePageView( document:self.document,
                                 pageNumber:1,
                                 frame:CGRect( origin: CGPoint(x: 0,y: 0), size: geometry.size ) )
                        Spacer()
                    }
            }
        }
    }
        
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(document: <#PDFDocument#>)
//    }
//}


