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
    
    var size = CGSize(width: 200, height: 400)
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading, spacing: 25 ) {
                    
                ForEach( document.allPageNumbers, id: \.self ) { pageNumber in

                    VStack {
                        Image( uiImage: self.document.pdfPageImage(at: pageNumber)! )
                            .resizable()
                            .frame(width: self.size.width,
                                   height: self.size.height,
                                   alignment: .center)
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


struct PDFReaderContentView: View {
    
    var document:PDFDocument
    
    @State var pageSelected: Int = 1
    
    var body: some View {
        
        HStack {
            
            PDFThumbnailView( document:self.document, pageSelected:self.$pageSelected,
                size:CGSize(width: 300, height: 400))
            
            if self.pageSelected > 0  {
                Spacer()
                
                PDFDocumentView(
                    document:self.document,
                    pageSelected:self.$pageSelected )

                Spacer()
            }
        }.background(Color.gray)
    }
}


struct PDFReaderContentView_Previews: PreviewProvider {
    static var previews: some View {
        PDFReaderContentView(document: PDFDocument.createFormBundle(resource: "apple"))
    }
}
