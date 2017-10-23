//  This file was automatically generated and should not be edited.

import Apollo

public final class BeerRatingQuery: GraphQLQuery {
  public static let operationString =
    "query beerRating($q: String) {\n  beerSearch(query: $q) {\n    __typename\n    items {\n      __typename\n      id\n      name\n      brewer {\n        __typename\n        id\n        name\n        country {\n          __typename\n          id\n          code\n        }\n      }\n      averageRating\n      ratingCount\n      overallScore\n    }\n  }\n}"

  public var q: String?

  public init(q: String? = nil) {
    self.q = q
  }

  public var variables: GraphQLMap? {
    return ["q": q]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("beerSearch", arguments: ["query": GraphQLVariable("q")], type: .object(BeerSearch.selections)),
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
          GraphQLField("overallScore", type: .scalar(Double.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(id: GraphQLID, name: String, brewer: Brewer? = nil, averageRating: Double? = nil, ratingCount: Int, overallScore: Double? = nil) {
          self.init(snapshot: ["__typename": "Beer", "id": id, "name": name, "brewer": brewer.flatMap { $0.snapshot }, "averageRating": averageRating, "ratingCount": ratingCount, "overallScore": overallScore])
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

        public var overallScore: Double? {
          get {
            return snapshot["overallScore"] as? Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "overallScore")
          }
        }

        public struct Brewer: GraphQLSelectionSet {
          public static let possibleTypes = ["Brewer"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("country", type: .object(Country.selections)),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(id: GraphQLID, name: String, country: Country? = nil) {
            self.init(snapshot: ["__typename": "Brewer", "id": id, "name": name, "country": country.flatMap { $0.snapshot }])
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

          public var country: Country? {
            get {
              return (snapshot["country"] as? Snapshot).flatMap { Country(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "country")
            }
          }

          public struct Country: GraphQLSelectionSet {
            public static let possibleTypes = ["Country"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("code", type: .scalar(String.self)),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(id: GraphQLID, code: String? = nil) {
              self.init(snapshot: ["__typename": "Country", "id": id, "code": code])
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

            public var code: String? {
              get {
                return snapshot["code"] as? String
              }
              set {
                snapshot.updateValue(newValue, forKey: "code")
              }
            }
          }
        }
      }
    }
  }
}