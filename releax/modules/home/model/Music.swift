//
//  Music.swift
//  releax
//
//  Created by songyuanjin on 2018/12/24.
//  Copyright © 2018 songyuanjin. All rights reserved.
//
import Foundation
class Music: Decodable {
    var show_nums: Int?
    var order: Int?
    var musics: [MusicItem]?
    
    required init() {
    }
}
