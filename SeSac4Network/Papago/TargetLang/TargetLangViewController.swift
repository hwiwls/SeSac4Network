//
//  TargetLangViewController.swift
//  SeSac4Network
//
//  Created by hwijinjeong on 1/17/24.
//

import UIKit

class TargetLangViewController: UIViewController {
    
    @IBOutlet weak var trgLangTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        trgLangTableView.backgroundColor = .clear
        configTableView()
    }
    
}

extension TargetLangViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TargetLangTableViewCell", for: indexPath) as! TargetLangTableViewCell
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func configTableView() {
        trgLangTableView.delegate = self
        trgLangTableView.dataSource = self
        
        let xib = UINib(nibName: "TargetLangTableViewCell", bundle: nil)
        trgLangTableView.register(xib, forCellReuseIdentifier: "TargetLangTableViewCell")
    }
    
    
}
