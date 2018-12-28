//
//  JsonConvertModel.swift
//  releax
//
//  Created by songyuanjin on 2018/12/26.
//  Copyright © 2018 songyuanjin. All rights reserved.
//

import Foundation
class JsonConvertModel {
    
    /**静态方法可以直接 JsonConvertModel.jsonConvertMusic调用
     该方法采用可变参数： 因为不确定参数的个数。形式为 fileUrl: String...
    */
    class func jsonConvertMusic(_ fileUrl: String...)-> Array<[String: [MusicItem]]> {
        let labels = ["banner","Sleep Sounds", "Natural", "Morning Wake Up", "Mechanical", "Anti-Stress"]
        var musics = Array<[String: [MusicItem]]>()
        for url in fileUrl {
            let items = jsonParser(fileName: url)
            for i in 0...5 {
                let music = items.filter{ $0.order == i }
                let musicDict = [labels[i] : music]
                musics.append(musicDict)
            }
        }
        return musics
    }
    
    private class func jsonParser(fileName: String)-> [MusicItem] {
        print("JSON", "jsonParser")
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            fatalError("JSON File Fetch Failed")
        }
        //如果不想处理异常那么可以用 try? 这个关键字,使用这个关键字返回一个可选值类型,如果有异常出现,返回nil.如果没有异常,则返回可选值.
        let data = try? Data.init(contentsOf: fileURL)
        let decoder = JSONDecoder()
        guard let music = try? decoder.decode(Music.self, from: data!) else {
            fatalError("JSON Decode Failed")
        }
        return music.sleep_music_list!
    }

}
