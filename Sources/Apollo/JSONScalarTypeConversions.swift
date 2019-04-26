//
//  JSONScalarTypeConversions.swift
//  Apollo
//
//  Created by Michael Nisi on 26.04.19.
//  Copyright © 2019 Apollo GraphQL. All rights reserved.
//

import Foundation

extension URL: JSONDecodable, JSONEncodable {
  
  public init(jsonValue value: JSONValue) throws {
    guard let string = value as? String,
      let url = URL(string: string) else {
      throw JSONDecodingError.couldNotConvert(value: value, to: URL.self)
    }

    self = url
  }
  
  public var jsonValue: JSONValue {
    return self.absoluteString
  }
}

public typealias DateTime = Date

@available(OSXApplicationExtension 10.12, *)
private let iso8601DateFormatter = ISO8601DateFormatter()

extension DateTime: JSONDecodable, JSONEncodable {
  
  public init(jsonValue value: JSONValue) throws {
    guard #available(OSXApplicationExtension 10.12, *),
      let string = value as? String,
      let date = iso8601DateFormatter.date(from: string) else {
      throw JSONDecodingError.couldNotConvert(value: value, to: DateTime.self)
    }
    
    self = date
  }
  
  public var jsonValue: JSONValue {
    if #available(OSXApplicationExtension 10.12, *) {
      return iso8601DateFormatter.string(from: self)
    } else {
      return self.description
    }
  }
}
