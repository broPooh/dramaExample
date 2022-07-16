//
//  SearchTestViewController.swift
//  dramaExample
//
//  Created by bro on 2022/07/16.
//

import UIKit
import SnapKit

enum Section: CaseIterable {
    case title
}

struct Sections<U: Hashable, T: Hashable>: Hashable {
    let headerItem: U
    let items: T
}

struct Header: Hashable {
    let titleHeader: String
}

class SearchTestViewController: UIViewController {
        
    var tvshows = [TvShow]()
    var dataSource: UICollectionViewDiffableDataSource<Section, TvShow>!
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        diffableTest()
        configureCustomSearchBar()
    }
    
    private func diffableTest() {
        //let snapshot = NSDiff
                
        self.dataSource = UICollectionViewDiffableDataSource<Section, TvShow>(collectionView: self.collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, tvShow: TvShow) -> UICollectionViewCell? in
            guard let searchCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else { fatalError("can not create cell") }
            searchCollectionViewCell.configureImage(tvShow: tvShow)
            return searchCollectionViewCell
        }
        
    }
        
    private func configureCollectionView() {
        self.navigationController?.navigationBar.barTintColor = .black
        collectionView.delegate = self
        //collectionView.dataSource = self
        collectionView.backgroundColor = .black
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
//        collectionView.register(SearchCollectionViewHeader.self,
//                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
//                                withReuseIdentifier: SearchCollectionViewHeader.reuseIdentifier)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureCustomSearchBar() {
        let searchBar = UISearchBar()
        self.navigationController?.navigationBar.topItem?.titleView = searchBar

        searchBar.delegate = self
        searchBar.setImage(UIImage(named: "icSearchNonW"), for: UISearchBar.Icon.search, state: .normal)
        searchBar.setImage(UIImage(named: "icCancel"), for: .clear, state: .normal)

        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.backgroundColor = .darkGray
        searchBar.searchTextField.leftView?.tintColor = .lightGray
        searchBar.searchTextField.rightView?.tintColor = .white
    }
    
    private func populateData(text: String?) {
        guard let text = text else { return }
        
        APIService().requestData(url: URL.searchTvShowsURL(text: text)) { (result: Result<TvShows, APIError>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    
                    print(response.results)
                    
                    var snapshot = NSDiffableDataSourceSnapshot<Section, TvShow>()
                    snapshot.appendSections([.title])
                    snapshot.appendItems(response.results, toSection: .title)
                    self.dataSource.apply(snapshot, animatingDifferences: false)
//                    self.tvshows = response.results.filter { $0.backdropPath != nil }
//                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
}


extension SearchTestViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchCollectionViewHeader.reuseIdentifier, for: indexPath) as! SearchCollectionViewHeader
//        return header
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = DetailViewController()
        controller.id = tvshows[indexPath.row].id
        controller.name = tvshows[indexPath.row].name
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
}


extension SearchTestViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        let height = (view.frame.height) / 4.5
        return CGSize(width: width, height: height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: view.frame.width, height: 50)
//    }
}

extension SearchTestViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        populateData(text: searchText)
    }
}

