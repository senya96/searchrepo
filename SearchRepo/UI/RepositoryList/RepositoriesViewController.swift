//
//  RepositoriesViewController.swift
//  SearchRepo
//
//  Created by Сергій Насінник on 07.02.2021.
//

import UIKit
import SafariServices

class RepositoriesViewController: UIViewController {
    let loader = RepositoryLoader()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .black
        view.alwaysBounceVertical = true
        return view
    }()
    
    func setupNavigationBar(){
        
        self.navigationItem.title = "Repositories"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(pushSearchBarButtonAction(_:)))
    }
    
    func search(_ query: String){
        let queryString: String = query.replacingOccurrences(of: " ", with: "")
        if queryString.count > 0{
            self.navigationItem.title = "Search: \(query)"
            self.loader.load(query) {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    @objc func pushSearchBarButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "Search", message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter search query"
                    
        }
        
        let searchAction = UIAlertAction(title: "Search", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
            let textField = alert.textFields![0] as UITextField
            self.search(textField.text ?? "")
        })
        
        alert.addAction(searchAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(RepositoryNameCell.self, forCellWithReuseIdentifier: "RepositoryNameCell")
        collectionView.register(RepositoryDescriptionCell.self, forCellWithReuseIdentifier: "RepositoryDescriptionCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        self.setupNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
}

// MARK: - UICollectionViewDataSource
extension RepositoriesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return loader.entries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = indexPath.item == 0 ? "RepositoryNameCell" : "RepositoryDescriptionCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        let entry = loader.entries[indexPath.section]
        if let cell = cell as? RepositoryNameCell {
            cell.label.text = "\(entry.full_name) (stars: \(entry.stargazers_count))"
        } else if let cell = cell as? RepositoryDescriptionCell {
            cell.label.text = entry.description
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RepositoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        if indexPath.item == 0 {
            return CGSize(width: width, height: 30)
        } else {
            let entry = loader.entries[indexPath.section]
            return RepositoryDescriptionCell.cellSize(width: width, text: entry.description ?? "")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let repository = loader.entries[indexPath.section]
        
        let safariVC = SFSafariViewController(url: URL(string: repository.html_url)!)
        safariVC.modalPresentationStyle = .fullScreen
        present(safariVC, animated: true, completion: nil)
    }
}

