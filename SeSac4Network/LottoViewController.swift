//
//  LottoViewController.swift
//  SeSac4Network
//
//  Created by hwijinjeong on 1/16/24.
//

import UIKit

struct Lotto: Codable {
    let drwNo: Int
    let drwNoDate: String
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
}

class LottoViewController: UIViewController {
    
    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    let manager = LottoAPIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        manager.callRequest(number: "1102") { value in // value에 로또 번호가 들어간다
            self.dateLabel.text = value
        }
    }
    
    @IBAction func textFieldReturnTapped(_ sender: UITextField) {
        manager.callRequest(number: numberTextField.text!) { value in
            self.dateLabel.text = value
        }
    }
}
