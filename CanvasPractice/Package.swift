// swift-tools-version: 5.10

import PackageDescription

let package = Package(
  name: "CanvasPractice",
  platforms: [.iOS(.v17)],
  products: [
    .library(
      name: "CanvasClockView",
      targets: ["CanvasClockView"]
    ),
  ],
  targets: [
    .target(name: "CanvasClockView"),
  ]
)
