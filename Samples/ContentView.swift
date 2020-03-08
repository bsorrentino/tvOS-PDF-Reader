//
//  ContentView.swift
//  Samples
//
//  Created by softphone on 01/03/2020.
//  Copyright © 2020 mytrus. All rights reserved.
//

import SwiftUI
import PDFReader


class ObservablePDFDocument : ObservableObject {

    var document:PDFDocument
    
    var pageNumbers:Array<Int>
    
    init( fromBundleResource resource:String ) {
        self.document = PDFDocument.createFormBundle(resource: "apple")
        
        self.pageNumbers = Array( 1...document.pageCount )
    }
    
    
}

struct ContentView: View {
    
    var document:PDFDocument
    
    @State var focused: Bool = false
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                
                VStack {
                        
                    ForEach( document.allPageImages, id: \.self ) { pageImage in

                        NavigationLink(destination: EmptyView()) {
                            VStack {
                                Text( "image" )
                                Image( uiImage: pageImage )
                            }
                        }
                        
                    }
                }
//                .focusable(true, onFocusChange:{ (changed) in
//                        self.focused = changed
//                    })
                }

            }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(document: <#PDFDocument#>)
//    }
//}


