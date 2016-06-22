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

public extension Track {
    
//    public init(fromRealmTrack track: RealmTrack) {
//        self.identifier = track.identifier
//        self.title = track.title
//        self.createdAt = track.createdAt
//        self.createdBy = nil
//        self.duration = track.duration
//        self.commentable = track.commentable
//        self.streamable = track.streamable
//        self.downloadable = track.downloadable
//        self.description = track.desc
//        self.genre = track.genre
//        self.playbackCount = track.playbackCount
//        self.downloadCount = track.downloadCount
//        self.favoriteCount = track.favoriteCount
//        self.commentCount = track.commentCount
//        if track.streamURL != nil {
//            self.streamURL = NSURL(fileURLWithPath: track.streamURL!)
//        } else {
//            self.streamURL = nil
//        }
//        if track.downloadURL != nil {
//            self.downloadURL = NSURL(fileURLWithPath: track.downloadURL!)
//        } else {
//            self.downloadURL = nil
//        }
//        if track.permalinkURL != nil {
//            self.permalinkURL = NSURL(fileURLWithPath: track.permalinkURL!)
//        } else {
//            self.permalinkURL = nil
//        }
//        if track.artworkImageURL != nil {
//            self.artworkImageURL = ImageURLs(baseURL: NSURL(fileURLWithPath: track.artworkImageURL!))
//        } else {
//            track.artworkImageURL = nil
//        }
//        if track.waveformImageURL != nil {
//            self.waveformImageURL = ImageURLs(baseURL: NSURL(fileURLWithPath: track.waveformImageURL!))
//        } else {
//            track.waveformImageURL = nil
//        }
//        //irrelevant properties
//        self.createdWith = nil
//        self.tags = []
//        self.trackType = nil
//        self.format = nil
//        self.contentSize = nil
//        self.releaseYear = nil
//        self.releaseDay = nil
//        self.releaseMonth = nil
//    }
    
}

