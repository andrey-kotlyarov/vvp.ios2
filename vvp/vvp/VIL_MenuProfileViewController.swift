//
//  VIL_MenuProfileViewController.swift
//  vvp
//
//  Created by Kotlyarov Andrey on 11.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit

class VIL_MenuProfileViewController: UIViewController
{
    
    @IBOutlet var lblFullName: UILabel!
    @IBOutlet var lblNickname: UILabel!
    
    @IBOutlet var btnLogout: UIButton!
    

    @IBAction func btnLogout_OnTouchUp(_ sender: Any)
    {
        //print("LOGOUT here")
        
        /*
        let sb = UIStoryboard.init(name: "Stream", bundle: nil)
        let vcStream = sb.instantiateViewController(withIdentifier: "visStream") as! VIS_StreamViewController
        self.present(vcStream, animated: true, completion: nil)
        */
        
        VIM_AuthData.current.clearAuthData()
        VIM_UserData.current.clearUserData()
        
        let vcLogin = self.storyboard?.instantiateViewController(withIdentifier: "vilLogin") as! VIL_LoginViewController
        self.present(vcLogin, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.tintColor = VIM_DesignData.current.colorTint
        
        self.navigationItem.title = "Profile"
        
        //let btnBack = UIBarButtonItem(title: "< VVPass", style: .plain, target: self, action: #selector(btnNavBack))
        ////btnBack.style = .done
        //self.navigationItem.leftBarButtonItem = btnBack
        
        lblFullName.text = "\(VIM_AuthData.current.profile!.firstName) \(VIM_AuthData.current.profile!.lastName)"
        lblNickname.text = "\(VIM_AuthData.current.profile!.username)"
    }
    
    func btnNavBack()
    {
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
