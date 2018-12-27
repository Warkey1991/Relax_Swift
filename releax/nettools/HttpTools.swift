//
//  HttpTools.swift
//  releax
//
//  Created by songyuanjin on 2018/12/26.
//  Copyright © 2018 songyuanjin. All rights reserved.
//

import Foundation

class HttpTools {
    //方法2
    static let documentPath = NSHomeDirectory() + "/Documents"
    
    class func downloadMp3(musicUrl: String, downLoadProtocol: MusicDownLoadProtocol) {
        let fileUrl = URL(string: musicUrl)
        let request = URLRequest(url: fileUrl!)
        let manager = AFURLSessionManager()
        let downloadTask = manager.downloadTask(with: request, progress: { (progress) in
            downLoadProtocol.progress(pogress: progress.fractionCompleted)
        }, destination: { (url, response) -> URL in
            var destinationUrl = URL(fileURLWithPath: documentPath)
            destinationUrl.appendPathComponent(request.url!.lastPathComponent)
            return destinationUrl
        }) { (urlResponse, filePath, error) in
            downLoadProtocol.downLoaded(saveUrl: filePath!)
        }
        
        downloadTask.resume()
    }
    
    class func fileExist(fileName: String)-> Bool {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        let filePath = url.appendingPathComponent(fileName)?.path

        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath!) {
           return true
        }
        return false
    }
}
