// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "SwiftkubeClient",
	platforms: [
		.macOS(.v15),
		.iOS(.v18),
		.tvOS(.v18),
		.watchOS(.v11),
	],
	products: [
		.library(
			name: "SwiftkubeClient",
			targets: ["SwiftkubeClient"]
		),
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-log.git", .upToNextMajor(from: "1.6.4")),
		.package(url: "https://github.com/apple/swift-metrics.git", branch: "main"),
		.package(url: "https://github.com/apple/swift-nio", .upToNextMajor(from: "2.86.2")),
		.package(url: "https://github.com/jpsim/Yams.git", .upToNextMajor(from: "5.4.0")),
		.package(path: "../model"),
		.package(url: "https://github.com/swift-server/async-http-client.git", .upToNextMajor(from: "1.29.1")),
		.package(url: "https://github.com/swiftlang/swift-subprocess.git", .upToNextMajor(from: "0.2.1")),
	],
	targets: [
		.target(
			name: "SwiftkubeClient",
			dependencies: [
				.product(name: "AsyncHTTPClient", package: "async-http-client"),
				.product(name: "Logging", package: "swift-log"),
				.product(name: "Metrics", package: "swift-metrics"),
				.product(name: "NIO", package: "swift-nio"),
				.product(name: "NIOConcurrencyHelpers", package: "swift-nio"),
				.product(name: "SwiftkubeModel", package: "model"),
				.product(name: "Subprocess", package: "swift-subprocess"),
				.product(name: "Yams", package: "Yams"),
			]
		),
		.testTarget(
			name: "SwiftkubeClientTests",
			dependencies: [
				"SwiftkubeClient",
			]
		),
	]
)
