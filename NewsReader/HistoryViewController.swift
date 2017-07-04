//
//  HistoryViewController.swift
//  NewsReader
//
//  Created by akira_sato on 2017/06/21.
//  Copyright © 2017年 akira2. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var newsUrl = ""
    var publisher = ""
    
    var newsTitles: Array<String> = []
    var newsDates: Array<String> = []
    var newsUrls: Array<String> = []
    var newsPublisher: Array<String> = []
    
    let userDefaults = UserDefaults.standard
    
    @IBOutlet var table :UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "History"
        
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = UIColor.white
        
        createData()
    }
    
    func createData() {
        newsTitles = userDefaults.object(forKey: "newsTitles") as? Array<String> ?? []
        newsTitles = userDefaults.object(forKey: "newsTitles") as? Array<String> ?? []
        newsTitles = userDefaults.object(forKey: "newsTitles") as? Array<String> ?? []
        newsTitles = userDefaults.object(forKey: "newsTitles") as? Array<String> ?? []
        
        if let aaa = userDefaults.object(forKey: "newsDates") {
            newsDates = aaa as! Array<String>
        }
        if let aaa = userDefaults.object(forKey: "newsUrls") {
            newsUrls = aaa as! Array<String>
        }
        if let aaa = userDefaults.object(forKey: "newsPublisher") {
            newsPublisher = aaa as! Array<String>
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // セルの数
        return newsTitles.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // セクションの数
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルの内容を決める。
        let cell = UITableViewCell(style:UITableViewCellStyle.subtitle, reuseIdentifier: "historyCell")
        
        let Ntitle = newsTitles[indexPath.row]
        let Ndate = newsDates[indexPath.row]
        
        cell.textLabel!.text = Ntitle
        cell.textLabel!.numberOfLines = 3
        cell.detailTextLabel!.text = Ndate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        newsUrl = newsUrls[indexPath.row]
        publisher = newsPublisher[indexPath.row]
        
        performSegue(withIdentifier: "toWebView2", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let wvc = segue.destination as! WebViewController2
        
        wvc.newsURL = newsUrl
        wvc.title = publisher
    }
    @IBAction func reload(_ sender: UIButton) {
        self.viewDidLoad()
        table.reloadData()
    }
    @IBAction func historyDelete(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "newsTitles")
        UserDefaults.standard.removeObject(forKey: "newsDates")
        UserDefaults.standard.removeObject(forKey: "newsUrls")
        UserDefaults.standard.removeObject(forKey: "newsPublisher")
        
        self.viewDidLoad()
        createData()
        table.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
