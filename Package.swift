// swift-tools-version:5.3

//  Package.swift

import PackageDescription
let package = Package(
    name: "ApplangaSwiftUI",
    products: [
        .library(
            name: "ApplangaSwiftUI",
            targets: ["ApplangaSwiftUIWrapper"])
    ],
    dependencies: [
        .package(name: "Applanga", url: "https://github.com/applanga/sdk-ios", from: "2.0.194")
    ],
    targets: [
        .binaryTarget(name: "ApplangaSwiftUI",
                      path: "ApplangaSwiftUI.xcframework"),
        .target(name: "ApplangaSwiftUIWrapper",
                dependencies: [
                    .product(name: "Applanga", package: "Applanga"),
                    .target(name: "ApplangaSwiftUI")
                ],
                path: "ApplangaSwiftUIWrapper"),
        .target(name: "ApplangaSwiftUITarget",
                dependencies: [
                    .target(name: "ApplangaSwiftUIWrapper")
                ],
                path: "ApplangaSwiftUITarget")
    ]
)
