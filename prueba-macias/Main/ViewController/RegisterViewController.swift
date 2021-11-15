//
//  RegisterViewController.swift
//  prueba-macias
//
//  Created by Jonathan Macias on 14/11/21.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var cedula: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var manager = CoreDataManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func createUser() {
        
    }

    @IBAction func createUser(_ sender: Any) {
        let cpermison = PermissionsContainer.CompanyPermission(role: .admin, id: "1")
//        let messageError = validateForm()
//        if messageError != nil {
//            let alert = UIAlertController(title: "Error", message: messageError!, preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//            return
//        }
        let user = UserModel(id: cedula.text!, companyId: "", permissions: PermissionsContainer(companyPermissions: cpermison), names: name.text!, lastNames: lastname.text!, vaccunatedState: false, email: email.text!, username: username.text!, password: "1234", bornDate: Date(), phoneNumber: "", ubication: "", role: "A")
        manager.createEmployee(user: user) {
            let users = self.manager.fetchUsers()
            if users.count > 0 {
                print(users[users.count - 1].names! + "\(users.count)")
                let alert = UIAlertController(title: "Error", message: "Empleado agregado con éxito", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: { _ in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Error", message: "No se pudo crear el usuario", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
