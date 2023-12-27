// swift-tools-version:5.7
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
        .package(url: "https://github.com/fredyshox/PageView.git", .upToNextMajor(from: "1.5.0")),
        .package(url: "https://github.com/siteline/swiftui-introspect", from: "1.0.0"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.0.0"),
        .package(url: "https://github.com/yeatse/KingfisherWebP.git", from: "1.0.0"),
        .package(url: "https://github.com/NuPlay/ExpandableText", from: "1.2.0"),
        .package(url: "https://github.com/SvenTiigi/YouTubePlayerKit.git", from: "1.5.0"),
        .package(url: "https://github.com/danielsaidi/ScrollKit.git", from: "0.4.0"),
        .package(url: "https://github.com/optonaut/ActiveLabel.swift.git", from: "1.1.5"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MobileDesign",
            dependencies: [
                "PageView",
                "Kingfisher",
                "KingfisherWebP",
                "ExpandableText",
                "YouTubePlayerKit",
                "ScrollKit",
                .product(name: "ActiveLabel", package: "ActiveLabel.swift"),
                .product(name: "SwiftUIIntrospect", package: "swiftui-introspect")
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
            exclude: [
                "ReelTests/__Snapshots__",
                "ReelTests/__Snapshots__/ReelPagerTest",
                "FontsSnapshotTests/__Snapshots__",
                "ColorPaletteTests/__Snapshots__",
                "ChipGroupTest/__Snapshots__",
                "CardViewTests/__Snapshots__"
            ]
        )
    ]
)
