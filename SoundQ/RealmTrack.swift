//
//  RealmTrack.swift
//  SoundQ
//
//  Created by Nishil Shah on 6/21/16.
//  Copyright © 2016 Nishil Shah. All rights reserved.
//

import Foundation
import Soundcloud
import Realm
import RealmSwift

public class RealmTrack : Object {
    
    dynamic var identifier: Int = 0
    dynamic var createdAt: NSDate = NSDate()
    dynamic var duration: NSTimeInterval = 0
    dynamic var commentable: Bool = false
    dynamic var streamable: Bool = false
    dynamic var downloadable: Bool = false
    dynamic var streamURL: String?
    dynamic var downloadURL: String?
    dynamic var permalinkURL: String?
    dynamic var desc: String?
    dynamic var genre: String?
    dynamic var title: String = ""
    dynamic var artworkImageURL: String?
    dynamic var waveformImageURL: String?
    dynamic var playbackCount: Int = 0
    dynamic var downloadCount: Int = 0
    dynamic var favoriteCount: Int = 0
    dynamic var commentCount: Int = 0
    
    required public init() {
        super.init()
    }
    
    public convenience init(fromTrack track: Track) {
        self.init()
        self.identifier = track.identifier
        self.createdAt = track.createdAt
        self.duration = track.duration
        self.commentable = track.commentable
        self.streamable = track.streamable
        self.downloadable = track.downloadable
        self.streamURL = track.streamURL?.absoluteString
        self.downloadURL = track.downloadURL?.absoluteString
        self.permalinkURL = track.permalinkURL?.absoluteString
        self.desc = track.description
        self.genre = track.genre
        self.title = track.title
        self.artworkImageURL = track.artworkImageURL.baseURL?.absoluteString
        self.waveformImageURL = track.waveformImageURL.baseURL?.absoluteString
        self.playbackCount = track.playbackCount!
        self.downloadCount = track.downloadCount!
        self.favoriteCount = track.favoriteCount!
        self.commentCount = track.commentCount!
    }
    
    required public init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required public init(value: AnyObject, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
}
