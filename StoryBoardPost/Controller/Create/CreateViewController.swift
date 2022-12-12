//
//  CreateViewController.swift
//  StoryBoardPost
//
//  Created by Mirzabek on 10/12/22.
//

import UIKit

class CreateViewController: BaseViewController {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var bodyField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    
    // MARK: - Methods
    
    func initViews() {
        initNavigation()
    }
    
    func initNavigation() {
        title = "Create new post"
    }
    
    func apiPostCreate(post: Post) {
        showProgress()
        AFHttp.post(url: AFHttp.API_POST_CREATE, params: AFHttp.paramsPostCreate(post: post), handler: { response in
            self.hideProgress()
            switch response.result {
            case .success:
                self.navigationController?.popViewController(animated: true)
                print(response.result)
            case let .failure(error):
                print(error)
            }
        })
    }
    
    // MARK: - Actions
    
    @IBAction func createButton(_ sender: Any) {
        apiPostCreate(post: Post(title: titleField.text!, body: bodyField.text!))
    }
    
}
