//
//  EngToKanjiViewController.swift
//  KanjiMaster
//
//  Created by Md Zahidul Islam Mazumder on 9/4/20.
//  Copyright © 2020 Md Zahidul Islam Mazumder. All rights reserved.
//

import UIKit
import Foundation
import GoogleMobileAds
class EngToKanjiViewController: UIViewController,UITextFieldDelegate, GADBannerViewDelegate {

    var bannerView: GADBannerView!
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var engToKanjiTableView: UITableView!
    @IBOutlet weak var kanjiChar: UILabel!

    var dataModel = [Json4SwiftBaseEngToKanji]()

    override func viewDidLoad() {
        super.viewDidLoad()

        addBannerViewToView()
        
        txtField.delegate = self
        //txtField.becomeFirstResponder()
        txtField.addTarget(self, action: #selector(myTargetFunction), for: .editingDidEndOnExit)

//        engToKanjiTableView.rowHeight = UITableView.automaticDimension
//        engToKanjiTableView.estimatedRowHeight = 300

    }

    @IBAction func txtAction(_ sender: UITextField) {
        print("eeee")
        dataRequest(query: txtField.text?.lowercased().replacingOccurrences(of: " ", with: "") ?? "")
    }

    @objc func myTargetFunction(textField: UITextField) {
        print("textfield pressed")
    }


     
    func addBannerViewToView() {
         bannerView = GADBannerView(adSize: kGADAdSizeBanner)
         bannerView.adUnitID = "ca-app-pub-4570742217514707/5688631441"
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
    
    
    
    func dataRequest(query:String){
        let headers = [
            "x-rapidapi-host": "kanjialive-api.p.rapidapi.com",
            "x-rapidapi-key": "6a2b9ff5a9msh9dfb8ca364e93dep1ac43fjsn7d2d459bb92c"
        ]

//         let request = NSMutableURLRequest(url: NSURL(string: "https://kanjialive-api.p.rapidapi.com/api/public/search/"+query) as URL,
//                                                cachePolicy: .useProtocolCachePolicy,
//                                            timeoutInterval: 10.0)
        let url = URL(string: "https://kanjialive-api.p.rapidapi.com/api/public/search/"+query)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                if let data = data{
                    let jsonDecoder = JSONDecoder()
                    do {
                        let responseModel = try jsonDecoder.decode([Json4SwiftBaseEngToKanji].self, from: data)
                        self.dataModel = responseModel
                        DispatchQueue.main.async {
                            self.engToKanjiTableView.reloadData()
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




    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EngToKanjiViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "e2k", for: indexPath) as! EngToKanjiTableViewCell
//        DispatchQueue.main.async {
//
//        }
        cell.kanjiChar.text = dataModel[indexPath.row].kanji?.character
        cell.kanjiStroke.text = "\( dataModel[indexPath.row].kanji?.stroke ?? 1)"

        cell.radChar.text = dataModel[indexPath.row].radical?.character
        cell.radOrder.text = "\(dataModel[indexPath.row].radical?.order ?? 1)"
        cell.radStroke.text = "\(dataModel[indexPath.row].radical?.stroke ?? 1)"

        return cell
    }



    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 180
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let verticalPadding: CGFloat = 8

        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10    //if you want round edges
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }


//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        return UITableView.automaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
}
