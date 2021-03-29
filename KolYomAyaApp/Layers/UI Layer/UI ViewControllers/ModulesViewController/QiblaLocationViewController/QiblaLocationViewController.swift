//
//  QiblaLocationViewController.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/27/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//



import UIKit
import MapKit
import CoreLocation
import GoogleMobileAds
func DegreesToRadians (value:Double) -> Double {
    return value * Double.pi / 180.0
}

func RadiansToDegrees (value:Double) -> Double {
    return value * 180.0 / Double.pi
}

class QiblaLocationViewController: BaseViewController {

    var needleAngle : Double = 0.0
    @IBOutlet weak var ivCompassBack: UIImageView!
    @IBOutlet weak var ivCompassNeedle: UIImageView!
    
//    @IBOutlet weak var mapView: MKMapView!
//    var kabahLocation : CLLocation?
//    var latitude  : Double?
//    var longitude : Double?
//    var distanceFromKabah : Double?
//
//    let locationManger = CLLocationManager()
    
    var compassManager  : CompassDirectionManager!

    var interstitial: GADInterstitial!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initializeNavigationBarAppearanceWithBack(viewController: HomeViewController(), titleHeader: "اتجاه القبلة")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        compassManager =  CompassDirectionManager(dialerImageView: ivCompassBack, pointerImageView: ivCompassNeedle)
        compassManager.initManager()
//        kabahLocation = CLLocation(latitude: 21.42 , longitude: 39.83)
//
//        self.locationManger.delegate = self
//        self.locationManger.desiredAccuracy = kCLLocationAccuracyBest
//        if #available(iOS 8.0, *) {
//            self.locationManger.requestAlwaysAuthorization()
//        } else {
//            // Fallback on earlier versions
//        }
//
//        self.locationManger.startUpdatingLocation()
//        self.locationManger.startUpdatingHeading()
//
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-5809306835538408/9594496790")
        interstitial.delegate = self
        let request = GADRequest()
        interstitial.load(request)
        print(#function, "shouldDisplayAd", self.shouldDisplayAd, "isAdReady", self.isAdReady)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: - LocationManger Delegate
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location = locations.last
////        let center = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
//        print("current location latitude \((location?.coordinate.latitude)!) and longitude \((location?.coordinate.longitude)!)")
//
//        self.latitude = location?.coordinate.latitude
//        self.longitude = location?.coordinate.longitude
////
////        self.latitude = 31.5497
////        self.longitude = 74.3436
//        self.locationManger.startUpdatingLocation()
//        needleAngle     = self.setLatLonForDistanceAndAngle(userlocation: location!)
//
////    }
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Error " + error.localizedDescription)
//
//    }
    
//    func setLatLonForDistanceAndAngle(userlocation: CLLocation) -> Double
//    {
//        let lat1 = DegreesToRadians(value: userlocation.coordinate.latitude)
//        let lon1 = DegreesToRadians(value: userlocation.coordinate.longitude)
//        let lat2 = DegreesToRadians(value: kabahLocation!.coordinate.latitude)
//        let lon2 = DegreesToRadians(value: kabahLocation!.coordinate.longitude)
//
//        distanceFromKabah = userlocation.distance(from: kabahLocation!)
//        let dLon = lon2 - lon1;
//        let y = sin(dLon) * cos(lat2)
//        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
//        var radiansBearing = atan2(y, x)
//        if(radiansBearing < 0.0)
//        {
//            radiansBearing += 2 * Double.pi ;
//        }
////        print("Initial Bearing \(radiansBearing*180/M_PI)")
//        let distanceFromKabahUnit  = 0.0
//
//
//
//        return radiansBearing
//
//    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
//
//        let needleDirection   = -newHeading.trueHeading;
//        let compassDirection  = -newHeading.magneticHeading;
//
//        self.needle.transform = CGAffineTransform(rotationAngle: CGFloat(((Double(needleDirection) * Double.pi) / 180.0) + needleAngle  ))
//        print("Needle \(CGAffineTransform(rotationAngle: CGFloat(((Double(needleDirection) * Double.pi) / 180.0) + needleAngle)))")
//        self.composs.transform = CGAffineTransform(rotationAngle: CGFloat((Double(compassDirection) * Double.pi) / 180.0))
//        print("composs \(CGAffineTransform(rotationAngle: CGFloat((Double(compassDirection) * Double.pi) / 180.0)))")
//    }
//
     func viewDidAppear(animated: Bool) {
        needleAngle = 0.0
//        self.locationManger.startUpdatingHeading()
//        kabahLocation = CLLocation(latitude: 21.42 , longitude: 39.83)
//        self.locationManger.delegate = self
        
    }
//     func viewDidDisappear(animated: Bool) {
//        self.locationManger.delegate = nil
//    }
    private var shouldDisplayAd = true
    
    private var isAdReady:Bool = false {
        didSet {
            if isAdReady && shouldDisplayAd {
                displayAd()
            }
        }
    }
 
    private func displayAd() {
        print(#function, "ad ready", interstitial.isReady)
        if (interstitial.isReady) {
            shouldDisplayAd = false
            interstitial.present(fromRootViewController: self)
        }
    }
    func createAndLoadInterstitial() -> GADInterstitial {
        interstitial = GADInterstitial(adUnitID: Keys.adsInterstitial)
        interstitial.delegate = self
        interstitial.load(GADRequest())
        shouldDisplayAd = false
        return interstitial
    }
    
    

}



extension QiblaLocationViewController: GADInterstitialDelegate {
    /// Tells the delegate an ad request failed.
    func interstitialDidFail(toPresentScreen ad: GADInterstitial) {
        print(#function, "ad ready", interstitial.isReady)
    }
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print(#function, "ad ready", interstitial.isReady)
        isAdReady = true
    }
    
    //Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print("interstitialWillDismissScreen")
    }
    
    //Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        print("interstitialDidDismissScreen")
        //        present(self, animated: true)
        dismiss(animated: true, completion: nil)
        interstitial = createAndLoadInterstitial()
        print(#function, "shouldDisplayAd", shouldDisplayAd, "isAdReady", isAdReady)
    }
}
