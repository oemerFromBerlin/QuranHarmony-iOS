import GoogleMobileAds
import UIKit

class AdManager: NSObject, ObservableObject, GADFullScreenContentDelegate {
    static let shared = AdManager()
    private var interstitial: GADInterstitialAd?

    private override init() {
        super.init()
        loadInterstitialAd()
    }

    func loadInterstitialAd() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: "ca-app-pub-9189227292179954/5678709181",
                               request: request,
                               completionHandler: { [weak self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            ad?.fullScreenContentDelegate = self
            self?.interstitial = ad
        })
    }

    func showInterstitialAd(from viewController: UIViewController) {
        if let interstitial = interstitial {
            interstitial.present(fromRootViewController: viewController)
        } else {
            print("Ad wasn't ready")
            loadInterstitialAd() // Reload the ad if it wasn't ready
        }
    }

    // MARK: - GADFullScreenContentDelegate methods

    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content with error: \(error.localizedDescription)")
        loadInterstitialAd() // Try to load a new ad after a failure
    }

    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad will present full screen content.")
    }

    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
        loadInterstitialAd() // Load the next ad after the current one has been closed
    }
}



