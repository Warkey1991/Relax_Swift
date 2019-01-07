#  Swift 学习
该APP目前实现了以下的功能，在线下载音频到本地，播放本地音频的功能,后续继续完善功能
<div align="left">
<img src="https://github.com/Warkey1991/Relax_Swift/blob/master/releax/resource/2.png" width="200" height="360">
<img src="https://github.com/Warkey1991/Relax_Swift/blob/master/releax/resource/3.png" width="200" height="360">    
<img src="https://github.com/Warkey1991/Relax_Swift/blob/master/releax/resource/4.png" width="200" height="360">  
<img src="https://github.com/Warkey1991/Relax_Swift/blob/master/releax/resource/5.png" width="200" height="360">    
</div>
 <br>
 <br>
 
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
7. **Json解析**：使用了ios自带的解析方法。
        - 实体类需要实现Decodable协议。嵌套类也需要实现
        
    ```Swift
        class Music: Decodable {
            var sleep_music_list:[MusicItem]?
        }
        
        class MusicItem: Decodable{
            var show_nums: Int
            var product_id: String?
            var banner_url: String?
            var title: String?
            var background_url: String?
            var video_url: String?
            var descrip: String?
            var music_url: String?
            var thumb_url: String?
            var type: String?
            var id: Int?
            var classes: String?
            var order:Int?
        }
    ```
        
    - 解析本地json文件，代码如下：
        ```Swift
        private class func jsonParser(fileName: String)-> [MusicItem] {
            //获取本地文件的URL对象
            guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: nil) else {
                fatalError("JSON File Fetch Failed")
            }
            //如果不想处理异常那么可以用 try? 这个关键字,使用这个关键字返回一个可选值类型,如果有异常出现,返回nil.如果没有异常,则返回可选值.
            let data = try? Data.init(contentsOf: fileURL)
            let decoder = JSONDecoder()  //new一个JSONDecoder对象用于解析json文件。
            guard let music = try? decoder.decode(Music.self, from: data!) else {
                fatalError("JSON Decode Failed")
            }
            return music.sleep_music_list!
        }
        ```
8. **String字符串插值 (String Interpolation)**：字符串插值是一种构建新字符串的方式，可以在其中包含常量、变量、字面量和表达式。 您插入的字符串字面量的每一项都被包裹在以反斜线为前缀的圆括号中:
    ```Swift
    func progress(pogress pogressDouble: Double) {
        let result = pogressDouble * 100
        DispatchQueue.main.async {
            self.timeLabel.text = "DownLoading(\(Int(result))%)"
        }
    }
    ```
        
    
    
## 实践开发中的解决方案：
1. **在UILabel中显示多行文本**
          ```Swift
          nameLabel.lineBreakMode = NSLineBreakMode.byWordWrapping 
          nameLabel.numberOfLines = 0  //设置行数
          nameLabel.sizeToFit()  
          ```
2. **两个ViewController的跳转**
         从UIViewController中跳转到带有导航栏的页面
         ```Swift
         let nav = UINavigationController.init(rootViewController: playController)
         self.present(nav, animated: true, completion: nil)
         ```
3. **导航栏透明**
        ```Swift
        
         //视图将要显示
         override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            //设置导航栏背景透明
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
         }
         
         //视图将要消失
         override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
         
            //重置导航栏背景
            self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            self.navigationController?.navigationBar.shadowImage = nil
         }
         ```
4. **自定义弹窗的实现** :使用了一个ViewController，使其背景半透明。在使用UIAlertController时候踩了不少坑。后来弃之.....
         ```Swift
         let premiumViewController = PremiumViewController()
         //页面跳转之前设置backgroundColor为半透明
         premiumViewController.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
         self.present(premiumViewController, animated: true, completion: nil)
         //然后在PremiumViewController中的viewDidLoad方法中设置
         self.modalPresentationStyle = .custom
         ```
5. **给UIButton 添加Action**
       ```Swift
        //closeAction为不带参数的函数
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        //若需要传参
        closeButton.addTarget(self, action: #selector(closeAction(sender:)), for: .touchUpInside)
        @objc private func closeAction(sender: UIButton) {
        }
       ```
6. **非UIButton视图添加Action**：通过添加手势模仿点击事件
        ```Swift
        func setItems() {
            for i in 0..<imageNames.count {
                let itemView = ItemUnitView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height:self.frame.height))
                itemView.setItem(image: UIImage(named: imageNames[i]), title: itemTitles[i])
                itemView.tag = i
                addArrangedSubview(itemView)
                addGestureRecognizerListener(itemView)
            }
        }
        private func addGestureRecognizerListener(_ itemView: ItemUnitView) {
            let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(onClick(sender:)))
            itemView.addGestureRecognizer(singleTapGesture)
            itemView.isUserInteractionEnabled = true  // 需要拦截
        }
        //需要传参
        @objc private func onClick(sender: UITapGestureRecognizer) {
            if (self.delegate != nil) {
                self.delegate?.onClickResponse(index: (sender.view?.tag)!)
            }
        }
        ```
7. **使用UICollectionView 添加不同的header**
        - 创建UICollectionView
        ```Swift
              tableView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
              tableView.delegate = self
              tableView.dataSource = self
              tableView.backgroundColor = UIColor.clear
              tableView.register(UINib(nibName: "MusicCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "music_Cell")
              // 注册一个headView，此段代码是设置header的关键部分
              tableView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header_view")
            ```
        - 实现UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout协议的方法
            
        ```Swift
               //返回分区的数目。此案例中是6个
               func numberOfSections(in collectionView: UICollectionView) -> Int {
                    return musicData.count
               }
               
               //计算每个区所展示的item数目
               func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                   if section == 0 {
                        return 0
                   }
                   let music = musicData[section]
                   var count = 0
                   for (_,value) in music {
                        count = value.count
                   }
                   return count
               }
               
               //每个单元的布局view
               func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "music_Cell", for: indexPath as IndexPath) as! MusicCollectionViewCell
                   let music = musicData[indexPath.section]
                   var musicItems = [MusicItem]()
                   for (_,value) in music {
                       musicItems.append(contentsOf: value)
                       break
                   }
                   
                   let item = musicItems[indexPath.row]
                   cell.initData(imageUrl: item.thumb_url, name: item.title)
                   return cell
               }
               
               //设置header 的宽高
               func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
               if section == 0 {
                        return CGSize.init(width: functionView?.frame.width ?? 0, height: functionView?.frame.height ?? 0)
                   } else {
                        return CGSize.init(width: 400, height: 60)
                   }
               }
               
               //添加headerView 的布局
               func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
                   var reusableview: UICollectionReusableView!
                   if kind == UICollectionView.elementKindSectionHeader {
                        reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header_view", for: indexPath)
                        for view in reusableview.subviews {
                                view.removeFromSuperview()
                            }
                       if indexPath.section != 0 {
                           let headerView = CollectionReusableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 90))
                           let music = musicData[indexPath.section]
                           for (key, _) in music {
                                    headerView.setText(text: key)
                                    break
                            }
                            reusableview.addSubview(headerView)
                        } else {
                            reusableview.addSubview(functionView!)
                        }
                   }
                   return reusableview
               }
               //点击每个cell的事件
               func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                   let playController = PlayController()
                   playController.index = indexPath.row + 1
                   let music = musicData[indexPath.section]
                   var count = 0
                   var musicItems: [MusicItem]?
                   for (_,value) in music {
                       count = value.count
                       musicItems = value
                   }
                   playController.count = count
                   playController.musicItems = musicItems
                   let nav = UINavigationController.init(rootViewController: playController)
                   self.present(nav, animated: true, completion: nil)
               }
               ```
        -  获取数据后重新加载到UICollectionView
           ```Swift
            tableView.reloadData()
           ```
8. **让图片左右缓慢移动的MoveView**：[MoveView](https://www.cnblogs.com/YouXianMing/p/4257078.html) 从这篇文章中获得了启发，修改了动画部分的代码：
    ```Swift
        import UIKit
        
        class MoveView: UIView {
        var imageView: UIImageView!
        var startFrame: CGRect?
        var endFrame: CGRect?
        var animationDuration: Int?
        var direction: EStartMoveDirection = .RIGHT
        var image: UIImage?
        
        override init(frame: CGRect) {
            super.init(frame: frame)
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        enum EStartMoveDirection {
            case LEFT, RIGHT
        }
        
        func initView() {
            let height = self.frame.size.height;
            let imageSize = self.image?.size;
            let imageViewWidth = height / (imageSize?.height ?? 1) * (imageSize?.width ?? 1);
            // 获取到了尺寸
            imageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: imageViewWidth, height: height))
            imageView?.image = image!
            
            // 获取初始尺寸
            startFrame = imageView?.frame;
            endFrame = CGRect(x: self.frame.size.width - (imageView?.frame.size.width)!, y: 0, width: imageViewWidth, height: height)
            
            addSubview(imageView)
        }
        
        
        func doAnimation() {
            if (direction == .RIGHT) {
            imageView?.frame = startFrame!
            } else {
            imageView?.frame = endFrame!
            }
            // 获取动画时间
            animationDuration = (self.animationDuration ?? 80);
            // 开始动画
            startAnimation()
        }
        
        func startAnimation() {
            let options: UIView.AnimationOptions = [UIView.AnimationOptions.repeat,UIView.AnimationOptions.autoreverse,UIView.AnimationOptions.curveLinear]
            if (direction == .RIGHT) {
                UIView.animate(withDuration: TimeInterval(animationDuration!), delay: 0, options: options, animations: {
                    self.imageView?.frame = self.endFrame!
                    }, completion: {b->Void in
                
                })
            } else {
                UIView.animate(withDuration: TimeInterval(animationDuration!), delay: 0, options: options, animations: {
                    self.imageView?.frame = self.startFrame!
                }, completion: {b->Void in
                
                })
                
                }
            }
        
        }

        ```
           
         

