import  UIKit

class UserDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var website: UILabel!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUserData()
    }
    
    private func initUserData() {
        username.text = user?.username ?? "Mustafa"
        fullName.text = user?.fullName ?? "Mustafa B'irat"
        email.text = user?.email ?? "sample@gmail.com"
        phone.text = user?.phone ?? "0598******"
        website.text = user?.website ?? "www.steveblogs.com"
    }
    
}
