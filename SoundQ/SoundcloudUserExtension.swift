//
//  SoundcloudUserExtension.swift
//  SoundQ
//
//  Created by Nishil Shah on 6/1/16.
//  Copyright © 2016 Nishil Shah. All rights reserved.
//

import Foundation
import Soundcloud
import RealmSwift

public extension User {
    
    public init(fromRealmUser user: RealmUser) {
        self.identifier = user.identifier
        self.username = user.username
        self.fullname = user.fullname
        self.city = user.city
        self.country = user.country
        self.biography = user.biography
        if user.URL != nil {
            self.URL = NSURL(fileURLWithPath: user.URL!)
        } else {
            self.URL = nil
        }
        if user.permalinkURL != nil {
            self.permalinkURL = NSURL(fileURLWithPath:  user.permalinkURL!)
        } else {
            self.permalinkURL = nil
        }
        if user.websiteURL != nil {
            self.websiteURL = NSURL(fileURLWithPath: user.websiteURL!)
        } else {
            self.websiteURL = nil
        }
        self.websiteTitle = user.websiteTitle
        self.avatarURL = ImageURLs(baseURL: NSURL(fileURLWithPath: user.avatarURL!))
        self.tracksCount = user.tracksCount
        self.playlistsCount = user.playlistsCount
        self.followersCount = user.followersCount
        self.followingsCount = user.followingsCount
    }
    
}


