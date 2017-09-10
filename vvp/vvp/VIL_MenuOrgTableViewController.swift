//
//  UI_MenuOrgTableViewController.swift
//  vvp
//
//  Created by Andrey Kotlyarov on 08.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit

class VIL_MenuOrgTableViewController: UITableViewController
{
    
    private var _checkedCellOrg: UITableViewCell?
    private var _checkedOrg: VIM_Org?
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.tintColor = VIM_DesignData.current.colorTint
        
        self.navigationItem.title = "Organization"
        
        let btnBack = UIBarButtonItem(title: "< VVPass", style: .plain, target: self, action: #selector(btnNavBack))
        //btnBack.style = .
        self.navigationItem.leftBarButtonItem = btnBack
        
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        
        return VIM_AuthData.current.orgs!.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrgCell", for: indexPath)

        // Configure the cell...
        /*
        cell.accessoryType = (VIM_AuthData.current.org!.orgId == VIM_AuthData.current.orgs![indexPath.row].orgId ? UITableViewCellAccessoryType.checkmark : UITableViewCellAccessoryType.none)
        cell.textLabel?.text = VIM_AuthData.current.orgs![indexPath.row].name
        */
        
        if VIM_AuthData.current.org!.orgId == VIM_AuthData.current.orgs![indexPath.row].orgId
        {
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
            
            self._checkedOrg = VIM_AuthData.current.org
            self._checkedCellOrg = cell
            
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryType.none
        }
        cell.textLabel?.text = VIM_AuthData.current.orgs![indexPath.row].name
        

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        // Return false if you do not want the specified item to be editable.
        //return true
        
        return false
    }
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    {
        // Return false if you do not want the item to be re-orderable.
        //return true
        
        return false
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        
        self._checkedCellOrg?.accessoryType = UITableViewCellAccessoryType.none
        
        self._checkedCellOrg = self.tableView.cellForRow(at: indexPath)
        self._checkedOrg = VIM_AuthData.current.orgs![indexPath.row]
        
        self._checkedCellOrg?.accessoryType = UITableViewCellAccessoryType.checkmark
        
        
        VIM_AuthData.current.org = self._checkedOrg
        VIM_UserData.current.orgId = self._checkedOrg?.orgId
        VIM_UserData.current.saveUserData()
        
        
        
        //[self.navigationController popViewControllerAnimated:YES]
        self.navigationController?.popViewController(animated: true)
        
        //UPDATE Menu Comtroller ...
        //AND
        //GO to Menu Controller
        
        // GO TO LOGIN???
        //self.dismiss(animated: true, completion: nil)
        
        
        //self.dismiss(animated: true, completion: nil)
        /*
        if indexPath.section == 0
        {
            performSegue(withIdentifier: "vilMenuToOrg", sender: self)
        }
        
        if indexPath.section == 1
        {
            
            if indexPath.row == 0
            {
                //TODO
            }
            if indexPath.row == 1
            {
                //TODO
                let sb = UIStoryboard.init(name: "Stream", bundle: nil)
                let vcStream = sb.instantiateViewController(withIdentifier: "visStream") as! VIS_StreamViewController
                self.present(vcStream, animated: true, completion: nil)
            }
        }
        
        if indexPath.section == 2
        {
            performSegue(withIdentifier: "vilMenuToProfile", sender: self)
        }
         */
    }
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //DEBUG
        //print("S2: " + segue.identifier!)
    }
    

}
