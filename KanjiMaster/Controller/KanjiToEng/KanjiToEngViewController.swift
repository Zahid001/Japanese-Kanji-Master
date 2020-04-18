//
//  KanjiToEngViewController.swift
//  KanjiMaster
//
//  Created by Md Zahidul Islam Mazumder on 9/4/20.
//  Copyright © 2020 Md Zahidul Islam Mazumder. All rights reserved.
//

import UIKit
import GoogleMobileAds
class KanjiToEngViewController: UIViewController,UITextFieldDelegate, GADBannerViewDelegate {

    @IBOutlet weak var txtField: UITextField!
    
    @IBOutlet weak var kanjiLabel: UILabel!
    @IBOutlet weak var kanjiImg: UIImageView!
    @IBOutlet weak var meaning: UILabel!
    
    @IBOutlet weak var eJPN: UILabel!
    
    @IBOutlet weak var eJPNMeaning: UILabel!
    
    
    @IBOutlet weak var showHideLabel: UILabel!
    
    var adLoader: GADAdLoader!
    
    var bannerView: GADBannerView!
    
    @IBOutlet weak var GADBanner: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        let multipleAdsOptions = GADMultipleAdsAdLoaderOptions()
//        multipleAdsOptions.numberOfAds = 5
//
//        adLoader = GADAdLoader(adUnitID: "ca-app-pub-3940256099942544/3986624511", rootViewController: self,
//            adTypes: [GADAdLoaderAdType.unifiedNative],
//            options: [multipleAdsOptions])
//        adLoader.delegate = self
//        adLoader.load(GADRequest())
//
        // ca-app-pub-4570742217514707/5688631441
//         GADBanner.adUnitID = "ca-app-pub-3940256099942544/3986624511"
//         GADBanner.rootViewController = self
//         GADBanner.load(GADRequest())
        
//        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
//
//        addBannerViewToView(bannerView)
//
//        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
//        bannerView.rootViewController = self
        //bannerView.delegate = self
        
        
        addBannerViewToView()
        
        showHideLabel.isHidden = false
        
        txtField.delegate = self
        //txtField.becomeFirstResponder()
        txtField.addTarget(self, action: #selector(myTargetFunction), for: .editingDidEndOnExit)

        
    }
    
    
    
    @objc func myTargetFunction(textField: UITextField) {
        print("textfield pressed")
    }

    @IBAction func txtAction(_ sender: UITextField) {
        
        dataRequest(query: sender.text?.replacingOccurrences(of: " ", with: "") ?? "")
        
        
    }
    
    
 
    
    func addBannerViewToView() {
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-4570742217514707/6995588653"
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

        let url = URL(string: "https://kanjialive-api.p.rapidapi.com/api/public/kanji/"+(query.replacingOccurrences(of: " ", with: "").addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) ?? ""))
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
                            let responseModel = try jsonDecoder.decode(Json4Swift_Base.self, from: data)
                            
                            if let jsonString = String(data: data, encoding: .utf8) {
                               print(jsonString)
                            }
                            
                            //print(responseModel.kanji?.meaning)
                            DispatchQueue.main.async {
//                                if let posterUrl = responseModel.kanjiToEng?.video?.poster{
//                                    self.kanjiImg.load(url: URL(string: posterUrl )!)
//                                }
                                
                                if responseModel.examples?.count != 0 {
                                    self.kanjiLabel.text = self.txtField.text
                                    self.eJPN.text = responseModel.examples?[0].japanese
                                    self.eJPNMeaning.text = responseModel.examples?[0].meaning?.english
                                    self.meaning.text = responseModel.kanji?.meaning?.english
                                    self.showHideLabel.isHidden = true
                                }
                                
                            }
                        } catch  {
                            print(error)
                        }
                        

                    }
                    
                }
                
            })

            dataTask.resume()
        }
    
}

extension KanjiToEngViewController: GADUnifiedNativeAdLoaderDelegate{
    
    
    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: GADRequestError) {
        
    }
    
    

     func adLoaderDidFinishLoading(_ adLoader: GADAdLoader) {
         // The adLoader has finished loading ads, and a new request can be sent.
     }
    
    func nativeAdDidRecordImpression(_ nativeAd: GADUnifiedNativeAd) {
      // The native ad was shown.
    }

    func nativeAdDidRecordClick(_ nativeAd: GADUnifiedNativeAd) {
      // The native ad was clicked on.
    }

    func nativeAdWillPresentScreen(_ nativeAd: GADUnifiedNativeAd) {
      // The native ad will present a full screen view.
    }

    func nativeAdWillDismissScreen(_ nativeAd: GADUnifiedNativeAd) {
      // The native ad will dismiss a full screen view.
    }

    func nativeAdDidDismissScreen(_ nativeAd: GADUnifiedNativeAd) {
      // The native ad did dismiss a full screen view.
    }

    func nativeAdWillLeaveApplication(_ nativeAd: GADUnifiedNativeAd) {
      // The native ad will cause the application to become inactive and
      // open a new application.
    }
    
    
    
    // Mark: - GADUnifiedNativeAdLoaderDelegate
    func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADUnifiedNativeAd) {
      print("Received unified native ad: \(nativeAd)")
      //refreshAdButton.isEnabled = true
      // Create and place ad in view hierarchy.
//      let nibView = Bundle.main.loadNibNamed("UnifiedNativeAdView", owner: nil, options: nil)?.first
//      guard let nativeAdView = nibView as? GADUnifiedNativeAdView else {
//        return
//      }
//      //setAdView(nativeAdView)
//
//      // Associate the native ad view with the native ad object. This is
//      // required to make the ad clickable.
//      nativeAdView.nativeAd = nativeAd
//
//      // Set the mediaContent on the GADMediaView to populate it with available
//      // video/image asset.
//      nativeAdView.mediaView?.mediaContent = nativeAd.mediaContent
//
//      // Populate the native ad view with the native ad assets.
//      // The headline is guaranteed to be present in every native ad.
//      (nativeAdView.headlineView as? UILabel)?.text = nativeAd.headline
//
//      // These assets are not guaranteed to be present. Check that they are before
//      // showing or hiding them.
//      (nativeAdView.bodyView as? UILabel)?.text = nativeAd.body
//      nativeAdView.bodyView?.isHidden = nativeAd.body == nil
//
//      (nativeAdView.callToActionView as? UIButton)?.setTitle(nativeAd.callToAction, for: .normal)
//      nativeAdView.callToActionView?.isHidden = nativeAd.callToAction == nil
//
//      (nativeAdView.iconView as? UIImageView)?.image = nativeAd.icon?.image
//      nativeAdView.iconView?.isHidden = nativeAd.icon == nil
//
//      //(nativeAdView.starRatingView as? UIImageView)?.image = imageOfStars(fromStarRating:nativeAd.starRating)
//      nativeAdView.starRatingView?.isHidden = nativeAd.starRating == nil
//
//      (nativeAdView.storeView as? UILabel)?.text = nativeAd.store
//      nativeAdView.storeView?.isHidden = nativeAd.store == nil
//
//      (nativeAdView.priceView as? UILabel)?.text = nativeAd.price
//      nativeAdView.priceView?.isHidden = nativeAd.price == nil
//
//      (nativeAdView.advertiserView as? UILabel)?.text = nativeAd.advertiser
//      nativeAdView.advertiserView?.isHidden = nativeAd.advertiser == nil
//
//      // In order for the SDK to process touch events properly, user interaction
//      // should be disabled.
//      nativeAdView.callToActionView?.isUserInteractionEnabled = false
    }
//
}


extension CharacterSet {
    static let urlAllowed = CharacterSet.urlFragmentAllowed
                                        .union(.urlHostAllowed)
                                        .union(.urlPasswordAllowed)
                                        .union(.urlQueryAllowed)
                                        .union(.urlUserAllowed)
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
