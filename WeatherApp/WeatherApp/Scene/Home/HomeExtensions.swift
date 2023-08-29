import UIKit
import CoreLocation

extension HomeViewController: CLLocationManagerDelegate {
    override func viewDidAppear(_ animated: Bool) {
        determineCurrentLocation()
    }
    private func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.startUpdatingLocation()
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error - locationManager: \(error.localizedDescription)")
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            //kullanıcı konuma izin verdiyse:
        case .authorizedAlways , .authorizedWhenInUse:
            print("authorized always and when in use")
            break
            //kullanıcı konum iznini reddettiyse:
        case .denied:
            print("authorized denied or restricted")
            break
        default:
            break
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        usersCurrentLatitude = location.coordinate.latitude
        usersCurrentLongitude = location.coordinate.longitude
        //kullanicinin konumunu sonradan pinliyorum çünkü diğer pinleri koymadan zoomluyordu ve region'ı ayarlayamıyordum.
        guard !didPerformGeocode else { return }
        // otherwise, update state variable, stop location services and start geocode
        didPerformGeocode = true
        locationManager.stopUpdatingLocation()
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            let placemark = placemarks?.first
            // if there's an error or no placemark, then exit
            guard error == nil && placemark != nil else {
                print(error!)
                return
            }
            let city = placemark?.locality ?? ""
            let state = placemark?.administrativeArea ?? ""
            self.usersLocation = ("\(city), \(state)")
            print("Kullanıcı burada \(self.usersLocation)")
            self.userCurrentCity = state.lowercased()
            self.getData(city: state)
        }
    }
}
