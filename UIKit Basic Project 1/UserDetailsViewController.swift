import  UIKit

class UserDetailsViewController: UIViewController {
  
  
  @IBOutlet var username: UILabel!
  @IBOutlet var fullName: UILabel!
  @IBOutlet var email: UILabel!
  @IBOutlet var phone: UILabel!
  @IBOutlet var website: UILabel!
  
  var user: User?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    username.text = user?.username ?? "Mustafa"
    fullName.text = user?.fullName ?? "Mustafa B'irat"
    email.text = user?.email ?? "sample@gmail.com"
    phone.text = user?.phone ?? "0598******"
    website.text = user?.website ?? "www.steveblogs.com"
    
  }
  
}
