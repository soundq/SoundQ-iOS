//
//  RealmUser.swift
//  SoundQ
//
//  Created by Nishil Shah on 5/25/16.
//  Copyright © 2016 Nishil Shah. All rights reserved.
//

import Foundation
import Soundcloud
import Realm
import RealmSwift

public class RealmUser: Object {
    
    dynamic var identifier: Int = 0
    dynamic var username: String = ""
    dynamic var fullname: String = ""
    dynamic var city: String?
    dynamic var country: String?
    dynamic var biography: String?
    dynamic var URL: String?
    dynamic var permalinkURL: String?
    dynamic var websiteURL: String?
    dynamic var websiteTitle: String?
    dynamic var avatarURL: String?
    dynamic var tracksCount: Int = 0
    dynamic var playlistsCount: Int = 0
    dynamic var followersCount: Int = 0
    dynamic var followingsCount: Int = 0
    
    required public init() {
        super.init()
    }
    
    public convenience init(fromUser user: User) {
        self.init()
        self.identifier = user.identifier
        self.username = user.username
        self.fullname = user.fullname
        self.city = user.city
        self.country = user.country
        self.biography = user.biography
        self.URL = user.URL?.absoluteString
        self.permalinkURL = user.permalinkURL?.absoluteString
        self.websiteURL = user.websiteURL?.absoluteString
        self.websiteTitle = user.websiteTitle
        self.avatarURL = user.avatarURL.baseURL?.absoluteString
        self.tracksCount = user.tracksCount
        self.playlistsCount = user.playlistsCount
        self.followersCount = user.followersCount
        self.followingsCount = user.followingsCount
    }
    
    required public init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required public init(value: AnyObject, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
