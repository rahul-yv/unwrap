// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "databases",
    targets: [
        .systemLibrary(name: "CSQLite", pkgConfig: "sqlite3"),
        .executableTarget(name: "example", dependencies: ["CSQLite"]),
        .executableTarget(name: "exercise_1", dependencies: ["CSQLite"])
    ]
)
