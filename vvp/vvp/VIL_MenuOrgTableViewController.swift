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
    
    //private var _checkedCellOrg: UITableViewCell?
    //private var _checkedOrg: VIM_Org?
    
    fileprivate var _bbtBack: UIBarButtonItem?
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //self.tableView.tintColor = VIM_DesignData.current.colorTint
        
        
        //let btnBack = UIBarButtonItem(title: "< VVPass", style: .plain, target: self, action: #selector(btnNavBack))
        ////btnBack.style = .done
        //self.navigationItem.leftBarButtonItem = nil
        
        
        
        // NAVIGATION BAR
        self.navigationItem.title = "Organization"
        self._bbtBack = UIBarButtonItem(
            image: UIImage(named: "ic_chevron_left"),
            style: UIBarButtonItemStyle.plain,
            target: self,
            action: #selector(bbtBack_OnTouchUp(_:))
        )
        
        self.navigationItem.setLeftBarButtonItems(NSArray(object: self._bbtBack!) as? [UIBarButtonItem], animated: false)
    }
    
    
    
    
    func bbtBack_OnTouchUp(_ sender: UIBarButtonItem?)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        //self.navigationItem.setLeftBarButtonItems(NSArray(object: self._bbtBack!) as? [UIBarButtonItem], animated: false)
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
            
            //self._checkedOrg = VIM_AuthData.current.org
            //self._checkedCellOrg = cell
            
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryType.none
        }
        cell.textLabel?.text = VIM_AuthData.current.orgs![indexPath.row].title
        

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
        
        VIM_AuthData.current.org = VIM_AuthData.current.orgs![indexPath.row]
        VIM_UserData.current.orgId = VIM_AuthData.current.orgs![indexPath.row].orgId
        VIM_UserData.current.saveUserData()
        tableView.reloadData()
        
        self.navigationController?.popViewController(animated: true)
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
