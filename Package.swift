// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MobileDesign",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "MobileDesign",
            targets: ["MobileDesign"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.12.0"),
        .package(url: "https://github.com/fermoya/SwiftUIPager", from: "2.5.0"),
        .package(url: "https://github.com/siteline/swiftui-introspect", from: "0.12.0")

    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MobileDesign",
            dependencies: [
                "SwiftUIPager",

            ],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "MobileDesignTests",
            dependencies: [
                "MobileDesign",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ],
            exclude: ["__Snapshots__"]
        )
    ]
)
