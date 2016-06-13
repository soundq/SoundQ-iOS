//
//  Queue.swift
//  SoundQ
//
//  Created by Nishil Shah on 5/22/16.
//  Copyright © 2016 Nishil Shah. All rights reserved.
//

import Foundation
import Soundcloud

struct Queue {
    
    var title: String
    var identifier: String
    var owner: Int
    var tracks: [Track] = []
    
    init(title: String, identifier: String) {
        self.init(title: title, identifier: identifier, owner: 0)
    }
    
    init(title: String, identifier: String, owner: Int) {
        self.title = title
        self.identifier = identifier
        self.owner = owner
    }
    
    //var songs: [Song]
    
}