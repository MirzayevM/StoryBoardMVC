//
//  HomeViewController.swift
//  StoryBoardPost
//
//  Created by Mirzabek on 10/12/22.
//

import UIKit

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var items : Array<Post> = Array()
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        
    }
    
    func refreshTableView(posts:[Post]){
        self.items = posts
        self.tableView.reloadData()
        
    }

    func apiPostList(){
        showProgress()
        AFHttp.get(url: AFHttp.API_POST_LIST, params: AFHttp.paramsEmpty(), handler: { response in
            self.hideProgress()
            switch response.result{
            case .success:
                let posts = try! JSONDecoder().decode([Post].self, from: response.data!)
                self.refreshTableView(posts: posts)
            case let .failure(error):
                print(error)
            }
            
        })
    }
    
    func apiPotDelete(post:Post){
        showProgress()
        
        AFHttp.del(url: AFHttp.API_POST_DELETE + post.id!, params: AFHttp.paramsEmpty(), handler: { response in
            self.hideProgress()
            switch response.result{
            case .success:
                print(response.result)
                self.apiPostList()
                
            case let .failure(error):
                print(error)
            }
            
        })
        
    }

 

    
    // MARK: - Method
    func initView(){
        
        tableView.dataSource = self
        tableView.delegate = self
        initNavigation()
        apiPostList()
        
   
    }
    
    func initNavigation() {
        let refresh = UIImage(systemName: "goforward")
        let addPerson = UIImage(systemName: "person.crop.circle.fill.badge.plus")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: refresh, style: .plain, target: self, action: #selector(leftTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: addPerson, style: .plain, target: self, action: #selector(rightTapped))
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .blue
        
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.shadowImage = UIImage()
        
        title = "Storyboard Post MVC"
    }
    
    
    func callCreateViewController() {
        let vc = CreateViewController(nibName: "CreateViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func callEditViewController(post: Post){
        let vc = EditViewController(nibName: "EditViewController", bundle: nil)
        vc.post = post
        self.navigationController?.present(vc, animated: true)

    }
    
    
    // MARK: - Actions
    @objc func leftTapped(){
        apiPostList()
    }
    @objc func rightTapped(){
        callCreateViewController()
        
    
    }
    
    // MARK: - tableView
    
    func tableView(_ tableView:UITableView,numberOfRowsInSection section: Int) -> Int{
        return items.count
    }
    
    func tableView(_ tableView:UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let item = items[indexPath.row]
        let cell = Bundle.main.loadNibNamed("PostTableViewCell", owner: self,options: nil)?.first as! PostTableViewCell
        
        cell.titleLabel.text = item.title
        cell.bodyLabel.text = item.body
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        return UISwipeActionsConfiguration(actions:[
            makeCompleteContextualAction(forRowAt: indexPath, post:items[indexPath.row])
        ])
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        return UISwipeActionsConfiguration(actions:[
            makeDeleteContextualAction(forRowAt: indexPath, post:items[indexPath.row])
        ])
    }
    
    private func makeDeleteContextualAction(forRowAt indexPath: IndexPath, post: Post) -> UIContextualAction{
        return UIContextualAction(style: .destructive, title: "delete"){ [self] (action, swipeButtonView, completion) in
            print("Delete")
            completion(true)
            self.apiPotDelete(post: post)
            
        }
    }
    private func  makeCompleteContextualAction(forRowAt indexPath: IndexPath, post: Post) -> UIContextualAction{
        return UIContextualAction(style: .destructive, title: "Edit"){ (action, swipeButtonView, completion) in
            print("Complete here")
            completion(true)
            self.callEditViewController(post: post)
            
        }
    }
   
}
