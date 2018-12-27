//
//  MusicDownLoadProtocol.swift
//  releax
//
//  Created by songyuanjin on 2018/12/27.
//  Copyright © 2018 songyuanjin. All rights reserved.
//

import Foundation
protocol MusicDownLoadProtocol {
    func progress(pogress: Double)
    func downLoaded(saveUrl: URL)
}
