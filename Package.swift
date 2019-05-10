// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "HTTPCodable",
    products: [
        .library(
            name: "HTTPCodable",
            targets: ["HTTPCodable"]),
    ],
    dependencies: [
        .package(url: "https://github.com/formbound/Futures.git", from: "1.4.0")
    ],
    targets: [
        .target(
            name: "HTTPCodable",
            dependencies: ["Futures"]),
        .testTarget(
            name: "HTTPCodableTests",
            dependencies: ["HTTPCodable"]),
    ]
)
