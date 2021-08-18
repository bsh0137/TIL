// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "8055726d4a624f14d2326f36d06fd432"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: Test.self)
  }
}