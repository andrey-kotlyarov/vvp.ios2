//
//  VIL_LoginViewController.swift
//  vvp
//
//  Created by Kotlyarov Andrey on 06.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit



class VIL_LoginViewController: UIViewController
{
    @IBOutlet var tblLogin: UITableView!
    @IBOutlet var btnSignin: UIButton!
    
    
    fileprivate var _viuActivity: VIU_Activity?
    //fileprivate var _jeuAlertView: JEU_AlertView?
    
    fileprivate var _txtUsername: UITextField?
    fileprivate var _txtPassword: UITextField?
    
    
    
    
    @IBAction func btnSignin_OnTouchUp(_ sender: Any)
    {
        self.myLoadAuthData()
    }
    
    
    
    
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
        //self._jeuAlertView = nil
        
        
        //TABLE LOGIN
        self.tblLogin.layer.cornerRadius = 4.0;
        self.tblLogin.layer.masksToBounds = true;
        self.tblLogin.clipsToBounds = true;
        
        self.tblLogin.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        //self.tblLogin.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.tblLogin.separatorInset = UIEdgeInsets.zero;
        
        self.tblLogin.delegate = self;
        self.tblLogin.dataSource = self;
        
        
        
        
        //BTN SIGN IN
        self.btnSignin.backgroundColor = UIColor(white: 1.0, alpha: 0.2)
        self.btnSignin.layer.cornerRadius = 4.0;
        self.btnSignin.layer.masksToBounds = true;
        self.btnSignin.clipsToBounds = true;
        
        _txtUsername = nil;
        _txtPassword = nil;
    }
    
    
    
    override func viewDidLayoutSubviews()
    {
        self.tblLogin.layoutMargins = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
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
    // My Private Methods
    //
    
    private func myHideKeyboard()
    {
        self._txtUsername?.resignFirstResponder()
        self._txtPassword?.resignFirstResponder()
    }
    /*
    private func myDidError(_ error: NSError)
    {
        self.myHideKeyboard()
        
        //TODO
        //self._jeuAlertView = JEU_AlertView(title: ""/*[error domain]*/, message: error.localizedDescription, delegate: self, cancelButtonTitle: "OK")
        //self._jeuAlertView?.show()
        
        return
    }
    */
    
    private func myDidError(_ title: String, errorMessage: String) -> Void
    {
        self.myHideKeyboard()
        
        
        let alertController = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)
        alertController.view.tintColor = VIM_DesignData.current.colorBG_D
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: nil)
        
        return
    }
    
    private func myDidError(_ title: String, error: Error) -> Void
    {
        self.myDidError(title, errorMessage: error.localizedDescription)
    }
    
    private func myLoadAuthData()
    {
        //DEBUG
        //return
        
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self._viuActivity?.show()
        self.myHideKeyboard()
        
        
        
        
        
        
        
        /*
        let viuRequest: VIU_Request = VIU_Request(cmd: "login")
        
        viuRequest.addPostValue(self._txtUsername!.text!, forKey: "login")
        viuRequest.addPostValue(self._txtPassword!.text!, forKey: "pass")
        */
        //debug
        //viuRequest.addPostValue(val: "2500", forKey: "_delay_")
        //print(viuRequest)
        
        //
        //DEBUG
        //
        //http://virtualvideopass.com/WebAPI/ws_1?cmd=auth&username=2&pass=3&orgid=4&sizetype=5
        
        
        
        
        let viuRequest: VIU_Request = VIU_Request(cmd: "auth")
        
        viuRequest.addPostValue(self._txtUsername!.text!, forKey: "username")
        viuRequest.addPostValue(self._txtPassword!.text!, forKey: "pass")
        //viuRequest.addPostValue("22", forKey: "orgid")
        viuRequest.addPostValue(String(VIM_DesignData.current.sizeType), forKey: "sizetype")
        
        //print(viuRequest)
        
        let task = URLSession.shared.dataTask(
            with: viuRequest.urlRequest(),
            completionHandler:
            {
                (data: Data?, response: URLResponse?, error: Error?) in
            
                //
                //
                //
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self._viuActivity?.hide()
                
                if error != nil
                {
                    self.myDidError("URL Error", error:error!)
                    return
                }
                
                if response?.mimeType != "application/json__"
                {
                    self.myDidError("HTTP Error", errorMessage: "tetststt stststt sststst ststs ")
                }
                        
                
                
                
                print("data: \(data)")
                print("response: \(response)")
                print("error: \(error)")
                
                
                //
                //
                //
            }
        )
        task.resume()
        
        
        /*
        NSURLConnection.sendAsynchronousRequest(
            viuRequest.urlRequest() as URLRequest,
            queue: OperationQueue.main,
            completionHandler:{ (response: URLResponse?, data: Data?, connectionError: Error?) -> Void in
                
         
         
                 
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
                 
                 
                 do
                 {
                 let allJsonData: NSMutableDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableDictionary
                 
                 //print("JSON: \(allJsonData)")
                 
                 let json_code = allJsonData["code"] as! Int
                 let json_mess = allJsonData["mess"] as! String
                 
                 if json_code != 0
                 {
                 
                 let errorString = NSLocalizedString("JSON", comment: "Error message displayed when error in JSON.")
                 
                 let userInfo = [NSLocalizedDescriptionKey: errorString]
                 let httpError = NSError(domain: "JSON", code: httpResponse.statusCode, userInfo: userInfo)
                 
                 self.myDidError(httpError)
 
                 let errorString = NSLocalizedString(json_mess, comment: "Error message displayed when ERROR.")
                 
                 let userInfo = [NSLocalizedDescriptionKey: errorString]
                 let error = NSError(domain: "ERROR", code: httpResponse.statusCode, userInfo: userInfo)
                 
                 self.myDidError(error)
                 
                 
                 return
                 }
                 
                 //let json_data = allJsonData["data"] as! NSDictionary
                 //VIM_AuthData.current.updateBy(username: self._txtUsername!.text!, password: self._txtPassword!.text!)
                 //
                 //
                 let username = allJsonData["data"] as! String
                 let password = allJsonData["data"] as! String
                 VIM_AuthData.current.updateBy(username: username, password: password)
                 
                 
                 //self.performSegue(withIdentifier: "jeLoginToOrgs", sender: self)
                 let vcMenu = self.storyboard?.instantiateViewController(withIdentifier: "vilMenu") as! VIL_MenuViewController
                 self.present(vcMenu, animated: false, completion: nil)
                 }
                 catch let jsonError as NSError
                 {
                 self.myDidError(jsonError)
                 }
                
                return
            }
            
        )
        */
        
        /*
        NSURLConnection.sendAsynchronousRequest(
            viuRequest.urlRequest() as URLRequest,
            queue: OperationQueue.main,
            completionHandler:{ (response: URLResponse?, data: Data?, connectionError: Error?) -> Void in
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self._viuActivity?.hide()
                /*
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
                
                
                do
                {
                    let allJsonData: NSMutableDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableDictionary
                    
                    //print("JSON: \(allJsonData)")
                    
                    let json_code = allJsonData["code"] as! Int
                    let json_mess = allJsonData["mess"] as! String
                    
                    if json_code != 0
                    {
                        /*
                         let errorString = NSLocalizedString("JSON", comment: "Error message displayed when error in JSON.")
                         
                         let userInfo = [NSLocalizedDescriptionKey: errorString]
                         let httpError = NSError(domain: "JSON", code: httpResponse.statusCode, userInfo: userInfo)
                         
                         self.myDidError(httpError)
                         */
                        let errorString = NSLocalizedString(json_mess, comment: "Error message displayed when ERROR.")
                        
                        let userInfo = [NSLocalizedDescriptionKey: errorString]
                        let error = NSError(domain: "ERROR", code: httpResponse.statusCode, userInfo: userInfo)
                        
                        self.myDidError(error)
                        
                        
                        return
                    }
                    
                    //let json_data = allJsonData["data"] as! NSDictionary
                    //VIM_AuthData.current.updateBy(username: self._txtUsername!.text!, password: self._txtPassword!.text!)
                    //
                    //
                    let username = allJsonData["data"] as! String
                    let password = allJsonData["data"] as! String
                    VIM_AuthData.current.updateBy(username: username, password: password)
                    
                    
                    //self.performSegue(withIdentifier: "jeLoginToOrgs", sender: self)
                    let vcMenu = self.storyboard?.instantiateViewController(withIdentifier: "vilMenu") as! VIL_MenuViewController
                    self.present(vcMenu, animated: false, completion: nil)
                }
                catch let jsonError as NSError
                {
                    self.myDidError(jsonError)
                }
                */
                return
            }/* as! (URLResponse?, Data?, Error?) -> Void*/
        
        )
        */
        //NSURLConnection.sendAsynchronousRequest(<#T##request: URLRequest##URLRequest#>, queue: <#T##OperationQueue#>, completionHandler: <#T##(URLResponse?, Data?, Error?) -> Void#>)
        
        
        
        /*
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self._jeuActivity?.show()
        self.myHideKeyboard()
        
        
        
        let jeuRequest: JEU_Request = JEU_Request(cmd: "getOrgListByParams")
        
        jeuRequest.addPostValue(self._txtUsername!.text!, forKey: "login")
        jeuRequest.addPostValue(self._txtPassword!.text!, forKey: "pass")
        jeuRequest.addPostValue(self._txtEmail!.text!, forKey: "email")
        
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
                    let json_mess = allJsonData["mess"] as! String
                    
                    if json_code != 0
                    {
                        /*
                         let errorString = NSLocalizedString("JSON", comment: "Error message displayed when error in JSON.")
                         
                         let userInfo = [NSLocalizedDescriptionKey: errorString]
                         let httpError = NSError(domain: "JSON", code: httpResponse.statusCode, userInfo: userInfo)
                         
                         self.myDidError(httpError)
                         */
                        let errorString = NSLocalizedString(json_mess, comment: "Error message displayed when ERROR.")
                        
                        let userInfo = [NSLocalizedDescriptionKey: errorString]
                        let error = NSError(domain: "ERROR", code: httpResponse.statusCode, userInfo: userInfo)
                        
                        self.myDidError(error)
                        
                        
                        return
                    }
                    
                    let json_data = allJsonData["data"] as! NSDictionary
                    
                    JEM_AuthData.currentAuthData().updateBy(self._txtUsername!.text!, password: self._txtPassword!.text!, dict: json_data)
                    self.performSegue(withIdentifier: "jeLoginToOrgs", sender: self)
                    
                }
                catch let jsonError as NSError
                {
                    self.myDidError(jsonError)
                }
                
                return
                } as! (URLResponse?, Data?, Error?) -> Void
        )
         */
    }
    
    //
    //
    //
    //
    
    
}


extension VIL_LoginViewController: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (tableView == self.tblLogin)
        {
            return 2
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: VIL_LoginTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LoginCell", for: indexPath) as! VIL_LoginTableViewCell
         
        if (indexPath.row == 0)
        {
            cell.txtField.placeholder = "Username";
            
            cell.txtField.delegate = self
            cell.txtField.keyboardAppearance = UIKeyboardAppearance.dark
            cell.txtField.keyboardType = UIKeyboardType.default
            cell.txtField.isSecureTextEntry = false
            
            self._txtUsername = cell.txtField
            self._txtUsername?.becomeFirstResponder()
            
            //DEBUG
            if VIM_UserData.current.isDebugMode()
            {
                self._txtUsername?.text = "streamer@gmail.com"
            }
        }
        
        if (indexPath.row == 1)
        {
            cell.txtField.placeholder = "Password";
            
            cell.txtField.delegate = self
            cell.txtField.keyboardAppearance = UIKeyboardAppearance.dark
            cell.txtField.keyboardType = UIKeyboardType.default
            cell.txtField.isSecureTextEntry = true
            
            self._txtPassword = cell.txtField
            
            //DEBUG
            if VIM_UserData.current.isDebugMode()
            {
                self._txtPassword?.text = "sTreameR123"
            }
        }
 
        return cell
    }
}

extension VIL_LoginViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 44.0
    }
}

extension VIL_LoginViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == self._txtUsername
        {
            self._txtPassword?.becomeFirstResponder()
        }
        /*
        else if textField == self._txtPassword
        {
            self._txtEmail?.becomeFirstResponder()
        }
        */
        else
        {
            textField.resignFirstResponder()
        }
        
        return true
    }
}
