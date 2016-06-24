//
//  Queue.swift
//  SoundQ
//
//  Created by Nishil Shah on 5/22/16.
//  Copyright © 2016 Nishil Shah. All rights reserved.
//

import Foundation
import Soundcloud
import Alamofire
import AlamofireImage

struct Queue {
    
    var title: String
    var identifier: String
    var owner: Int
    var tracks: [Track] = []
    var trackIdentifiers: [Int] = []
    var coverArt: UIImage?
    
    init(title: String, identifier: String) {
        self.init(title: title, identifier: identifier, owner: 0)
    }
    
    init(title: String, identifier: String, owner: Int) {
        self.title = title
        self.identifier = identifier
        self.owner = owner
    }
    
    mutating func setCoverArtWithPath(path: String) {
        if path.characters.count < 1 {
            setUnknownCoverArt()
        }
        Alamofire.request(.GET, path).responseImage { response in
            if let image = response.result.value {
                self.coverArt = image
            } else {
                self.setUnknownCoverArt()
            }
        }
    }
    
    mutating func setUnknownCoverArt() {
        self.coverArt = UIImage(named: "unknown_cover_art")
    }
    
}