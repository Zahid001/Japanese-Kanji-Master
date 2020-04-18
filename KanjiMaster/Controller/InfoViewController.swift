//
//  InfoViewController.swift
//  KanjiMaster
//
//  Created by Md Zahidul Islam Mazumder on 12/4/20.
//  Copyright © 2020 Md Zahidul Islam Mazumder. All rights reserved.
//

import UIKit
import WebKit
class InfoViewController: UIViewController,WKNavigationDelegate {

   
    @IBOutlet weak var webVw: WKWebView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webVw.navigationDelegate = self
        
        let url = URL(string: "https://zahid001.github.io")!
        webVw.load(URLRequest(url: url))
        webVw.allowsBackForwardNavigationGestures = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
