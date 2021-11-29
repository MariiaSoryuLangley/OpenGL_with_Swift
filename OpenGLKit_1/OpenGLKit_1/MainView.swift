//
import UIKit

class MainView: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func goToSquare(_ sender: UIButton) {
        let newVC = storyboard?.instantiateViewController(withIdentifier: "SquareView") as! SquareView;
        
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    @IBAction func goToFox(_ sender: UIButton) {
    }
    
    @IBAction func goToCube(_ sender: UIButton) {
    }
}
