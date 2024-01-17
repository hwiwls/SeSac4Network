//
//  ViewController.swift
//  SeSac4Network
//
//  Created by hwijinjeong on 1/16/24.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var sourceTextView: UITextView!
    @IBOutlet weak var translateBtn: UIButton!
    @IBOutlet weak var targetLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        translateBtn.addTarget(self, action: #selector(translateButtonClicked), for: .touchUpInside)
    }

    @objc func translateButtonClicked() {
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "DBkaEFqS6qpUD_vbh5cR",
            "X-Naver-Client-Secret": "9ViuwgHtpD"
        ]
        
        let parameters: Parameters = [
            "text": sourceTextView.text!,
            "source": "ko",
            "target": "en"
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers)
    }

}

