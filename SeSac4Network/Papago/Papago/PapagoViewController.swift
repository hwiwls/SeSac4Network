//
//  ViewController.swift
//  SeSac4Network
//
//  Created by hwijinjeong on 1/16/24.
//

import UIKit
import Alamofire

struct Papago: Codable {
    let message: PapagoResult
}

struct PapagoResult: Codable {
    let result: PapagoFinal
}

struct PapagoFinal: Codable {
    let srcLangType: String
    let tarLangType: String
    let translatedText: String
}

class PapagoViewController: UIViewController {
    
    @IBOutlet weak var srcBtn: UIButton!
    @IBOutlet weak var changeLangBtn: UIButton!
    @IBOutlet weak var trgBtn: UIButton!
    @IBOutlet weak var sourceTextView: UITextView!
    @IBOutlet weak var translateBtn: UIButton!
    @IBOutlet weak var targetLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        
        translateBtn.addTarget(self, action: #selector(translateButtonClicked), for: .touchUpInside)
    }

    func configView() {
        view.backgroundColor = .white
        navigationItem.title = "papagoooo"
    }
    
    /*
     1. 네트워크 통신 단절 상태
     2. API 콜수
     3. 번역 버튼 클릭 횟수. 텍스트 비교
     4. 텍스트 비교
     5. Loading View
     */
    @objc func translateButtonClicked() {
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.clientID,
            "X-Naver-Client-Secret": APIKey.clientSecret
        ]
        
        let parameters: Parameters = [
            "text": sourceTextView.text!,
            "source": "ko",
            "target": "en"
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers).responseDecodable(of: Papago.self) { response in
            switch response.result {
            case .success(let success):
                dump(success)
                
                self.targetLabel.text = success.message.result.translatedText
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    
    @IBAction func srcBtnClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SourceLangViewController") as! SourceLangViewController
    
//        vc.contents = list[indexPath.row].phoneResult
//        
//        vc.data = list[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func trgBtnClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TargetLangViewController") as! TargetLangViewController
        
//        // 2. vc가 가지고 있는 공간(프로퍼티)에 데이터 추가해주기
//        vc.contents = list[indexPath.row].phoneResult
//        
//        vc.data = list[indexPath.row]
        
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

