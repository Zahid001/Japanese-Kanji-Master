//
//  AllKanjiViewController.swift
//  KanjiMaster
//
//  Created by Md Zahidul Islam Mazumder on 9/4/20.
//  Copyright © 2020 Md Zahidul Islam Mazumder. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AllKanjiViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, GADBannerViewDelegate {
    
    

    
    @IBOutlet weak var tblView: UITableView!
    var dataModel = [Json4Swift_Base]()
    
   var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.showSpinner(onView: self.view)
        addBannerViewToView()
        dataRequest()
        // Do any additional setup after loading the view.
    }
    
    
    func addBannerViewToView() {
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-4570742217514707/5682506981"
        bannerView.rootViewController = self
        bannerView.delegate = self
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView!,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .bottomMargin,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView!,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
        bannerView.load(GADRequest())
    }


    func dataRequest(){
            let headers = [
                "x-rapidapi-host": "kanjialive-api.p.rapidapi.com",
                "x-rapidapi-key": "6a2b9ff5a9msh9dfb8ca364e93dep1ac43fjsn7d2d459bb92c"
            ]

    
            let url = URL(string: "https://kanjialive-api.p.rapidapi.com/api/public/kanji/all")
            var request = URLRequest(url: url!)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers

            let session = URLSession.shared
        
        
        
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                self.removeSpinner()
                if (error != nil) {
                    print(error as Any)
                } else {
                    if let data = data{
                        let jsonDecoder = JSONDecoder()
                        do {
                            let responseModel = try jsonDecoder.decode([Json4Swift_Base].self, from: data)
                            self.dataModel = responseModel
                            DispatchQueue.main.async {
                                self.tblView.reloadData()
                                
                            }
                            print(responseModel.count)
                        } catch  {
                            print(error)
                        }


                    }
                }

            })

            dataTask.resume()
        }



    
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kanjiList", for: indexPath) as! KanjiListTableViewCell
        
        cell.number.text = "\(indexPath.row+1)."
        cell.kanjiChar.text = dataModel[indexPath.row].kanji?.character
        cell.kanjiMeaning.text = dataModel[indexPath.row].kanji?.meaning?.english
        
        return cell
    }

}
