// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "SwiftKueryMock",
    targets: [
        Target(name: "SwiftKueryMock"),
        Target(name: "SwiftKueryMockTests")
    ],
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/Swift-Kuery.git", majorVersion: 0, minor: 13)
    ]
)
