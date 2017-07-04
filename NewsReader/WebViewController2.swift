//
//  WebViewController2.swift
//  NewsReader
//
//  Created by akira_sato on 2017/06/21.
//  Copyright © 2017年 akira2. All rights reserved.
//

import UIKit

class WebViewController2: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView!
    
    var newsURL = "https://google.com"
    var indicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.delegate = self
        
        indicator.center = self.view.center
        
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        
        webView.addSubview(indicator)
        
        let url = NSURL(string: newsURL)!
        
        let urlRequest = URLRequest(url: url as URL)
        
        webView.loadRequest(urlRequest)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        indicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        indicator.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
