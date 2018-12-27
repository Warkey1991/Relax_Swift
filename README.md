#  Swift 学习
- **通过项目学习语法，将变得更易理解和有趣**  包含了一下语法知识点，将继续补充
1. **常量和变量**: var ---变量， let 常量， var 修饰的变量可以修改，let修饰的常量一经初始化就无法更改。
     ```Swift
         var text: String?
         var rightImage: UIImage?
         let textLabel = UILabel()
    ```
2. **可选类型**：Swift 的可选（Optional）类型，用于处理值缺失的情况。可选表示"那儿有一个值，并且它等于 x "或者"那儿没有值"。
    如声明变量的时候采用如下代码
    ```Swift
        var text: String? //可选类型
        var rightImage: UIImage? //可选类型
        let textLabel = UILabel()
    ```
    - 强制解析：当你确定可选类型确实包含值之后，你可以在可选的名字后面加一个感叹号（!）来获取值。这个感叹号表示"我知道这个可选有值，请使用它。"这被称为可选值的强制解析（forced unwrapping）。
          ```Swift
          textLabel.text = text! //注意：使用!来获取一个不存在的可选值会导致运行时错误。使用!来强制解析值之前，一定要确定可选包含一个非nil值。
          ```
    - 自动解析: 你可以在声明可选变量时使用感叹号（!）替换问号（?）。这样可选变量在使用时就不需要再加一个感叹号（!）来获取值，它会自动解析。
        ```Swift
            var musicItems: [MusicItem]?
                guard let music = musicItems?[index - 1] else {
                fatalError("music nil")
            }
        ```
         
    - 可选绑定：使用可选绑定（optional binding）来判断可选类型是否包含值，如果包含就把值赋给一个临时常量或者变量。可选绑定可以用在if和while语句中来对可选类型的值进行判断并把值赋给一个常量或者变量。
        ```Swift
            if let musicItemsArray = musicItems {
               //如果这个可选类型变量有值
            } else  {
            
            }
        ```
3. **字典和数组**：以下代码示例是数组中的元素是字典，这是根据后台返回的json数据格式确定的。更加实用。
    ```Swift
       class func jsonConvertMusic(_ fileUrl: String...)-> Array<[String: Music]> {
           var musicDict = Array<[String: Music]>()
           for url in fileUrl {
           let item = jsonParser(fileName: url)
           musicDict.append(item)
           }
            return musicDict
        }
        let jsonMusicDict = JsonConvertModel.jsonConvertMusic("sleep_music_course_list.json", "sleep_music_natural.json","sleep_music_wake_up.json","sleep_series_default.json","tab_home_default_source.json")
       musicData.insert([String:Music](), at: 0) //在指定位置插入一个元素
       musicData.insert(contentsOf: jsonMusicDict, at: 1)//在指定位置插入一个数组
    ```

4. **函数参数知识点**：可变参数、外部参数名、
      - 可变参数：一个可变参数(variadic parameter)可以接受一个或多个值。函数调用时，你可以用可变参数来传入不确定数量的输入参数。通过在变量类型名后面加入(...)的方式来定义可变参数。
    ```Swift
        //该函数就实用了可变参数
        class func jsonConvertMusic(_ fileUrl: String...)-> Array<[String: Music]> {
            var musicDict = Array<[String: Music]>()
            for url in fileUrl {
            let item = jsonParser(fileName: url)
            musicDict.append(item)
            }
            return musicDict
        }
    ```
    - 外部参数名：时候，调用函数时，给每个参数命名是非常有用的，因为这些参数名可以指出各个实参的用途是什么。 如果你希望函数的使用者在调用函数时提供参数名字，那就需要给每个参数除了局部参数名外再定义一个外部参数名。外部参数名写在局部参数名之前，用空格分隔。
        ```Swift 
            
            func progress(pogress pogressDouble: Double) {
                let result = pogressDouble * 100
                DispatchQueue.main.async {
                    self.timeLabel.text = "DownLoading(\(Int(result))%)"
                }
            }
             downLoadProtocol.progress(pogress: progress.fractionCompleted)
        ```
5. **协议**：协议规定了用来实现某一特定功能所必需的方法和属性。任意能够满足协议要求的类型被称为遵循(conform)这个协议。类，结构体或枚举类型都可以遵循协议，并提供具体实现来完成协议定义的方法和功能。
        
    ```Swift
        import Foundation
        //定义协议
        protocol MusicDownLoadProtocol {
            func progress(pogress: Double)
            func downLoaded(saveUrl: URL)
        }
        
        //需要实现的协议，就像继承一样的，要在实现类中实现协议的方法
        class PlayController: UIViewController, MusicDownLoadProtocol {
            func progress(pogress pogressDouble: Double) {
                let result = pogressDouble * 100
                DispatchQueue.main.async {
                    self.timeLabel.text = "DownLoading(\(Int(result))%)"
                }
            }
            
            func downLoaded(saveUrl: URL) {
                audioPlayer.play(saveUrl)
                let seconds = audioDuration(saveUrl)
                let (minute, second) = secondsConvertMinuteAndSeconds(seconds: Int(seconds))
                timeLabel.text = timeConvertString(minute: minute, second: second)
                playButton.setImage(UIImage(named: "play_pause_btn")?.withRenderingMode(.alwaysOriginal), for: .normal)
                }
            }
            //调用，可以直接传递self，因为PlayController已经实现了该协议
            HttpTools.downloadMp3(musicUrl: music.music_url ?? "", downLoadProtocol: self)
        ```
6. **静态方法**：类中的静态方法需要用class关键字修饰
    ```Swift
        import Foundation
        class JsonConvertModel {
        
        /**静态方法可以直接 JsonConvertModel.jsonConvertMusic调用
        该方法采用可变参数： 因为不确定参数的个数。形式为 fileUrl: String...
        */
        class func jsonConvertMusic(_ fileUrl: String...)-> Array<[String: Music]> {
            var musicDict = Array<[String: Music]>()
            for url in fileUrl {
            let item = jsonParser(fileName: url)
                musicDict.append(item)
            }
            return musicDict
        }
        
        private class func jsonParser(fileName: String)-> [String: Music] {
        print("JSON", "jsonParser")
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            fatalError("JSON File Fetch Failed")
        }
        //如果不想处理异常那么可以用 try? 这个关键字,使用这个关键字返回一个可选值类型,如果有异常出现,返回nil.如果没有异常,则返回可选值.
        let data = try? Data.init(contentsOf: fileURL)
        let decoder = JSONDecoder()
        guard let music = try? decoder.decode([String: Music].self, from: data!) else {
            fatalError("JSON Decode Failed")
        }
        return music
        }
        }

    ```
        
