//
//  Result.swift
//  releax
//
//  Created by songyuanjin on 2018/12/28.
//  Copyright © 2018 songyuanjin. All rights reserved.
//

import Foundation
class Result:Decodable {
    var result_code: Int?
    var err_msg: String?
    var result: [CourseResult]?
}
