// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "security",
    platforms: [.macOS(.v12)],
    dependencies: [
        .package(url: "https://github.com/apple/swift-crypto.git", from: "3.0.0")
    ],
    targets: [
        .executableTarget(
            name: "example",
            dependencies: [
                .product(name: "Crypto", package: "swift-crypto"),
                .product(name: "_CryptoExtras", package: "swift-crypto")
            ],
            path: ".",
            sources: ["example.swift"]
        ),
        .executableTarget(
            name: "exercise_1",
            dependencies: [
                .product(name: "Crypto", package: "swift-crypto"),
                .product(name: "_CryptoExtras", package: "swift-crypto")
            ],
            path: "solutions",
            sources: ["exercise_1.swift"]
        )
    ]
)
