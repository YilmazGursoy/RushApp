//  This file was automatically generated and should not be edited.

import AWSAppSync

public final class AddCommentMutation: GraphQLMutation {
  public static let operationString =
    "mutation AddComment($baseId: ID!, $createdAt: String!, $feedDate: String, $message: String!, $senderUserId: String!, $senderUserName: String!) {\n  addComment(baseId: $baseId, createdAt: $createdAt, feedDate: $feedDate, message: $message, senderUserId: $senderUserId, senderUserName: $senderUserName) {\n    __typename\n    baseId\n    commentId\n    createdAt\n    message\n    senderUserId\n    feedDate\n    senderUserName\n  }\n}"

  public var baseId: GraphQLID
  public var createdAt: String
  public var feedDate: String?
  public var message: String
  public var senderUserId: String
  public var senderUserName: String

  public init(baseId: GraphQLID, createdAt: String, feedDate: String? = nil, message: String, senderUserId: String, senderUserName: String) {
    self.baseId = baseId
    self.createdAt = createdAt
    self.feedDate = feedDate
    self.message = message
    self.senderUserId = senderUserId
    self.senderUserName = senderUserName
  }

  public var variables: GraphQLMap? {
    return ["baseId": baseId, "createdAt": createdAt, "feedDate": feedDate, "message": message, "senderUserId": senderUserId, "senderUserName": senderUserName]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("addComment", arguments: ["baseId": GraphQLVariable("baseId"), "createdAt": GraphQLVariable("createdAt"), "feedDate": GraphQLVariable("feedDate"), "message": GraphQLVariable("message"), "senderUserId": GraphQLVariable("senderUserId"), "senderUserName": GraphQLVariable("senderUserName")], type: .object(AddComment.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(addComment: AddComment? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "addComment": addComment.flatMap { $0.snapshot }])
    }

    public var addComment: AddComment? {
      get {
        return (snapshot["addComment"] as? Snapshot).flatMap { AddComment(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "addComment")
      }
    }

    public struct AddComment: GraphQLSelectionSet {
      public static let possibleTypes = ["Comment"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("baseId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("commentId", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("message", type: .nonNull(.scalar(String.self))),
        GraphQLField("senderUserId", type: .nonNull(.scalar(String.self))),
        GraphQLField("feedDate", type: .scalar(String.self)),
        GraphQLField("senderUserName", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(baseId: GraphQLID, commentId: String, createdAt: String, message: String, senderUserId: String, feedDate: String? = nil, senderUserName: String) {
        self.init(snapshot: ["__typename": "Comment", "baseId": baseId, "commentId": commentId, "createdAt": createdAt, "message": message, "senderUserId": senderUserId, "feedDate": feedDate, "senderUserName": senderUserName])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var baseId: GraphQLID {
        get {
          return snapshot["baseId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "baseId")
        }
      }

      public var commentId: String {
        get {
          return snapshot["commentId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "commentId")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var message: String {
        get {
          return snapshot["message"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "message")
        }
      }

      public var senderUserId: String {
        get {
          return snapshot["senderUserId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "senderUserId")
        }
      }

      public var feedDate: String? {
        get {
          return snapshot["feedDate"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "feedDate")
        }
      }

      public var senderUserName: String {
        get {
          return snapshot["senderUserName"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "senderUserName")
        }
      }
    }
  }
}

public final class GetCommentQuery: GraphQLQuery {
  public static let operationString =
    "query GetComment($baseId: ID!, $limit: Int, $nextToken: String) {\n  getCommentsInBaseId(baseId: $baseId, limit: $limit, nextToken: $nextToken) {\n    __typename\n    items {\n      __typename\n      baseId\n      commentId\n      createdAt\n      message\n      senderUserId\n      senderUserName\n    }\n  }\n}"

  public var baseId: GraphQLID
  public var limit: Int?
  public var nextToken: String?

  public init(baseId: GraphQLID, limit: Int? = nil, nextToken: String? = nil) {
    self.baseId = baseId
    self.limit = limit
    self.nextToken = nextToken
  }

  public var variables: GraphQLMap? {
    return ["baseId": baseId, "limit": limit, "nextToken": nextToken]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getCommentsInBaseId", arguments: ["baseId": GraphQLVariable("baseId"), "limit": GraphQLVariable("limit"), "nextToken": GraphQLVariable("nextToken")], type: .object(GetCommentsInBaseId.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(getCommentsInBaseId: GetCommentsInBaseId? = nil) {
      self.init(snapshot: ["__typename": "Query", "getCommentsInBaseId": getCommentsInBaseId.flatMap { $0.snapshot }])
    }

    public var getCommentsInBaseId: GetCommentsInBaseId? {
      get {
        return (snapshot["getCommentsInBaseId"] as? Snapshot).flatMap { GetCommentsInBaseId(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "getCommentsInBaseId")
      }
    }

    public struct GetCommentsInBaseId: GraphQLSelectionSet {
      public static let possibleTypes = ["CommentResponse"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("items", type: .list(.object(Item.selections))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(items: [Item?]? = nil) {
        self.init(snapshot: ["__typename": "CommentResponse", "items": items.flatMap { $0.map { $0.flatMap { $0.snapshot } } }])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var items: [Item?]? {
        get {
          return (snapshot["items"] as? [Snapshot?]).flatMap { $0.map { $0.flatMap { Item(snapshot: $0) } } }
        }
        set {
          snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "items")
        }
      }

      public struct Item: GraphQLSelectionSet {
        public static let possibleTypes = ["Comment"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("baseId", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("commentId", type: .nonNull(.scalar(String.self))),
          GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
          GraphQLField("message", type: .nonNull(.scalar(String.self))),
          GraphQLField("senderUserId", type: .nonNull(.scalar(String.self))),
          GraphQLField("senderUserName", type: .nonNull(.scalar(String.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(baseId: GraphQLID, commentId: String, createdAt: String, message: String, senderUserId: String, senderUserName: String) {
          self.init(snapshot: ["__typename": "Comment", "baseId": baseId, "commentId": commentId, "createdAt": createdAt, "message": message, "senderUserId": senderUserId, "senderUserName": senderUserName])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var baseId: GraphQLID {
          get {
            return snapshot["baseId"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "baseId")
          }
        }

        public var commentId: String {
          get {
            return snapshot["commentId"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "commentId")
          }
        }

        public var createdAt: String {
          get {
            return snapshot["createdAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var message: String {
          get {
            return snapshot["message"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "message")
          }
        }

        public var senderUserId: String {
          get {
            return snapshot["senderUserId"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "senderUserId")
          }
        }

        public var senderUserName: String {
          get {
            return snapshot["senderUserName"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "senderUserName")
          }
        }
      }
    }
  }
}

public final class AddCommentSubscriptionSubscription: GraphQLSubscription {
  public static let operationString =
    "subscription AddCommentSubscription($baseId: String!) {\n  subscribeToEventComments(baseId: $baseId) {\n    __typename\n    baseId\n    commentId\n    createdAt\n    message\n    senderUserId\n    senderUserName\n  }\n}"

  public var baseId: String

  public init(baseId: String) {
    self.baseId = baseId
  }

  public var variables: GraphQLMap? {
    return ["baseId": baseId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("subscribeToEventComments", arguments: ["baseId": GraphQLVariable("baseId")], type: .object(SubscribeToEventComment.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(subscribeToEventComments: SubscribeToEventComment? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "subscribeToEventComments": subscribeToEventComments.flatMap { $0.snapshot }])
    }

    public var subscribeToEventComments: SubscribeToEventComment? {
      get {
        return (snapshot["subscribeToEventComments"] as? Snapshot).flatMap { SubscribeToEventComment(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "subscribeToEventComments")
      }
    }

    public struct SubscribeToEventComment: GraphQLSelectionSet {
      public static let possibleTypes = ["Comment"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("baseId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("commentId", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("message", type: .nonNull(.scalar(String.self))),
        GraphQLField("senderUserId", type: .nonNull(.scalar(String.self))),
        GraphQLField("senderUserName", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(baseId: GraphQLID, commentId: String, createdAt: String, message: String, senderUserId: String, senderUserName: String) {
        self.init(snapshot: ["__typename": "Comment", "baseId": baseId, "commentId": commentId, "createdAt": createdAt, "message": message, "senderUserId": senderUserId, "senderUserName": senderUserName])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var baseId: GraphQLID {
        get {
          return snapshot["baseId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "baseId")
        }
      }

      public var commentId: String {
        get {
          return snapshot["commentId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "commentId")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var message: String {
        get {
          return snapshot["message"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "message")
        }
      }

      public var senderUserId: String {
        get {
          return snapshot["senderUserId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "senderUserId")
        }
      }

      public var senderUserName: String {
        get {
          return snapshot["senderUserName"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "senderUserName")
        }
      }
    }
  }
}