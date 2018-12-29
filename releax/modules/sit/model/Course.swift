//
//  Course.swift
//  releax
//
//  Created by songyuanjin on 2018/12/28.
//  Copyright © 2018 songyuanjin. All rights reserved.
//

//"category_type": 2,
//"categories": [{
//"show_nums": 5,
//"classes": "Featured Sleep Series",
//"order": 0,
//"resources": [{
//"pay_type": 1000
import Foundation
class Course: Decodable {
    var classes: String?
    var order: Int?
    var resources:[CourseItem]?
}
