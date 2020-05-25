import  UIKit
import  MessageUI
import  MapKit

class UserDetailsViewController: UIViewController, MFMailComposeViewControllerDelegate, MKMapViewDelegate {
    
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
        }
    }
    
    
    
    private var mailComposer = MFMailComposeViewController() {
        didSet {
            mailComposer.mailComposeDelegate = self
        }
    }
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUserData()
    }
    
    private func initUserData() {
       
        guard let currentUser = user else {return}
        
        username.text = currentUser.username
        fullName.text = currentUser.name
        email.text = currentUser.email
        phone.text = currentUser.phone
        website.text = currentUser.website
        companyName.text = currentUser.company.name
        city.text = currentUser.address.city
        
        initUserLocation()
    }
    
    
    @IBAction func sendEmail(_ Sender: UILabel) {
           print("phone clicked!")
        if MFMailComposeViewController.canSendMail(), let recipent = email.text {
            mailComposer.setToRecipients([recipent])
            self.present(mailComposer, animated: true, completion: nil)
        }
    }

    @IBAction func dialUpPhone(_ sender: UILabel) {
     
        guard let phoneNo = phone.text?.components(separatedBy: " ")[0] else {return}
        guard let url = URL(string: "tel:\(phoneNo)") else {return}
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    @IBAction func openUserWebsite(_ Sender: UILabel) {
        guard let website = user?.website else {return}
        guard let url = URL(string: website) else {return}
        UIApplication.shared.open(url)
    }
    
    func initUserLocation() {
        
        guard let lat = user?.address.geo.lat else {return}
        guard let lng = user?.address.geo.lng else {return}
        guard let latDegrees = CLLocationDegrees(lat) else {return}
        guard let lngDegrees =  CLLocationDegrees(lng) else {return}
        let coordiantes = CLLocationCoordinate2D(latitude: latDegrees, longitude: lngDegrees)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordiantes
        mapView.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        mapView.setRegion(region, animated: true)
    }
    
}

