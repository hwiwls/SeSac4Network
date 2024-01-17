//
//  BookViewController.swift
//  SeSac4Network
//
//  Created by hwijinjeong on 1/17/24.
//

import UIKit
import Alamofire
import Kingfisher

struct Book: Codable {
    let documents: [Document]
    let meta: Meta
}

// MARK: - Document
struct Document: Codable {
    let authors: [String]
    let contents, datetime, isbn: String
    let price: Int
    let publisher: String
    let salePrice: Int
    let status: String
    let thumbnail: String
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case authors, contents, datetime, isbn, price, publisher
        case salePrice = "sale_price"
        case status, thumbnail, title, url
    }
}

// MARK: - Meta
struct Meta: Codable {
    let isEnd: Bool
    let pageableCount, totalCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}

class BookViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var bookCollectionView: UICollectionView!
    
    var originalDocuments: [Document] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        configureView()
    }
    
    func configureView() {
        let xib = UINib(nibName: "BookCollectionViewCell", bundle: nil)
        bookCollectionView.register(xib, forCellWithReuseIdentifier: "BookCollectionViewCell")
        
        bookCollectionView.delegate = self
        bookCollectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()   // 여러행, 여러열
        let spacing: CGFloat = 20
        let cellWidth = UIScreen.main.bounds.width - spacing * 3
        layout.itemSize = CGSize(width: cellWidth / 2, height: cellWidth / 2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        
        bookCollectionView.collectionViewLayout = layout
    }
    
    func callRequest(text: String) {
        // 만약 한글 검색이 안된다면 인코딩 처리
        
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = "https://dapi.kakao.com/v3/search/book?query=\(query)"
        
        let headers: HTTPHeaders = [
            "Authorization": APIKey.kakao
        ]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: Book.self) { response in
            switch response.result {
            case .success(let success):
                self.originalDocuments = success.documents
                self.bookCollectionView.reloadData()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}

extension BookViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        callRequest(text: searchBar.text!)
        searchBar.resignFirstResponder()
    }
}

extension BookViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return originalDocuments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell" , for: indexPath) as! BookCollectionViewCell
        
        let document = originalDocuments[indexPath.row]
        cell.titleLabel.text = document.title
        cell.priceLabel.text = String(document.price)
        
        let url = URL(string: document.thumbnail)
        cell.thumbnailImageView.kf.setImage(with: url)
        
        return cell
    }
}
