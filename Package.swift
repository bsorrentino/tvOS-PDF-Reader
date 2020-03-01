// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "PDFReader",
    platforms: [
      tvOS("13.2")
    ],
    targets: [
        .target(
            name: "PDFReader",
            path: ".",
            sources: ["Sources/Classes"])
    ])
