// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "Swift-Kuery-Mock",
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/Swift-Kuery.git", majorVersion: 0, minor: 13)
    ]
)
