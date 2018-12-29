//
//  JsonConvertCourseModel.swift
//  releax
//
//  Created by songyuanjin on 2018/12/28.
//  Copyright © 2018 songyuanjin. All rights reserved.
//

import Foundation
class JsonConvertCourseModel {
    
    class func jsonConvertToModel(fileName: String)-> [Course] {
        let result = jsonParser(fileName: fileName).result
        return result![0].categories!
    }
    private class func jsonParser(fileName: String)-> Result {
        print("JSON", "jsonParser")
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            fatalError("JSON File Fetch Failed")
        }
        //如果不想处理异常那么可以用 try? 这个关键字,使用这个关键字返回一个可选值类型,如果有异常出现,返回nil.如果没有异常,则返回可选值.
        let data = try? Data.init(contentsOf: fileURL)
        let decoder = JSONDecoder()
        guard let result = try? decoder.decode(Result.self, from: data!) else {
            fatalError("JSON Decode Failed")
        }
        return result
    }
}
