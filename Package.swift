// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "PetitService",
    products: [
        .library(name: "PetitService", targets: ["PetitService"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.6"),
        .package(url: "https://github.com/LiveUI/XMLCoding.git", from: "0.1.1")
    ],
    targets: [
        .target(name: "PetitService", dependencies: [
            "XMLCoding",
            "Vapor"
        ]),
        .testTarget(name: "PetitServiceTests", dependencies: ["PetitService"])
    ]
)
