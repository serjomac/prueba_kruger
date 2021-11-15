//
//  EmployeeDetailViewController.swift
//  prueba-macias
//
//  Created by Jonathan Macias on 14/11/21.
//

import UIKit

class EmployeeDetailViewController: UIViewController {
    
    // MARK: - OULETS
    @IBOutlet weak var cedula: UITextField!
    @IBOutlet weak var names: UITextField!
    @IBOutlet weak var lastNames: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var username: UITextField!
    
    
    @IBOutlet weak var satckExtraInfo: UIStackView!
    @IBOutlet weak var stackVaccuned: UIStackView!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var direction: UITextField!
    @IBOutlet weak var dateVaccuned: UITextField!
    @IBOutlet weak var vacunned: UISwitch!
    
    // MARK: - VARIABLES
    var manager = CoreDataManager()
    var isHidenBtnDelete = true
    var userLogin: UserModel?
    var userSelected: UserModel?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        self.userLogin = UserData.sharedInstance().userLogin
        self.btnSave.layer.cornerRadius = 20.0
        self.btnDelete.layer.cornerRadius = 20.0
//        self.cedula.resignFirstResponder()
//        self.names.resignFirstResponder()
//        self.lastNames.resignFirstResponder()
//        self.email.resignFirstResponder()
        self.username.resignFirstResponder()
        self.btnDelete.isHidden = self.isHidenBtnDelete
        self.btnDelete.isHidden = userLogin!.permissions!.companyPermissions.role == .employee ? true : true
        self.satckExtraInfo.isHidden = userLogin!.permissions!.companyPermissions.role == .admin ? true : false
        
        self.vacunned.isEnabled = userLogin!.permissions!.companyPermissions.role == .employee
        guard let user = self.userSelected else {
            return
        }
        
        self.cedula.text = user.id
        self.names.text = user.names
        self.lastNames.text = user.lastNames
        self.email.text = user.email
        self.username.text = user.username
        self.direction.text = user.ubication
        self.phone.text = user.phoneNumber
        self.vacunned.setOn(user.vaccunatedState, animated: false)
    }
    
    // MARK: - ACTIONS
    @IBAction func actionSave(_ sender: Any) {
        guard var userTmp = self.userSelected else {
            let cpermison = PermissionsContainer.CompanyPermission(role: .employee, id: "1")
            let messageError = validateForm()
            if messageError != nil {
                let alert = UIAlertController(title: "Error", message: messageError!, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            let user = UserModel(id: cedula.text!, companyId: "", permissions: PermissionsContainer(companyPermissions: cpermison), names: names.text!, lastNames: lastNames.text!, vaccunatedState: false, email: email.text!, username: username.text!, password: "1234", bornDate: Date(), phoneNumber: "", ubication: "", role: "E")
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
            return
        }
        userTmp.ubication = direction.text ?? ""
        userTmp.phoneNumber = phone.text ?? ""
        userTmp.vaccunatedState = self.vacunned.isOn
        let res = manager.updateEmployee(userTmp.id, userTmp)
        guard let _ = res else {
            let alert = UIAlertController(title: "Error", message: "No se pudo crear el usuario", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let alert = UIAlertController(title: "Error", message: "Empleado actualizado con éxito", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func actionDelete(_ sender: Any) {
        let result = manager.deleteSingleData("User", self.userLogin!.id)
        if result {
            let alert = UIAlertController(title: "Error", message: "Empleado elimindo con éxito", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func vaccunedStateAction(_ sender: UISwitch) {
        
    }
    
    
    func validateForm() -> String? {
        if TextfieldValidators.isEmpty(value: cedula.text) {
            return "Debe ingresar una cédula"
        } else if !TextfieldValidators.isIdValid(id: cedula.text!) {
            return "Debe ingresar una cédula valida"
        }else if TextfieldValidators.isEmpty(value: names.text) {
            return "Debe ingresar los nombres"
        } else if TextfieldValidators.isEmpty(value: lastNames.text) {
            return "Debe ingresar los apellidos"
        } else if TextfieldValidators.isEmpty(value: email.text) {
            return "Debe ingresar un correo"
        } else if !TextfieldValidators.isValidEmail(email: email.text!) {
            return "Debe ingresar un correo valido"
        } else {
            return nil
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension EmployeeDetailViewController: HasMyPermissionsContainer {
    var myPermissions: PermissionsContainer? {
        return userLogin?.permissions
    }
}
