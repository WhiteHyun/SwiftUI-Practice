// swift-tools-version: 5.10

import PackageDescription

let package = Package(
  name: "WWDC",
  platforms: [.iOS(.v17)],
  products: [
    .library(
      name: "WWDC-Data-Essentials-in-SwiftUI",
      targets: ["WWDC-Data-Essentials-in-SwiftUI"]
    ),
    .library(
      name: "WWDC-Explore-Structured-Concurrency-in-Swift",
      targets: ["WWDC-Explore-Structured-Concurrency-in-Swift"]
    ),
  ],
  targets: [
    .target(name: "WWDC-Data-Essentials-in-SwiftUI"),
    .target(name: "WWDC-Explore-Structured-Concurrency-in-Swift"),
  ]
)
