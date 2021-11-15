//
//  ViewController.swift
//  prueba-macias
//
//  Created by Jonathan Macias on 13/11/21.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - OULETS
    @IBOutlet weak var btnReadUsers: UIButton!
    @IBOutlet weak var btnCreateUser: UIButton!
    @IBOutlet weak var btnUpdateUser: UIButton!
    @IBOutlet weak var btnDeleteUser: UIButton!
    
    
    // MARK: - VARIABLES DE DATOS
    var userSesion: UserModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        self.configure()
    }
    
    func loadData() {
        let cpermison = PermissionsContainer.CompanyPermission(role: .admin, id: "1")
        self.userSesion = UserModel(id: "", companyId: "", permissions: PermissionsContainer(companyPermissions: cpermison), names: "", lastNames: "", vaccunatedState: false, email: "", username: "", password: "", bornDate: Date(), phoneNumber: "", ubication: "", role: "E")
    }
    
    func configure() {
        let _ = hasPermissions(for: .createUser, in: userSesion!.companyId)
        self.btnCreateUser.isHidden = !hasPermissions(for: .createUser, in: userSesion!.companyId)
    }

}

extension ViewController: HasMyPermissionsContainer {
    var myPermissions: PermissionsContainer? {
        return userSesion?.permissions
    }
}

