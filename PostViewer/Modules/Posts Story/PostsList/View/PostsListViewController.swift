//
//  PostsListViewController.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import UIKit

class PostsListViewController: UIViewController, PostsListViewInput, UITableViewDelegate {
    
    var output: PostsListViewOutput!

    @IBOutlet weak var tableView: UITableView!
    
    var tableViewDataDisplayManager: TableViewDataSource!
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        UIImageView.freeUpCachedMemory()
    }
    
    // MARK: - Actions
    
    @objc func logOutButtonPressed() {
        output.logOutPressed()
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
        output.didRefresh()
    }

    // MARK: - PostsListViewInput

    func setupInitialState() {
        
        tableView.registerCellNib(for: PostsListPostCellObject.self)
        tableView.registerCellNib(for: PostsListSpaceCellObject.self)
        
        // Set navigation bar style, title and log out button
        if let navigationController = navigationController {
            
            let navigationBar = navigationController.navigationBar
            navigationBar.barStyle = .blackOpaque
            navigationBar.isTranslucent = false
            navigationBar.barTintColor = #colorLiteral(red: 0.2705882353, green: 0.4, blue: 0.5568627451, alpha: 1)
            navigationBar.tintColor = .white
            navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
            
            navigationItem.title = StringsHelper.string(for: .postsListTitle)
            
            let logOutButtonItem = UIBarButtonItem(title: StringsHelper.string(for: .logOutButtonTitle),
                                                   style: .plain,
                                                   target: self,
                                                   action: #selector(logOutButtonPressed))
            navigationItem.rightBarButtonItem = logOutButtonItem
        }
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
    }
    
    func presentTable(with dataSource: TableViewDataSource) {
        
        tableViewDataDisplayManager = dataSource
        dataSource.assign(to: tableView)
        dataSource.delegate = self
        tableView.reloadData()
    }
    
    func getTableWidth() -> Int {
        let result = DispatchQueue.main.sync {
            return Int(view.bounds.width)
        }
        return result
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cellObject = tableViewDataDisplayManager.dataStructure.cellObject(at: indexPath)
        
        if cellObject is PostsListSpaceCellObject {
            return 8
        }
        else if let cellObject = cellObject as? PostsListPostCellObject {
            let height = cellObject.height(for: Int(tableView.bounds.width))
            return CGFloat(height)
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cellObjectWithId = tableViewDataDisplayManager.dataStructure.cellObject(at: indexPath) as? CellObjectWithId else {
            return
        }
        
        output.didSelectPost(with: cellObjectWithId.itemId)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (scrollView.contentSize.height - scrollView.contentOffset.y) < 1000 {
            output.loadMore()
        }
    }
}




