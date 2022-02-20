
import UIKit
import WebKit

class WebViewController: UIViewController {
  
  // MARK: - IBOutlet
  @IBOutlet weak var webView: WKWebView!
  
  // MARK: - Properties
  
  public var url = ""
  public var flag = false
  var titleString = ""
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    webView.navigationDelegate = self
    let request = URLRequest(url: URL(string: url)!)
    webView.load(request)
    webView.scrollView.showsHorizontalScrollIndicator = false
    webView.scrollView.showsVerticalScrollIndicator = false
    
    self.navigationController?.isNavigationBarHidden = false
    self.setNavigationBarImage(for: UIImage(), color: .white, requireShadowLine: true)
    setBackButton(tintColor: #colorLiteral(red: 0.01176470588, green: 0, blue: 0.2784313725, alpha: 1), isImage: true, #imageLiteral(resourceName: "ic_BackButton"))
    
    self.title = titleString
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.01176470588, green: 0, blue: 0.2784313725, alpha: 1), NSAttributedString.Key.kern: -0.41]
    
  }
  //MARK: BACK Button Tap Action
  override func backBtnTapAction() {
      self.dismiss(animated: true)
  }
}

//MARK: UIWebViewDelegate
extension WebViewController: WKNavigationDelegate {
  
  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    Global.showLoadingSpinner()
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    Global.dismissLoadingSpinner()
  }
  
  func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    Global.dismissLoadingSpinner()
    print(error)
  }
}
