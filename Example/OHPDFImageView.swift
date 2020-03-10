//
//  OHPDFReaderView.swift
//  Example
//
//  Created by Bartolomeo Sorrentino on 10/03/2020.
//  Copyright © 2020 mytrus. All rights reserved.
//

import SwiftUI


struct OHPDFImageThumbnailView : View {
    
    var document:OHPDF.Document
    
    @Binding var pageSelected:Int
    
    var size = CGSize(width: 200, height: 400)
    
    func imageFromPage( at index:Int ) -> some View {
        
        guard let image = self.document.getPageImage(at: index, withSizeThatFits: size ) else {
            return AnyView(
                        Image("xmark")
                            .resizable()
                            .frame(width: size.width, height: size.height, alignment: .center))
        }

        return AnyView(
            Image( uiImage: image ))
        
    }


    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading, spacing: 25 ) {
                    
                ForEach( document.allPageNumbers, id: \.self ) { pageNumber in

                    VStack {
                        self.imageFromPage( at: pageNumber )
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


struct OHPDFImageContentView: View {
    
    var document:OHPDF.Document
    
    @State var pageSelected: Int = 1
    
    func imageFromPage( at index:Int, size:CGSize ) -> some View {
        
        guard let image = self.document.getPageImage(at: index, withSizeThatFits: size ) else {
            return AnyView(
                        Image("xmark")
                            .resizable()
                            .frame(width: size.width, height: size.height, alignment: .center))
        }

        return AnyView(
            Image( uiImage: image ))
        
    }

    var body: some View {
        
        GeometryReader { geometry in
            HStack {
                OHPDFImageThumbnailView(
                    document:self.document,
                    pageSelected:self.$pageSelected,
                    size:CGSize(width: 300, height: 400))
                if self.pageSelected > 0  {
                    Spacer()
                    self.imageFromPage( at:self.pageSelected, size:geometry.size)
                    Spacer()
                }
            }.background(Color.gray)

        }
    }
}

struct OHPDFImageContentView_Previews: PreviewProvider {
    static var previews: some View {
        OHPDFImageContentView(document: OHPDF.Document.createFormBundle(resource: "apple"))
    }
}
