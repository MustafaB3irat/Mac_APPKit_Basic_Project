import  AppKit
import  MapKit
import CoreData

class UserDetailsViewController: NSViewController, MKMapViewDelegate {
    
    
    @IBOutlet private weak var username: NSTextField!
    @IBOutlet private weak var website: NSTextField!
    @IBOutlet private weak var email: NSTextField!
    @IBOutlet private weak var phone: NSTextField!
    @IBOutlet private weak var company: NSTextField!
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var addNoteBtn: NSButton!
    @IBOutlet private weak var note: NSTextField!
    
    var user: User? {
        didSet {
            if isViewLoaded {
                initUserData()
            }
        }
    }
    private lazy var userDetailsViewModel = UserDetailsViewModel(user: user)
  
    override func viewDidLoad() {
        super.viewDidLoad()
        if user != nil {
        initUserData()
        }
        
        
       // initUserNote()
      
    }

//    @IBAction func saveNoteBarBtnTapped(_ Sender: UIBarButtonItem) {
//        
//        var alert = UIAlertController(title: "New Note", message: "Add a new Note...", preferredStyle: .alert)
//        var saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] action in
//            
//            let textField = alert.textFields?.first
//            guard let noteText = textField?.text else {return}
//            self?.userDetailsViewModel.saveNote(noteText: noteText) { sucess in
//                if sucess {
//                    self?.note.text = noteText
//                }
//            }
//            
//        }
//        
//        if userDetailsViewModel.noteExist() {
//            
//            alert = UIAlertController(title: "Edit Note", message: "Edit existing Note...", preferredStyle: .alert)
//            
//            saveAction = UIAlertAction(title: "Edit", style: .default) { [weak self] action in
//                let textField = alert.textFields?.first
//                guard let noteText = textField?.text else {return}
//                self?.userDetailsViewModel.saveNote(noteText: noteText) { sucess in
//                    if sucess {
//                        self?.note.text = noteText
//                    }
//                }
//            }
//        }
//        
//        let cancelAction =  UIAlertAction(title: "Cancel", style: .cancel)
//        alert.addAction(saveAction)
//        alert.addAction(cancelAction)
//        alert.addTextField()
//        alert.textFields?.first?.text = userDetailsViewModel.getNote()?.content
//        present(alert, animated: true)
//    }
    
    private func initUserLocation() {
        
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
    
    
    private func initUserData() {
        
        
        guard let currentUser = userDetailsViewModel.user else {return}
        username.stringValue = currentUser.username
        //fullName.text = currentUser.name
        email.stringValue = currentUser.email
        phone.stringValue = currentUser.phone
        website.stringValue = currentUser.website
        company.stringValue = currentUser.company.name
      //  city.text = currentUser.address.city
        
        initUserLocation()
    }
    
    
    private func initUserNote() {
        if userDetailsViewModel.noteExist() {
            //let note = userDetailsViewModel.getNote()
           // self.note.stringValue = note?.content
           // addNoteBtn.image = NSImage(na)
        }
    }
}

