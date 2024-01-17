//
//  ViewController.swift
//  SeSac4Network
//
//  Created by hwijinjeong on 1/16/24.
//

import UIKit
import Alamofire

//success.message.result.translatedText

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

let languageDictionary: [String: String] = [
    "ko": "한국어",
    "en": "영어",
    "ja": "일본어",
    "zh-CN": "중국어 간체",
    "zh-TW": "중국어 번체",
    "vi": "베트남어",
    "id": "인도네시아어",
    "th": "태국어",
    "de": "독일어",
    "ru": "러시아어",
    "es": "스페인어",
    "it": "이탈리아어",
    "fr": "프랑스어"
]

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
        srcBtn.addTarget(self, action: #selector(srcBtnClicked), for: .touchUpInside)
        trgBtn.addTarget(self, action: #selector(trgBtnClicked), for: .touchUpInside)
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
    
    
    @objc func srcBtnClicked() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SourceLangViewController") as! SourceLangViewController
    
//        vc.contents = list[indexPath.row].phoneResult
//        
//        vc.data = list[indexPath.row]
        
        vc.langDic = languageDictionary
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func trgBtnClicked() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TargetLangViewController") as! TargetLangViewController
        
        vc.langDic = languageDictionary
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

