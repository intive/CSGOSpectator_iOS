//
//  Weapon.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 13.04.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import Foundation

struct Weapon: Decodable {
    let name: WeaponName
    let type: WeaponType?
    let state: WeaponState
}

/* Name, Type, State enums */
extension Weapon {
    
    enum WeaponName: String, Decodable {
        case weapon_c4
        case weapon_flashbang
        case weapon_molotov
        case weapon_smokegrenade
        case weapon_hegrenade
        case weapon_decoy
        case weapon_incgrenade
        case weapon_taser
        case weapon_knife
        case weapon_knife_t
        case weapon_bayonet
        case weapon_knife_m9_bayonet
        case weapon_knife_karambit
        case weapon_knife_push
        case weapon_knife_gut
        case weapon_knife_flip
        case weapon_knife_butterfly
        case weapon_knife_falchion
        case weapon_knife_tactical
        case weapon_knife_survival_bowie
        case weapon_glock
        case weapon_p250
        case weapon_deagle
        case weapon_usp_silencer
        case weapon_fiveseven
        case weapon_tec9
        case weapon_cz75a
        case weapon_hkp2000
        case weapon_elite
        case weapon_revolver
        case weapon_mac10
        case weapon_mp9
        case weapon_mp7
        case weapon_ump45
        case weapon_p90
        case weapon_bizon
        case weapon_nova
        case weapon_sawedoff
        case weapon_mag7
        case weapon_m4a1
        case weapon_galilar
        case weapon_ak47
        case weapon_m4a1_silencer
        case weapon_aug
        case weapon_famas
        case weapon_sg556
        case weapon_awp
        case weapon_ssg08
        case weapon_scar20
        case weapon_g3sg1
        case weapon_xm1014
        case weapon_negev
        case weapon_m249
    }
    
    enum WeaponType: String, Decodable {
        case C4
        case Shotgun
        case SubmachineGun
        case MachineGun
        case Pistol
        case Knife
        case Rifle
        case Grenade
        case SniperRifle
    }
    
    enum WeaponState: String, Decodable {
        case holstered
        case active
    }
}

/* Description */
extension Weapon: CustomStringConvertible {
    
    var description: String {
        return "Name: \(name)\nType: \(type)\nState: \(state)\n"
    }
    
}
