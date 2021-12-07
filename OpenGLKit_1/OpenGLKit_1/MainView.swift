//
import UIKit
//import GLKit

class MainView: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    
    @IBAction func goToSquare(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SquareView") as? SquareView else {
            return
        }
        present(vc, animated: true)
    
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController = UIViewController()
//        viewController.view.backgroundColor = .blue
//        //let viewController = storyboard.instantiateViewController(withIdentifier: "SquareView") as! GLKViewController
//
//        UIApplication.shared.windows.first?.rootViewController = viewController
//
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
//        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//            let sceneDelegate = windowScene.delegate as? SceneDelegate
//          else {
//            return
//          }
//          let viewcontroller = UIViewController()
//          viewcontroller.view.backgroundColor = .blue
//          self.window?.rootViewController = viewcontroller
        
//        var  mainView = UIStoryboard(name:"Main", bundle: nil)
//        let viewcontroller : GLKViewController = mainView.instantiateViewController(withIdentifier: "SquareView") as! SquareView
//        sceneDelegate.window!.rootViewController = viewcontroller
        
       // let newVC = UIStoryboard?.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SquareView") as? SquareView
        //instantiateViewController(withIdentifier: "SquareView") as! SquareView;
        
      //  navigationController?.pushViewController(newVC, animated: true)
    }
    
    @IBAction func goToFox(_ sender: UIButton) {
    }
    
    @IBAction func goToCube(_ sender: UIButton) {
    }
}
