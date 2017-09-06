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
        
        
        self.myLoadAuthData()
        
        //DEBUG
        let vcLogin = storyboard?.instantiateViewController(withIdentifier: "vilLogin") as! VIL_LoginViewController
        present(vcLogin, animated: false, completion: nil)
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
    
    fileprivate func myDidError(_ error: NSError)
    {
        //TODO
        /*
        self._jeuAlertView = JEU_AlertView(title: ""/*[error domain]*/, message: error.localizedDescription, delegate: self, cancelButtonTitle: "Retry")
        self._jeuAlertView?.show()
        */
        return
    }
    
    fileprivate func myLoadAuthData()
    {
        //DEBUG
        //return
        /*
        if JEM_UserData.currentUserData().token == nil
        {
            self.performSegue(withIdentifier: "jeLaunchToLogin", sender: self)
        }
        else
        {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            self._jeuActivity?.showWithAlpha(0.0)
            
            
            let jeuRequest: JEU_Request = JEU_Request(cmd: "getAuthData")
            
            jeuRequest.addPostValue(JEM_UserData.currentUserData().token!, forKey: "token")
            jeuRequest.addPostValue(String(JEM_UserData.currentUserData().orgId), forKey: "orgid")
            jeuRequest.addPostValue(String(JEM_Design.currentDesign().sizeType), forKey: "sizetype")
            
            //debug
            //jeuRequest.addPostValue(val: "2500", forKey: "_delay_")
            
            
            //
            //
            //
            
            NSURLConnection.sendAsynchronousRequest(
                jeuRequest.urlRequest() as URLRequest,
                queue: OperationQueue.main,
                //completionHandler:{ (response: NSURLResponse!, data: NSData!, connectionError: NSError?) -> Void in
                completionHandler:{ (response: URLResponse?, data: Data?, connectionError: NSError?) -> Void in
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self._jeuActivity?.hide()
                    
                    if connectionError != nil
                    {
                        self.myDidError(connectionError!)
                        return
                    }
                    
                    let httpResponse: HTTPURLResponse = response as! HTTPURLResponse
                    
                    if
                        httpResponse.statusCode / 100 != 2
                            ||
                            httpResponse.mimeType != "application/json"
                    {
                        let errorString = NSLocalizedString("HTTP Error", comment: "Error message displayed when receving a HTTP error.")
                        
                        let userInfo = [NSLocalizedDescriptionKey: errorString]
                        let httpError = NSError(domain: "HTTP", code: httpResponse.statusCode, userInfo: userInfo)
                        
                        self.myDidError(httpError)
                        
                        return
                    }
                    
                    
                    //var jsonError: NSError?
                    //let allJsonData: NSMutableDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError)! as NSMutableDictionary
                    
                    do
                    {
                        let allJsonData: NSMutableDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableDictionary
                        
                        let json_code = allJsonData["code"] as! Int
                        //let json_mess = allJsonData["mess"] as! String
                        
                        if json_code != 0
                        {
                            JEM_UserData.currentUserData().clearUserData()
                            self.performSegue(withIdentifier: "jeLaunchToLogin", sender: self)
                            
                            return
                        }
                        
                        let json_data = allJsonData["data"] as! NSDictionary
                        
                        
                        
                        JEM_AuthData.currentAuthData().updateBy(json_data)
                        
                        JEM_UserData.currentUserData().token = JEM_AuthData.currentAuthData().token
                        JEM_UserData.currentUserData().orgId = JEM_AuthData.currentAuthData().org!.orgId
                        JEM_UserData.currentUserData().saveUserData()
                        
                        self.performSegue(withIdentifier: "jeLaunchToActions", sender: self)
                        
                    }
                    catch let jsonError as NSError
                    {
                        self.myDidError(jsonError)
                    }
                    
                    return
                    } as! (URLResponse?, Data?, Error?) -> Void
            )
            
            
            return
        }
        */
    }

}
