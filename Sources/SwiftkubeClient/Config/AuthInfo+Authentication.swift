//
// Copyright 2025 Swiftkube Project
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

//
// Copyright 2025 Swiftkube Project
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif
import Logging
import NIOSSL
import Subprocess
#if canImport(System)
import System
#else
import SystemPackage
#endif

public extension AuthInfo {

	func authentication(logger: Logger?) async -> KubernetesClientAuthentication? {
		if let username = username, let password = password {
			return .basicAuth(username: username, password: password)
		}

		if let token = token {
			return .bearer(token: token)
		}

		do {
			if let tokenFile = tokenFile {
				let fileURL = URL(fileURLWithPath: tokenFile)
				let token = try String(contentsOf: fileURL, encoding: .utf8)
				return .bearer(token: token)
			}
		} catch {
			logger?.warning(
				"Error initializing authentication from token file \(String(describing: tokenFile)): \(error)"
			)
		}

		do {
			if let clientCertificateFile = clientCertificate, let clientKeyFile = clientKey {
				let clientCertificate = try NIOSSLCertificate(
					file: clientCertificateFile,
					format: .pem
				)
				let clientKey = try NIOSSLPrivateKey(
					file: clientKeyFile,
					format: .pem
				)
				return .x509(
					clientCertificate: clientCertificate,
					clientKey: clientKey
				)
			}

			if let clientCertificateData = clientCertificateData, let clientKeyData = clientKeyData {
				let clientCertificate = try NIOSSLCertificate(
					bytes: [UInt8](clientCertificateData),
					format: .pem
				)
				let clientKey = try NIOSSLPrivateKey(
					bytes: [UInt8](clientKeyData),
					format: .pem
				)
				return .x509(
					clientCertificate: clientCertificate,
					clientKey: clientKey
				)
			}
		} catch {
			logger?.warning(
				"Error initializing authentication from client certificate: \(error)"
			)
		}

		#if os(Linux) || os(macOS)
			do {
				if let exec {
					let outputData = try await run(
						command: exec.command,
						arguments: exec.args
					)

					let decoder = JSONDecoder()
					decoder.dateDecodingStrategy = .iso8601
					let credential = try decoder.decode(
						ExecCredential.self,
						from: outputData
					)

					return .bearer(token: credential.status.token)
				}
			} catch {
				logger?.warning(
					"Error initializing authentication from exec \(error)"
				)
			}
		#endif

		return nil
	}
}

// MARK: - ExecCredential

// It seems that AWS doesn't implement properly the model for client.authentication.k8s.io/v1beta1
// Acordingly with the doc https://kubernetes.io/docs/reference/config-api/client-authentication.v1beta1/
// ExecCredential.Spec.interactive is required as long as the ones in the Status object.
public struct ExecCredential: Codable {
	let apiVersion: String
	let kind: String
	let spec: Spec
	let status: Status
}

public extension ExecCredential {

	struct Spec: Codable {
		let cluster: Cluster?
		let interactive: Bool?
	}

	struct Status: Codable {
		let expirationTimestamp: Date
		let token: String
		let clientCertificateData: String?
		let clientKeyData: String?
	}
}

#if os(Linux) || os(macOS)
	internal func run(command: String, arguments: [String]? = nil) async throws -> Data {
		let resolveResult = try await Subprocess.run(
			.path("/usr/bin/which"),
			arguments: Arguments([command]),
			output: .string(limit: 1024)
		)
		guard let resolvedPath = resolveResult.standardOutput?
			.trimmingCharacters(in: .whitespacesAndNewlines) else {
			throw SwiftkubeClientError.badRequest("Could not resolve command: \(command)")
		}

		let result = try await Subprocess.run(
			.path(FilePath(resolvedPath)),
			arguments: Arguments(arguments ?? []),
			output: .bytes(limit: 1024 * 1024)
		)
		return Data(result.standardOutput)
	}
#endif
