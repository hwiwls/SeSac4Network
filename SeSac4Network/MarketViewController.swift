//
//  MarketViewController.swift
//  SeSac4Network
//
//  Created by hwijinjeong on 1/16/24.
//

import UIKit
import Alamofire

struct Market: Codable {
    let market: String
    let korean_name: String
    let english_name: String
}

class MarketViewController: UIViewController {
    
    @IBOutlet var marketTableView: UITableView!
    
    var list: [Market] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        callRequest()
        configureTableView()
    }
    
    func configureTableView() {
        marketTableView.delegate = self
        marketTableView.dataSource = self
    }
    
    func callRequest() {
        let url = "https://api.upbit.com/v1/market/all"
        
        AF.request(url, method: .get).validate(statusCode: 200..<501).responseDecodable(of: [Market].self) {  response in
            switch response.result {
            case .success(let success):
                dump(success)
                self.list = success
                
                if response.response?.statusCode == 200 {
                    self.list = success
                    
                    self.marketTableView.reloadData()
                } else if response.response?.statusCode == 500 {
                    print("오류가 발생해써요")
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}

extension MarketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "marketCell")!
        
        let data = list[indexPath.row]
        
        cell.textLabel?.text = data.korean_name
        cell.detailTextLabel?.text = data.market
        
        return cell
    }
}
