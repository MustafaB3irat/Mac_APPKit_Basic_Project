import AppKit

class FullScreenPhotoViewController: NSViewController {
    
    
    @IBOutlet weak var fullScreenImage: NSImageView!
    
    var imageURL: String? {
        didSet {
            if isViewLoaded {
                fullScreenImage.setImage(imageURL ?? "")
            }
        }
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        view.window?.toggleFullScreen(self)
        if imageURL != nil {
            fullScreenImage.setImage(imageURL ?? "")
        }
    }
}

