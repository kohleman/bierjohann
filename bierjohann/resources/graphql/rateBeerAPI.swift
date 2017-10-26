//  This file was automatically generated and should not be edited.

import Apollo

public final class BeerRatingQuery: GraphQLQuery {
  public static let operationString =
    "query beerRating($q: String) {\n  beerSearch(query: $q) {\n    __typename\n    items {\n      __typename\n      id\n      name\n      abv\n      averageRating\n      ratingCount\n      overallScore\n      description\n      imageUrl\n      brewer {\n        __typename\n        id\n        name\n        description\n        type\n        twitter\n        facebook\n        web\n        streetAddress\n        city\n        country {\n          __typename\n          id\n          name\n          code\n        }\n        zip\n        email\n        areaCode\n        phone\n        imageUrl\n        score\n      }\n      style {\n        __typename\n        id\n        name\n        description\n        parent {\n          __typename\n          id\n          name\n        }\n        glasses {\n          __typename\n          id\n          name\n          description\n        }\n      }\n    }\n  }\n}"

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
          GraphQLField("abv", type: .scalar(Double.self)),
          GraphQLField("averageRating", type: .scalar(Double.self)),
          GraphQLField("ratingCount", type: .nonNull(.scalar(Int.self))),
          GraphQLField("overallScore", type: .scalar(Double.self)),
          GraphQLField("description", type: .scalar(String.self)),
          GraphQLField("imageUrl", type: .nonNull(.scalar(String.self))),
          GraphQLField("brewer", type: .object(Brewer.selections)),
          GraphQLField("style", type: .nonNull(.object(Style.selections))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(id: GraphQLID, name: String, abv: Double? = nil, averageRating: Double? = nil, ratingCount: Int, overallScore: Double? = nil, description: String? = nil, imageUrl: String, brewer: Brewer? = nil, style: Style) {
          self.init(snapshot: ["__typename": "Beer", "id": id, "name": name, "abv": abv, "averageRating": averageRating, "ratingCount": ratingCount, "overallScore": overallScore, "description": description, "imageUrl": imageUrl, "brewer": brewer.flatMap { $0.snapshot }, "style": style.snapshot])
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

        public var abv: Double? {
          get {
            return snapshot["abv"] as? Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "abv")
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

        public var description: String? {
          get {
            return snapshot["description"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "description")
          }
        }

        public var imageUrl: String {
          get {
            return snapshot["imageUrl"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "imageUrl")
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

        public var style: Style {
          get {
            return Style(snapshot: snapshot["style"]! as! Snapshot)
          }
          set {
            snapshot.updateValue(newValue.snapshot, forKey: "style")
          }
        }

        public struct Brewer: GraphQLSelectionSet {
          public static let possibleTypes = ["Brewer"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("description", type: .scalar(String.self)),
            GraphQLField("type", type: .scalar(String.self)),
            GraphQLField("twitter", type: .scalar(String.self)),
            GraphQLField("facebook", type: .scalar(String.self)),
            GraphQLField("web", type: .scalar(String.self)),
            GraphQLField("streetAddress", type: .scalar(String.self)),
            GraphQLField("city", type: .scalar(String.self)),
            GraphQLField("country", type: .object(Country.selections)),
            GraphQLField("zip", type: .scalar(String.self)),
            GraphQLField("email", type: .scalar(String.self)),
            GraphQLField("areaCode", type: .scalar(String.self)),
            GraphQLField("phone", type: .scalar(String.self)),
            GraphQLField("imageUrl", type: .scalar(String.self)),
            GraphQLField("score", type: .scalar(Int.self)),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(id: GraphQLID, name: String, description: String? = nil, type: String? = nil, twitter: String? = nil, facebook: String? = nil, web: String? = nil, streetAddress: String? = nil, city: String? = nil, country: Country? = nil, zip: String? = nil, email: String? = nil, areaCode: String? = nil, phone: String? = nil, imageUrl: String? = nil, score: Int? = nil) {
            self.init(snapshot: ["__typename": "Brewer", "id": id, "name": name, "description": description, "type": type, "twitter": twitter, "facebook": facebook, "web": web, "streetAddress": streetAddress, "city": city, "country": country.flatMap { $0.snapshot }, "zip": zip, "email": email, "areaCode": areaCode, "phone": phone, "imageUrl": imageUrl, "score": score])
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

          public var description: String? {
            get {
              return snapshot["description"] as? String
            }
            set {
              snapshot.updateValue(newValue, forKey: "description")
            }
          }

          public var type: String? {
            get {
              return snapshot["type"] as? String
            }
            set {
              snapshot.updateValue(newValue, forKey: "type")
            }
          }

          public var twitter: String? {
            get {
              return snapshot["twitter"] as? String
            }
            set {
              snapshot.updateValue(newValue, forKey: "twitter")
            }
          }

          public var facebook: String? {
            get {
              return snapshot["facebook"] as? String
            }
            set {
              snapshot.updateValue(newValue, forKey: "facebook")
            }
          }

          public var web: String? {
            get {
              return snapshot["web"] as? String
            }
            set {
              snapshot.updateValue(newValue, forKey: "web")
            }
          }

          public var streetAddress: String? {
            get {
              return snapshot["streetAddress"] as? String
            }
            set {
              snapshot.updateValue(newValue, forKey: "streetAddress")
            }
          }

          public var city: String? {
            get {
              return snapshot["city"] as? String
            }
            set {
              snapshot.updateValue(newValue, forKey: "city")
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

          public var zip: String? {
            get {
              return snapshot["zip"] as? String
            }
            set {
              snapshot.updateValue(newValue, forKey: "zip")
            }
          }

          public var email: String? {
            get {
              return snapshot["email"] as? String
            }
            set {
              snapshot.updateValue(newValue, forKey: "email")
            }
          }

          public var areaCode: String? {
            get {
              return snapshot["areaCode"] as? String
            }
            set {
              snapshot.updateValue(newValue, forKey: "areaCode")
            }
          }

          public var phone: String? {
            get {
              return snapshot["phone"] as? String
            }
            set {
              snapshot.updateValue(newValue, forKey: "phone")
            }
          }

          public var imageUrl: String? {
            get {
              return snapshot["imageUrl"] as? String
            }
            set {
              snapshot.updateValue(newValue, forKey: "imageUrl")
            }
          }

          public var score: Int? {
            get {
              return snapshot["score"] as? Int
            }
            set {
              snapshot.updateValue(newValue, forKey: "score")
            }
          }

          public struct Country: GraphQLSelectionSet {
            public static let possibleTypes = ["Country"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
              GraphQLField("code", type: .scalar(String.self)),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(id: GraphQLID, name: String, code: String? = nil) {
              self.init(snapshot: ["__typename": "Country", "id": id, "name": name, "code": code])
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

        public struct Style: GraphQLSelectionSet {
          public static let possibleTypes = ["BeerStyle"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("description", type: .nonNull(.scalar(String.self))),
            GraphQLField("parent", type: .object(Parent.selections)),
            GraphQLField("glasses", type: .nonNull(.list(.object(Glass.selections)))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(id: GraphQLID, name: String, description: String, parent: Parent? = nil, glasses: [Glass?]) {
            self.init(snapshot: ["__typename": "BeerStyle", "id": id, "name": name, "description": description, "parent": parent.flatMap { $0.snapshot }, "glasses": glasses.map { $0.flatMap { $0.snapshot } }])
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

          public var description: String {
            get {
              return snapshot["description"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "description")
            }
          }

          public var parent: Parent? {
            get {
              return (snapshot["parent"] as? Snapshot).flatMap { Parent(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "parent")
            }
          }

          public var glasses: [Glass?] {
            get {
              return (snapshot["glasses"] as! [Snapshot?]).map { $0.flatMap { Glass(snapshot: $0) } }
            }
            set {
              snapshot.updateValue(newValue.map { $0.flatMap { $0.snapshot } }, forKey: "glasses")
            }
          }

          public struct Parent: GraphQLSelectionSet {
            public static let possibleTypes = ["BeerStyle"]

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
              self.init(snapshot: ["__typename": "BeerStyle", "id": id, "name": name])
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

          public struct Glass: GraphQLSelectionSet {
            public static let possibleTypes = ["Glass"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("name", type: .scalar(String.self)),
              GraphQLField("description", type: .scalar(String.self)),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(id: GraphQLID, name: String? = nil, description: String? = nil) {
              self.init(snapshot: ["__typename": "Glass", "id": id, "name": name, "description": description])
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

            public var name: String? {
              get {
                return snapshot["name"] as? String
              }
              set {
                snapshot.updateValue(newValue, forKey: "name")
              }
            }

            public var description: String? {
              get {
                return snapshot["description"] as? String
              }
              set {
                snapshot.updateValue(newValue, forKey: "description")
              }
            }
          }
        }
      }
    }
  }
}