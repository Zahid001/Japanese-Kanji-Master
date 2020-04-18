//
//  GradeLevelViewController.swift
//  KanjiMaster
//
//  Created by Md Zahidul Islam Mazumder on 9/4/20.
//  Copyright © 2020 Md Zahidul Islam Mazumder. All rights reserved.
//

import UIKit
import GoogleMobileAds
class GradeLevelViewController: UIViewController, GADRewardedAdDelegate, GADBannerViewDelegate {
    

    var bannerView: GADBannerView!
    var rewardedAd: GADRewardedAd?
    var tag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // ca-app-pub-4570742217514707/6003266725
//        rewardedAd = GADRewardedAd(adUnitID: "ca-app-pub-3940256099942544/1712485313")
//        adLoadFirstTime()
        addBannerViewToView()
    }
    
    func addBannerViewToView() {
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-4570742217514707/8442007042"
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

    func adLoadFirstTime(){
        rewardedAd?.load(GADRequest()) { error in
          if let error = error {
            // Handle ad failed to load case.
            print(error)
          } else {
            // Ad successfully loaded.
            if self.rewardedAd?.isReady == true {
                self.rewardedAd?.present(fromRootViewController: self, delegate:self)
            }
            print("ad load")
          }
        }
    }
    
    
    /// Tells the delegate that the user earned a reward.
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
      print("Reward received with currency: \(reward.type), amount \(reward.amount).")
        performSegue(withIdentifier: "gotoGrade", sender: self)
    }
    /// Tells the delegate that the rewarded ad was presented.
    func rewardedAdDidPresent(_ rewardedAd: GADRewardedAd) {
      print("Rewarded ad presented.")
    }
    /// Tells the delegate that the rewarded ad was dismissed.
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
      print("Rewarded ad dismissed.")
    }
    /// Tells the delegate that the rewarded ad failed to present.
    func rewardedAd(_ rewardedAd: GADRewardedAd, didFailToPresentWithError error: Error) {
      print("Rewarded ad failed to present.")
    }
    
    
    @IBAction func goDetails(_ sender: UIButton) {
        tag = sender.tag
        rewardedAd = GADRewardedAd(adUnitID: "ca-app-pub-4570742217514707/6003266725")
        adLoadFirstTime()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if let vc = segue.destination as? GradeDetailsViewController {
            vc.value = "\(tag)"
         }
    }
    

}
