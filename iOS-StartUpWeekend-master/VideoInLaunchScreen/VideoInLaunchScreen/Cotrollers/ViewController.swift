import UIKit




class ViewController: UIViewController {

    
    

    
    
   override func viewDidLoad() {
    super.viewDidLoad()
    
    
    var indicator = UIActivityIndicatorView()
    
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 200))
        indicator.style = UIActivityIndicatorView.Style.gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    indicator.startAnimating()
    indicator.backgroundColor = UIColor.white
     
      
    }
    


}

