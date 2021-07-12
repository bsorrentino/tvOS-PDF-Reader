//
//  ContentView.swift
//  Samples
//
//  Created by softphone on 01/03/2020.
//  Copyright © 2020 mytrus. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var doc:PDFDocumentObject
    
    var body: some View {
        Image( uiImage: doc.pages[0] )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
