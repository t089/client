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
		.package(url: "https://github.com/apple/swift-metrics.git", .upToNextMajor(from: "2.9.0")),
		.package(url: "https://github.com/apple/swift-nio", .upToNextMajor(from: "2.86.2")),
		.package(url: "https://github.com/t089/Yams.git", branch: "foundation-essentials"),
		.package(url: "https://github.com/t089/model.git", branch: "foundation-essentials"),
		.package(url: "https://github.com/swift-server/async-http-client.git", .upToNextMajor(from: "1.29.1")),
		.package(url: "https://github.com/swiftlang/swift-subprocess.git", .upToNextMajor(from: "0.2.1")),
		.package(url: "https://github.com/apple/swift-algorithms.git", .upToNextMajor(from: "1.0.0")),
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
				.product(name: "Algorithms", package: "swift-algorithms"),
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
