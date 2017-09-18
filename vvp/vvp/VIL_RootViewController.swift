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
    fileprivate var _viuActivity: VIU_Activity?
    
    
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
        
        self._viuActivity = VIU_Activity()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        /*
        let isAuth: Bool = VIM_AuthData.current.isAutentified()
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
        */
        
        
        
        //DEBUG - to login
        //let vcLogin = storyboard?.instantiateViewController(withIdentifier: "vilLogin") as! VIL_LoginViewController
        //present(vcLogin, animated: false, completion: nil)
        //return
        //return
        
        //DEBUG - to menu
        //let vcMenu = self.storyboard?.instantiateViewController(withIdentifier: "vilNavMenu") as! VIL_MenuNavController
        //self.present(vcMenu, animated: false, completion: nil)
        //return
        //return
            
        
        //DEBUG - to stream
        //let sb = UIStoryboard.init(name: "Stream", bundle: nil)
        //let vcStream = sb.instantiateViewController(withIdentifier: "visStream") as! VIS_StreamViewController
        //present(vcStream, animated: true, completion: nil)
        //return
        //return
        
        
        self.myTask_Auth()
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
    
    
    //
    // My methods
    //
    
    private func myTask_Auth() -> Void
    {
        if let token = VIM_UserData.current.token
        {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            //self._viuActivity?.show()
        
            let viuRequest: VIU_Request = VIU_Request(cmd: "auth")
        
            viuRequest.addPostValue(token, forKey: "token")
            
            //DEBUG
            //viuRequest.addPostValue("2500", forKey: "_delay_")
        
            //DEBUG
            //print(viuRequest)
        
            let task = URLSession.shared.dataTask(
                with: viuRequest.urlRequest(),
                completionHandler:
                {
                    (data: Data?, response: URLResponse?, error: Error?) in
                
                    //
                    // completionHandler START
                    //
                    //
                
                    //DEBUG
                    //print("data: \(data)")
                    //print("response: \(response)")
                    //print("error: \(error)")
                
                    DispatchQueue.main.async()
                    {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        //self._viuActivity?.hide()
                        
                        if error != nil || response == nil || data == nil
                        {
                            VIU_UI.alertError(title: "URL Error", error: error, viewController: self)
                            return
                        }
                        
                        if (response as? HTTPURLResponse)!.statusCode / 100 != 2 || response!.mimeType != "application/json"
                        {
                            VIU_UI.alertError(title: "HTTP Error", errorMessage: "HTTP Error\nmime-type: \(response!.mimeType ?? "-")\nstatus-code: \((response as? HTTPURLResponse)!.statusCode)", viewController: self)
                            return
                        }
                        
                        do
                        {
                            let allJsonData: NSMutableDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableDictionary
                            
                            let json_code = allJsonData["code"] as! Int
                            //let json_mess = allJsonData["mess"] as! String
                            
                            //DEBUG
                            //print("JSON: \(allJsonData)")
                            //print("JSON_code: \(json_code); JSON_mess: \(json_mess)")
                            
                            if json_code != 0
                            {
                                //GOTO Login ControllView
                                let vcLogin = self.storyboard?.instantiateViewController(withIdentifier: "vilLogin") as! VIL_LoginViewController
                                self.present(vcLogin, animated: false, completion: nil)
                                return
                            }
                            
                            
                            
                            let json_data = allJsonData["data"] as! NSDictionary
                            VIM_AuthData.current.updateBy(json_data)
                            
                            VIM_UserData.current.token = VIM_AuthData.current.token
                            VIM_UserData.current.orgId = VIM_AuthData.current.org?.orgId
                            VIM_UserData.current.saveUserData()
                            
                            
                            /*
                            if VIM_AuthData.current.org != nil
                            {
                                //GOTO Menu ControllView
                                
                                let vcMenu = self.storyboard?.instantiateViewController(withIdentifier: "vilNavMenu") as! VIL_MenuNavController
                                self.present(vcMenu, animated: false, completion: nil)
                                
                                //let vcMenu = self.storyboard?.instantiateViewController(withIdentifier: "vilMenu") as! VIL_MenuViewController
                                //self.present(vcMenu, animated: false, completion: nil)
                            }
                            else
                            {
                                
                                
                                //GOTO Select Orgs ControllView
                                //TODO
                            }
                            */
                            
                            let vcMenu = self.storyboard?.instantiateViewController(withIdentifier: "vilNavMenu") as! VIL_MenuNavController
                            self.present(vcMenu, animated: false, completion: nil)
                            
                            
                        }
                        catch let jsonError as NSError
                        {
                            VIU_UI.alertError(title: "JSON Error", error: jsonError as Error, viewController: self)
                            return
                        }
                        
                    }
                
                    //
                    // completionHandler END
                    //
                    //
                }
            )
            task.resume()
        }
        else
        {
            //GOTO Login ControllView
            let vcLogin = self.storyboard?.instantiateViewController(withIdentifier: "vilLogin") as! VIL_LoginViewController
            self.present(vcLogin, animated: false, completion: nil)
        }
    }

}
