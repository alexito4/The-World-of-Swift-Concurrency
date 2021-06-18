// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "SwiftConcurrency",
    dependencies: [],
    targets: [
        .executableTarget(
            name: "SwiftConcurrency",
            dependencies: [],
            resources: [
                .copy("Resources/set4-en_us.json")
            ],
            swiftSettings: [
                .unsafeFlags(["-Xfrontend", "-enable-experimental-concurrency"]),
                .unsafeFlags(["-Xfrontend", "-disable-availability-checking"])
            ]
        ),
        .testTarget(
            name: "SwiftConcurrencyTests",
            dependencies: ["SwiftConcurrency"]
        ),
    ]
)
