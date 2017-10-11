//  This file was automatically generated and should not be edited.

import Apollo

public final class BeerRatingQuery: GraphQLQuery {
  public static let operationString =
    "query beerRating {\n  beerSearch(query: \"Braukollektiv\", first: 5, after: 1) {\n    __typename\n    items {\n      __typename\n      id\n      name\n      brewer {\n        __typename\n        id\n        name\n      }\n      averageRating\n      ratingCount\n    }\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("beerSearch", arguments: ["query": "Braukollektiv", "first": 5, "after": 1], type: .object(BeerSearch.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(beerSearch: BeerSearch? = nil) {
      self.init(snapshot: ["__typename": "Query", "beerSearch": beerSearch.flatMap { $0.snapshot }])
    }

    public var beerSearch: BeerSearch? {
      get {
        return (snapshot["beerSearch"] as? Snapshot).flatMap { BeerSearch(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "beerSearch")
      }
    }

    public struct BeerSearch: GraphQLSelectionSet {
      public static let possibleTypes = ["BeerList"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("items", type: .nonNull(.list(.object(Item.selections)))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(items: [Item?]) {
        self.init(snapshot: ["__typename": "BeerList", "items": items.map { $0.flatMap { $0.snapshot } }])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var items: [Item?] {
        get {
          return (snapshot["items"] as! [Snapshot?]).map { $0.flatMap { Item(snapshot: $0) } }
        }
        set {
          snapshot.updateValue(newValue.map { $0.flatMap { $0.snapshot } }, forKey: "items")
        }
      }

      public struct Item: GraphQLSelectionSet {
        public static let possibleTypes = ["Beer"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("brewer", type: .object(Brewer.selections)),
          GraphQLField("averageRating", type: .scalar(Double.self)),
          GraphQLField("ratingCount", type: .nonNull(.scalar(Int.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(id: GraphQLID, name: String, brewer: Brewer? = nil, averageRating: Double? = nil, ratingCount: Int) {
          self.init(snapshot: ["__typename": "Beer", "id": id, "name": name, "brewer": brewer.flatMap { $0.snapshot }, "averageRating": averageRating, "ratingCount": ratingCount])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return snapshot["id"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        public var name: String {
          get {
            return snapshot["name"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "name")
          }
        }

        public var brewer: Brewer? {
          get {
            return (snapshot["brewer"] as? Snapshot).flatMap { Brewer(snapshot: $0) }
          }
          set {
            snapshot.updateValue(newValue?.snapshot, forKey: "brewer")
          }
        }

        public var averageRating: Double? {
          get {
            return snapshot["averageRating"] as? Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "averageRating")
          }
        }

        public var ratingCount: Int {
          get {
            return snapshot["ratingCount"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "ratingCount")
          }
        }

        public struct Brewer: GraphQLSelectionSet {
          public static let possibleTypes = ["Brewer"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(id: GraphQLID, name: String) {
            self.init(snapshot: ["__typename": "Brewer", "id": id, "name": name])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID {
            get {
              return snapshot["id"]! as! GraphQLID
            }
            set {
              snapshot.updateValue(newValue, forKey: "id")
            }
          }

          public var name: String {
            get {
              return snapshot["name"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "name")
            }
          }
        }
      }
    }
  }
}