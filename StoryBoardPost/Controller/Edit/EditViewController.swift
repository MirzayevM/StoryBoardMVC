//
//  EditViewController.swift
//  StoryBoardPost
//
//  Created by Mirzabek on 10/12/22.
//


import UIKit

class EditViewController: BaseViewController {
    
    @IBOutlet weak var TitleFileds: UITextField!
    @IBOutlet weak var BodyFileds: UITextField!
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TitleFileds.text = post?.title
        BodyFileds.text = post?.body
        
        initNavigation()
    }
    
// MARK: - Methods
    func initNavigation() {
        title = "Edit Post MVC"
    }
    
    func apiPostUpdate(post: Post) {
        showProgress()
        AFHttp.put(url: AFHttp.API_POST_UPDATE + post.id!, params: AFHttp.paramsPostUpdate(post: post), handler: { response in
            self.hideProgress()
            switch response.result  {
            case .success:
                print(response.result)
            case let .failure(error):
                print(error)
            }
        })
    }
// MARK: - Actions

    @IBAction func buttonSend(_ sender: Any) {
        let post1 = Post(id: (post?.id!)!, title: TitleFileds.text!, body: BodyFileds.text!)
        apiPostUpdate(post: post1)
        
        dismiss(animated: true, completion: nil)
    }
}
