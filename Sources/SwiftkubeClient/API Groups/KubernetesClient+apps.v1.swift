//
// Copyright 2020-2026 Swiftkube Project
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
import SwiftkubeModel

// MARK: - AppsV1API

public protocol AppsV1API: Sendable {

	var controllerRevisions: NamespacedGenericKubernetesClient<SwiftkubeModel.apps.v1.ControllerRevision> { get }
	var daemonSets: NamespacedGenericKubernetesClient<SwiftkubeModel.apps.v1.DaemonSet> { get }
	var deployments: NamespacedGenericKubernetesClient<SwiftkubeModel.apps.v1.Deployment> { get }
	var replicaSets: NamespacedGenericKubernetesClient<SwiftkubeModel.apps.v1.ReplicaSet> { get }
	var statefulSets: NamespacedGenericKubernetesClient<SwiftkubeModel.apps.v1.StatefulSet> { get }
}

/// DSL for `apps.v1` API Group
public extension KubernetesClient {

	final class AppsV1: AppsV1API {
		private let client: KubernetesClient

		internal init(_ client: KubernetesClient) {
			self.client = client
		}

		public var controllerRevisions: NamespacedGenericKubernetesClient<SwiftkubeModel.apps.v1.ControllerRevision> {
			client.namespaceScoped(for: SwiftkubeModel.apps.v1.ControllerRevision.self)
		}
		public var daemonSets: NamespacedGenericKubernetesClient<SwiftkubeModel.apps.v1.DaemonSet> {
			client.namespaceScoped(for: SwiftkubeModel.apps.v1.DaemonSet.self)
		}
		public var deployments: NamespacedGenericKubernetesClient<SwiftkubeModel.apps.v1.Deployment> {
			client.namespaceScoped(for: SwiftkubeModel.apps.v1.Deployment.self)
		}
		public var replicaSets: NamespacedGenericKubernetesClient<SwiftkubeModel.apps.v1.ReplicaSet> {
			client.namespaceScoped(for: SwiftkubeModel.apps.v1.ReplicaSet.self)
		}
		public var statefulSets: NamespacedGenericKubernetesClient<SwiftkubeModel.apps.v1.StatefulSet> {
			client.namespaceScoped(for: SwiftkubeModel.apps.v1.StatefulSet.self)
		}
	}

	var appsV1: AppsV1API {
		AppsV1(self)
	}
}
