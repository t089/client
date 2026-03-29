//
// Copyright 2020 Swiftkube Project
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

// MARK: - CoreV1API

public protocol CoreV1API: Sendable {

	var bindings: NamespacedGenericKubernetesClient<SwiftkubeModel.core.v1.Binding> { get }
	var componentStatuses: ClusterScopedGenericKubernetesClient<SwiftkubeModel.core.v1.ComponentStatus> { get }
	var configMaps: NamespacedGenericKubernetesClient<SwiftkubeModel.core.v1.ConfigMap> { get }
	var endpoints: NamespacedGenericKubernetesClient<SwiftkubeModel.core.v1.Endpoints> { get }
	var events: NamespacedGenericKubernetesClient<SwiftkubeModel.core.v1.Event> { get }
	var limitRanges: NamespacedGenericKubernetesClient<SwiftkubeModel.core.v1.LimitRange> { get }
	var namespaces: ClusterScopedGenericKubernetesClient<SwiftkubeModel.core.v1.Namespace> { get }
	var nodes: ClusterScopedGenericKubernetesClient<SwiftkubeModel.core.v1.Node> { get }
	var persistentVolumes: ClusterScopedGenericKubernetesClient<SwiftkubeModel.core.v1.PersistentVolume> { get }
	var persistentVolumeClaims: NamespacedGenericKubernetesClient<SwiftkubeModel.core.v1.PersistentVolumeClaim> { get }
	var pods: NamespacedGenericKubernetesClient<SwiftkubeModel.core.v1.Pod> { get }
	var podTemplates: NamespacedGenericKubernetesClient<SwiftkubeModel.core.v1.PodTemplate> { get }
	var replicationControllers: NamespacedGenericKubernetesClient<SwiftkubeModel.core.v1.ReplicationController> { get }
	var resourceQuotas: NamespacedGenericKubernetesClient<SwiftkubeModel.core.v1.ResourceQuota> { get }
	var secrets: NamespacedGenericKubernetesClient<SwiftkubeModel.core.v1.Secret> { get }
	var services: NamespacedGenericKubernetesClient<SwiftkubeModel.core.v1.Service> { get }
	var serviceAccounts: NamespacedGenericKubernetesClient<SwiftkubeModel.core.v1.ServiceAccount> { get }
}

/// DSL for `core.v1` API Group
public extension KubernetesClient {

	final class CoreV1: CoreV1API {
		private let client: KubernetesClient

		internal init(_ client: KubernetesClient) {
			self.client = client
		}

		public var bindings: NamespacedGenericKubernetesClient<SwiftkubeModel.core.v1.Binding> {
			client.namespaceScoped(for: SwiftkubeModel.core.v1.Binding.self)
		}
		public var componentStatuses: ClusterScopedGenericKubernetesClient<SwiftkubeModel.core.v1.ComponentStatus> {
			client.clusterScoped(for: SwiftkubeModel.core.v1.ComponentStatus.self)
		}
		public var configMaps: NamespacedGenericKubernetesClient<SwiftkubeModel.core.v1.ConfigMap> {
			client.namespaceScoped(for: SwiftkubeModel.core.v1.ConfigMap.self)
		}
		public var endpoints: NamespacedGenericKubernetesClient<SwiftkubeModel.core.v1.Endpoints> {
			client.namespaceScoped(for: SwiftkubeModel.core.v1.Endpoints.self)
		}
		public var events: NamespacedGenericKubernetesClient<SwiftkubeModel.core.v1.Event> {
			client.namespaceScoped(for: SwiftkubeModel.core.v1.Event.self)
		}
		public var limitRanges: NamespacedGenericKubernetesClient<SwiftkubeModel.core.v1.LimitRange> {
			client.namespaceScoped(for: SwiftkubeModel.core.v1.LimitRange.self)
		}
		public var namespaces: ClusterScopedGenericKubernetesClient<SwiftkubeModel.core.v1.Namespace> {
			client.clusterScoped(for: SwiftkubeModel.core.v1.Namespace.self)
		}
		public var nodes: ClusterScopedGenericKubernetesClient<SwiftkubeModel.core.v1.Node> {
			client.clusterScoped(for: SwiftkubeModel.core.v1.Node.self)
		}
		public var persistentVolumes: ClusterScopedGenericKubernetesClient<SwiftkubeModel.core.v1.PersistentVolume> {
			client.clusterScoped(for: SwiftkubeModel.core.v1.PersistentVolume.self)
		}
		public var persistentVolumeClaims: NamespacedGenericKubernetesClient<SwiftkubeModel.core.v1.PersistentVolumeClaim> {
			client.namespaceScoped(for: SwiftkubeModel.core.v1.PersistentVolumeClaim.self)
		}
		public var pods: NamespacedGenericKubernetesClient<SwiftkubeModel.core.v1.Pod> {
			client.namespaceScoped(for: SwiftkubeModel.core.v1.Pod.self)
		}
		public var podTemplates: NamespacedGenericKubernetesClient<SwiftkubeModel.core.v1.PodTemplate> {
			client.namespaceScoped(for: SwiftkubeModel.core.v1.PodTemplate.self)
		}
		public var replicationControllers: NamespacedGenericKubernetesClient<SwiftkubeModel.core.v1.ReplicationController> {
			client.namespaceScoped(for: SwiftkubeModel.core.v1.ReplicationController.self)
		}
		public var resourceQuotas: NamespacedGenericKubernetesClient<SwiftkubeModel.core.v1.ResourceQuota> {
			client.namespaceScoped(for: SwiftkubeModel.core.v1.ResourceQuota.self)
		}
		public var secrets: NamespacedGenericKubernetesClient<SwiftkubeModel.core.v1.Secret> {
			client.namespaceScoped(for: SwiftkubeModel.core.v1.Secret.self)
		}
		public var services: NamespacedGenericKubernetesClient<SwiftkubeModel.core.v1.Service> {
			client.namespaceScoped(for: SwiftkubeModel.core.v1.Service.self)
		}
		public var serviceAccounts: NamespacedGenericKubernetesClient<SwiftkubeModel.core.v1.ServiceAccount> {
			client.namespaceScoped(for: SwiftkubeModel.core.v1.ServiceAccount.self)
		}
	}

	var coreV1: CoreV1API {
		CoreV1(self)
	}
}
