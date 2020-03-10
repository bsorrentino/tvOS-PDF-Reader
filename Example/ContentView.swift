//
//  ContentView.swift
//  Samples
//
//  Created by softphone on 01/03/2020.
//  Copyright © 2020 mytrus. All rights reserved.
//

import SwiftUI
import PDFReader


struct PDFThumbnailView : View {
    
    var document:PDFDocument
    
    @Binding var pageSelected:Int
    
    var body: some View {
        ScrollView {
            
            VStack {
                    
                ForEach( document.allPageNumbers, id: \.self ) { pageNumber in

                    VStack {
                        Image( uiImage: self.document.pdfPageImage(at: pageNumber)! )
                        Text( "page \(pageNumber)" )
                    }.background(Color.white)
                    .focusable(true) { changed in
                        if( changed ) {
                            self.pageSelected = pageNumber
                        }
                    }
                    
                }
            }
        }
        
    }
}


struct ContentView: View {
    
    var document:PDFDocument
    
    @State var pageSelected: Int = 1
    
    var body: some View {
        
        //GeometryReader { geometry in
            HStack {
                PDFThumbnailView( document:self.document, pageSelected:self.$pageSelected)
                if self.pageSelected > 0  {
                    Spacer()
                    
                    PDFDocumentView(
                        document:self.document,
                        pageSelected:self.$pageSelected )
                        //frame:CGRect( origin:CGPoint(x:0, y:0), size:geometry.size  ) )

                }
            }.background(Color.gray)

        //}
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(document: <#PDFDocument#>)
//    }
//}


