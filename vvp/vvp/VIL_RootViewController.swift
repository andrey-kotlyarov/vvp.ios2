//
//  VIL_RootViewController.swift
//  vvp
//
//  Created by Kotlyarov Andrey on 06.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit

class VIL_RootViewController: UIViewController
{
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //CREATE gradient
        //
        //
        let gradient : CAGradientLayer = CAGradientLayer()
        
        let size: CGFloat = max(self.view.bounds.width, self.view.bounds.height)
        gradient.frame = CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y, width: size, height: size)
        //gradient.frame = self.view.bounds
        
        let cor1: CGColor = VIM_DesignData.current.colorBG_L.cgColor
        let cor2: CGColor = VIM_DesignData.current.colorBG_D.cgColor
        let arrayColors = [cor1, cor2]
        
        gradient.colors = arrayColors
        self.view.layer.insertSublayer(gradient, at: 0)
        //
        //
        //
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        var isAuth: Bool = true
        
        
        if !isAuth
        {
            // IF NON AUTH
            let vcLogin = storyboard?.instantiateViewController(withIdentifier: "vilLogin") as! VIL_LoginViewController
            present(vcLogin, animated: false, completion: nil)
        }
        else
        {
            // IF AUTH
            let vcMenu = storyboard?.instantiateViewController(withIdentifier: "vilMenu") as! VIL_MenuViewController
            present(vcMenu, animated: false, completion: nil)
        }
        
        
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
