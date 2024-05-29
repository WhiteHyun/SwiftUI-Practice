// swift-tools-version: 5.10

import PackageDescription

let package = Package(
  name: "Personal",
  platforms: [.iOS(.v17)],
  products: [
    .library(
      name: "PersonalDynamicPropertyPracticeView",
      targets: ["PersonalDynamicPropertyPracticeView"]
    ),
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .target(name: "PersonalDynamicPropertyPracticeView", resources: [.process("Resources")]),
  ]
)
