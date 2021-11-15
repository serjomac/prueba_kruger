//
//  LoginViewController.swift
//  prueba-macias
//
//  Created by Jonathan Macias on 13/11/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    private let manager = CoreDataManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - ACTIONS
    @IBAction func loginAction(_ sender: Any) {
        let messageError = validateForm()
        if messageError != nil {
            let alert = UIAlertController(title: "Error", message: messageError!, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let user = self.manager.login(username.text!, password.text!)
        guard let userLogin = user else {
            let alert = UIAlertController(title: "Error", message: "Usuario o contraseña incorrecta", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let cpermison = PermissionsContainer.CompanyPermission(role: userLogin.role == "E" ? .employee : .admin, id: "1")
        UserData.sharedInstance().userLogin = UserModel(id: userLogin.id!, companyId: "", permissions: PermissionsContainer(companyPermissions: cpermison), names: userLogin.names!, lastNames: userLogin.lastNames!, vaccunatedState: userLogin.vaccunatedState, email: userLogin.email!, username: userLogin.username!, password: "", bornDate: userLogin.bornDate ?? Date(), phoneNumber: userLogin.phoneNumber ?? "", ubication: userLogin.ubication ?? "", role: userLogin.role!)
        print("BIENVENIDO: ", userLogin.names!)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vcEmployees = storyboard.instantiateViewController(identifier: "employeeList") as EmployeesViewController
        let vc = storyboard.instantiateViewController(identifier: "employeeDetail") as EmployeeDetailViewController
        vc.userLogin = UserData.sharedInstance().userLogin!
        vc.userSelected = UserData.sharedInstance().userLogin!
        if UserData.sharedInstance().userLogin!.permissions!.companyPermissions.role == .admin {
            self.navigationController?.viewControllers = [vcEmployees]
        } else {
            self.navigationController?.viewControllers = [vc]
        }
    }
    
    func validateForm() -> String? {
        if TextfieldValidators.isEmpty(value: username.text) {
            return "Debe ingresar un nombre de usuario"
        } else if TextfieldValidators.isEmpty(value: password.text) {
            return "Debe ingresar una contraseña"
        } else {
            return nil
        }
    }
}
