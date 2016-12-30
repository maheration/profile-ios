//
//  Constants.swift
//  Profile
//
//  Created by Maher Aldemerdash on 2016-12-27.
//  Copyright © 2016 Maher Aldemerdash. All rights reserved.
//

import Foundation

typealias callback = (_ success: Bool) -> ()

//BASE URL
let BASE_API_URL = "http://localhost:3000/v1"

// GET all codes
let GET_ALL_CODES = "\(BASE_API_URL)/codes/"

// REGISTER url
let POST_REGISTER_ACCT = "\(BASE_API_URL)/account/register"

//Login Url
let POST_LOGIN_ACCT = "\(BASE_API_URL)/account/login"

//get all patients url
let GET_ALL_PTS = "\(BASE_API_URL)/account/"

// GET plan
let GET_PT_PLAN = "\(BASE_API_URL)/plan/"

//Boolean auth UserDefaults keys
let DEFAULTS_REGISTERED = "isRegistered"
let DEFAULTS_AUTHENTICATED = "isAuthenticated"


//Auth email
let DEFAULTS_EMAIL = "email"

//Auth Token
let DEFAULTS_TOKEN = "authToken"

let DEFAULT_ADMIN = "isAdmin"


