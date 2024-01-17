//
//  SourceLangViewController.swift
//  SeSac4Network
//
//  Created by hwijinjeong on 1/17/24.
//

import UIKit

class SourceLangViewController: UIViewController {
    
    @IBOutlet weak var srcLangTableView: UITableView!
    
    var langDic: [String: String] = ["ko": "한국어"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        srcLangTableView.backgroundColor = .clear
        configTableView()
        print(langDic)
    }
}

extension SourceLangViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SourceLangTableViewCell", for: indexPath) as! SourceLangTableViewCell
        
        let languageValues = Array(languageDictionary.values)
        let languageValue = languageValues[indexPath.row]
        
        cell.srcLangLabel?.text = languageValue
        
        return cell
    }
    
    func configTableView() {
        srcLangTableView.delegate = self
        srcLangTableView.dataSource = self
        
        let xib = UINib(nibName: "SourceLangTableViewCell", bundle: nil)
        srcLangTableView.register(xib, forCellReuseIdentifier: "SourceLangTableViewCell")
    }
    
    
}
