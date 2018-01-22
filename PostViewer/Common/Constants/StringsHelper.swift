//
//  StringsHelper.swift
//  Portable
//

class StringsHelper {
    
    enum StringKey: String {
        
        // Title for posts list
        case postsListTitle                     = "PostsListTitle"
        
        // Title for logout button
        case logOutButtonTitle                  = "LogOutButtonTitle"
        
        // Title for common OK alert
        case commonAlertOKButtonTitle           = "CommonAlertOKButtonTitle"
        
        // Deleted information
        case deleted                            = "Deleted"
        
        // Errors
        case PVErrorAuthorizationCancelled      = "PVErrorAuthorizationCancelled"
        case PVErrorNotAuthorized               = "PVErrorNotAuthorized"
        case PVSerializationError               = "PVSerializationError"
        case PVUnknownError                     = "PVUnknownError"
    }
    
    static func string(for key: StringKey) -> String {
        switch key {
        default:
            return key.rawValue.localized()
        }
    }
}
