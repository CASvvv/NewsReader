//
//  ViewController.swift
//  NewsReader
//
//  Created by akira_sato on 2017/05/21.
//  Copyright © 2017年 akira2. All rights reserved.
//

import UIKit
// Alamofire ライブラリをインポート
import Alamofire

class ViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    // ニュース一覧データを格納する配列
    var newsDataArray = NSArray()
    var newsUrl = ""
    var publisher = ""
    
    // iPhoneに履歴として残すデータ
    var newsTitles: Array<String> = []
    var newsDates: Array<String> = []
    var newsUrls: Array<String> = []
    var newsPublisher: Array<String> = []
    
    let userDefaults = UserDefaults.standard
    
    @IBOutlet var table :UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "News Reader"
        // Table ViewのDataSource参照先指定
        table.dataSource = self
        // Table Viewのタップ時のdelegate先を指定
        table.delegate = self
        
        // ニュース情報の取得先
        let requestUrl = "http://appcre.net/rss.php"
        // Web サーバに対してHTTP通信のリクエストを出してデータを取得
        Alamofire.request(requestUrl, method: .get).responseJSON { response in
            switch response.result{
            case .success(let json):
                
                let jsonDic = json as! NSDictionary
                
                let responseData = jsonDic["responseData"] as! NSDictionary
                self.newsDataArray = responseData["results"] as! NSArray
                print("\(self.newsDataArray)")
                
                
                //ニュース記事を取得したらテーブルビューに表示
                self.table.reloadData()
                
                
            case .failure(let error):
                print("通信エラー:\(error)")
            }
            
        }

        // ニュース記事データをテーブルビューに表示
    }
    
    // テーブルビューのセルの数をnewsDataArrayに格納しているデータの数で設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsDataArray.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt  indexPath: IndexPath) -> UITableViewCell {
        // StoryBoardで取得したCellを取得
        let cell = UITableViewCell(style:UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        // ニュース記事データを取得（配列の"indexPath.row"番目の要素を取得）
        let newsDic = newsDataArray[indexPath.row] as! NSDictionary
        // タイトルとタイトルの行数、公開日時をCellにセット
        cell.textLabel!.text = newsDic["title"] as? String
        cell.textLabel!.numberOfLines = 3
        cell.detailTextLabel!.text = newsDic["publishedDate"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("タップされたセルのインデックスパス:\(indexPath.row)")
        
        let newsDic = self.newsDataArray[indexPath.row] as! NSDictionary
        
        newsUrl = newsDic["unescapedUrl"] as! String
        publisher = newsDic["publisher"] as! String
        
        // iPhoneに履歴として保存
        newsTitles.append(newsDic["title"] as! String)
        userDefaults.set(newsTitles, forKey: "newsTitles")
        
        newsDates.append(newsDic["publishedDate"]as! String)
        userDefaults.set(newsDates, forKey: "newsDates")
        
        newsUrls.append(newsUrl)
        userDefaults.set(newsUrls, forKey: "newsUrls")
        
        newsPublisher.append(publisher)
        userDefaults.set(newsPublisher, forKey: "newsPublisher")
        
        userDefaults.synchronize()
        
        performSegue(withIdentifier: "toWebView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let wvc = segue.destination as! WebViewController
        
        wvc.newsURL = newsUrl
        wvc.title = publisher
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

