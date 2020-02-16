// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "PDFReader",
    
    targets: [
        .target(
            name: "PDFReader",
            path: ".",
            sources: ["Sources/Classes"])
    ])
