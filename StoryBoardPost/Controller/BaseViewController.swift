//
//  BaseViewController.swift
//  StoryBoardPost
//
//  Created by Mirzabek on 10/12/22.
//

import UIKit
import JGProgressHUD
class BaseViewController: UIViewController {

    let hud = JGProgressHUD()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    func apDelegate()-> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
        
    }
    func sceneDelegate()-> SceneDelegate{
        return ((UIApplication.shared.connectedScenes.first!.delegate as? SceneDelegate)!)
        
    }
    
    func showProgress(){
        if !hud.isVisible{
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
        }
        
    }
    func hideProgress(){
        if hud.isVisible{
            hud.dismiss()
        }
    }

}
