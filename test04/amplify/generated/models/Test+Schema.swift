// swiftlint:disable all
import Amplify
import Foundation

extension Test {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case contents
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let test = Test.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Tests"
    
    model.fields(
      .id(),
      .field(test.contents, is: .optional, ofType: .string),
      .field(test.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(test.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}