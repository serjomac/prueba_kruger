//
//  EmployeesViewController.swift
//  prueba-macias
//
//  Created by Jonathan Macias on 13/11/21.
//

import UIKit

class EmployeesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    // MARK: - OULETS
    @IBOutlet weak var employeesListTbl: UITableView!
    @IBOutlet weak var iconAdd: UIImageView!
    
    // MARK: - VARIABLES
    var employeeList: [User] = []
    var manager = CoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadAllEmployees()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            loadAllEmployees()
        }
    
    func setupView() {
        employeesListTbl.delegate = self
        employeesListTbl.dataSource = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(navegateAddEmployee(tapGestureRecognizer:)))
        iconAdd.isUserInteractionEnabled = true
        iconAdd.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employeeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell") as! EmployeeCellTableViewCell
        cell.namesEmployee.text = employeeList[indexPath.row].names! + " " + employeeList[indexPath.row].lastNames!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let user = employeeList[indexPath.row]
        let vc = storyboard.instantiateViewController(identifier: "employeeDetail") as! EmployeeDetailViewController
        let cpermison = PermissionsContainer.CompanyPermission(role: user.role == "E" ? .employee : .admin, id: "1")
        let userTmp = UserModel(id: user.id!, companyId: "", permissions: PermissionsContainer(companyPermissions: cpermison), names: user.names!, lastNames: user.lastNames!, vaccunatedState: user.vaccunatedState, email: user.email!, username: user.username!, password: "", bornDate: user.bornDate ?? Date(), phoneNumber: user.phoneNumber ?? "", ubication: user.ubication ?? "", role: user.role!)
        vc.userSelected = userTmp
        vc.isHidenBtnDelete = false
        vc.title = "Empleado"
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func loadAllEmployees() {
        let results = manager.getEmployees()
        print("EMPLEADOS: ", results.count)
        employeeList = results
        employeesListTbl.reloadData()
    }
    
    @objc func navegateAddEmployee(tapGestureRecognizer: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "employeeDetail")
        vc.modalPresentationStyle = .fullScreen
        vc.title = "Empleado"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
