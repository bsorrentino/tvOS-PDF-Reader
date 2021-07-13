//
//  ContentView.swift
//  Example
//
//  Created by Bartolomeo Sorrentino on 10/03/2020.
//  Copyright © 2020 mytrus. All rights reserved.
//

import SwiftUI
import PDFReader

struct ContentView: View {
    enum Tab { case  PDFReader, OHPDFImage }
    
    @State var selection : Tab = .PDFReader
    
    let document1 = PDFDocument.createFormBundle(resource: "apple")
    let document2 = OHPDF.Document.createFormBundle(resource: "apple")
    
    var body: some View {

        NavigationView {
            
            TabView(selection: $selection ) {
                
                PDFReaderContentView( document:document1 ).tabItem {
                    Text("PDFReader impl.")
                }
                .tag(Tab.PDFReader)
                
                OHPDFImageContentView( document:document2 ).tabItem {
                        Text("OHPDFImage impl.")
                }
                .tag(Tab.OHPDFImage)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            ContentView( selection: .PDFReader )
            ContentView( selection: .OHPDFImage )
        }
    }
}
