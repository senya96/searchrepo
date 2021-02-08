//
//  HistoryViewController.swift
//  SearchRepo
//
//  Created by Сергій Насінник on 08.02.2021.
//

//
//  RepositoriesViewController.swift
//  SearchRepo
//
//  Created by Сергій Насінник on 07.02.2021.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController {

    
    
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
    
    var historyArray: [History] = []
    
    func setupNavigationBar(){
        self.navigationItem.title = "History"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(RepositoryNameCell.self, forCellWithReuseIdentifier: "RepositoryNameCell")
        collectionView.register(RepositoryDescriptionCell.self, forCellWithReuseIdentifier: "RepositoryDescriptionCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        self.setupNavigationBar()
        self.historyArray = History.getAllHistory()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
}

// MARK: - UICollectionViewDataSource
extension HistoryViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if historyArray.count == 0 {
            self.collectionView.setEmptyMessage("History is empty", color: .white)
        } else {
            self.collectionView.restore()
        }
        return historyArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = indexPath.item == 0 ? "RepositoryNameCell" : "RepositoryDescriptionCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        let entry = historyArray[indexPath.section].repository!
        if let cell = cell as? RepositoryNameCell {
            cell.label.text = "\(entry.name)"
        } else if let cell = cell as? RepositoryDescriptionCell {
            cell.label.text = entry.repo_description ?? ""
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HistoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        
        if indexPath.item == 0 {
            return CGSize(width: width, height: 30)
        } else {
            let entry = historyArray[indexPath.section].repository!
            return RepositoryDescriptionCell.cellSize(width: width, text: entry.getShortDescription() ?? "")
        }
    }
}

