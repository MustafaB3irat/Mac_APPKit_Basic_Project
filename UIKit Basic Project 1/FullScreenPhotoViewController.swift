import UIKit

class FullScreenPhotoViewController: UIViewController {
    
    
    @IBOutlet weak var fullScreenImage: UIImageView!
    
    var imageURL: String?
    
    override func viewDidLoad() {
        fullScreenImage.setNetworkImage(imageURL)
    }

    @IBAction func dismissView(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}

