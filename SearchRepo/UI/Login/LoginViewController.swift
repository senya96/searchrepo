//
//  LoginViewController.swift
//  SearchRepo
//
//  Created by Сергій Насінник on 07.02.2021.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    let oAuthService: OAuthService
    init(oAuthService: OAuthService) {
        self.oAuthService = oAuthService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.setNavigationBarHidden(true, animated: true)
        oAuthService.onAuthenticationResult = { [weak self] in self?.onAuthenticationResult(result: $0) }
    }
    
    
    @IBAction func onLoginClick(_ sender: Any) {
        guard let url = oAuthService.getAuthPageUrl(state: "state") else { return }
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.modalPresentationStyle = .fullScreen
        present(safariVC, animated: true, completion: nil)
    }
    
    func onAuthenticationResult(result: Result<TokenBag, Error>) {
        DispatchQueue.main.async {
            self.presentedViewController?.dismiss(animated: true) {
                switch result {
                case .success( _):
                    let vc = RepositoriesViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    //self.navigationController?.modalPresentationStyle = .fullScreen
                    //self.present(nav, animated: true)
                case .failure:
                    let alert = UIAlertController(title: "Something went wrong :(",
                                                  message: "Authentication error",
                                                  preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }

}
