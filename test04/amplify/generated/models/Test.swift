// swiftlint:disable all
import Amplify
import Foundation

public struct Test: Model {
  public let id: String
  public var contents: String?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      contents: String? = nil) {
    self.init(id: id,
      contents: contents,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      contents: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.contents = contents
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}