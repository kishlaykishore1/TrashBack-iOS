
import UIKit

public class Messages {
    
    static let thanksPerchase = "Thank you for your purchase.".localized
    
    static let noPerchase = "No purchases to restore!".localized
     static let perchaseRestored = "Thank you, your purchase has been restored.".localized
    static let IAPNotFound = "No In-App Purchase product identifiers were found.".localized
    static let IAPUnableToFound = "Unable to fetch available In-App Purchase products at the moment.".localized
    static let IAPCancel = "In-App Purchase process was cancelled.".localized
    
    static let ProblemWithInternet = "There seems to be a problem with your Internet connection. Please try again after a while.".localized
    static let NetworkError = "Internet error".localized
    static let somethingWentWrong = "Something went wrong, please try again soon!".localized
    static let seemsNetworkError = "seems to be a network error, please try after a while.".localized
    static let mustSubscribe = "You must be a subscriber to access this content.".localized
    
    
    //MARK:- Error Messages
    static let emptyName = "Please add your name !".localized
    static let emptyLName = "please enter your last name !".localized
    static let emptyDob = "please enter your date of birth !".localized
    static let emptyDis = "please enter your description !".localized
    static let emptyEmail = "please enter your email !".localized
    static let invalidEmail = "please enter a valid email !".localized
    static let emptyPhone = "please enter your phone no !".localized
    static let emptyPassword = "please enter your password !".localized
    static let passwordNotMatched = "both password entered are not same !".localized
    static let validPhoneNo = "Inavlid phone Number !".localized
    
    //MARK:- Alert Messages
    static let logoutMsg = "Êtes-vous sûr de vouloir vous déconnecter ?".localized
    static let deleteAccountMsg = "Voulez-vous vraiment supprimer votre compte? Veuillez noter que cette action est irréversible!".localized
    
    static let cameraNotFound = "Tu n'as pas de caméra".localized
    static let photoMassage = "Sélectionnez une option pour ajouter une image.".localized
    static let mailNotFound = "Les services de messagerie ne sont pas disponibles".localized
    static let bugReportTitle = "Aidez-nous à améliorer l'application en signalant les anomalies rencontrées.".localized

    // Text
    static let txtAlert = "Avertissement!".localized
    static let txtSignOut = "Dé connexion".localized
    static let txtDeleteAccount = "Supprimer mon compte".localized
    static let txtYes = "Oui".localized
    static let txtNo = "Non".localized
    static let txtCancel = "Annuler".localized
    static let txtGallery = "Galerie d'images".localized
    static let txtCamera = "Caméra".localized
    static let txtSetting = "Réglages".localized
    static let txtReportaBug = "Signaler un bug".localized
    static let txtSend = "Envoyer".localized
    static let txtCameraPermission = "\(Constants.kAppDisplayName) souhaite accéder à l'appareil photo de votre appareil pour mettre à jour votre profil.".localized
    static let txtLibraryPermission = "\(Constants.kAppDisplayName) souhaite accéder à la photothèque de votre appareil pour mettre à jour votre profil.".localized
    
    //MARK:- Helper Classes
    static let txtError = "Erreur".localized
    static let txtAlertMes = "Alerte".localized
    static let txtSuccess = "Succès".localized
    
    //delete account alert text
    static let txtDeleteAlert = "Alerte!".localized
    static let txtDeleteConfirm = "Confirmer".localized
    static let txtDeleteCancel = "Annuler".localized
    
    static let txtSettingReportBug = "Signaler un bug".localized
    static let txtSettingSend = "Envoyer".localized
    static let txtSettingBugDetail = "Veuillez saisir les détails du bogue".localized
    
    static let txtSettingReportTextField = "Votre rapport…".localized
    
    //MARK:- OtherProfileVC
    static let txtAlertMess = "Don't hesitate to let us know any issues encountered on the application.".localized
    static let txtAlertMesReport = "Please enter the report detail".localized
    static let txtReportDetailPlaceHolder = "Details of your report ...".localized
    
    //MARK:- NewsFeedVC
    static let txtDeleteTitleNewsFeed = "Delete".localized
    static let txtReportPubTitleNewsFeed = "Report publication".localized
    static let txtReportThePubTitleNewsFeed = "Report the publication".localized
    static let txtAlertMesNewsFeed = "If you believe that this publication does not comply with our General Conditions of Use, you can report it to us.".localized
    static let txtIndicateMesNewsFeed = "Indicate the reason of your report.".localized
    static let txtreportDetailMesNewsFeed = "Please enter the report detail".localized
    static let txtTextFieldNewsFeed = "Be specific in your explanations ...".localized
    static let txtAllUserNewsFeed = "All users".localized
    static let txtMySubNewsFeed = "My subscriptions".localized
    static let txtTeamCrossfitNewsFeed = "Team Crossfitness".localized
    static let txtSupports = "SUPPORTS".localized
    static let txtComments = "COMMENTS".localized
    static let txtSupport = "SUPPORT".localized
    static let txtComment = "COMMENT".localized
    static let txtReportOnPostMes =  "Your message has been sent. Our teams will take care of it as soon as possible.".localized
    static let txtTextViewNewsFeed = "Write something ...".localized
    static let txtCancelPublication = "Cancel publication".localized
    static let txtCancelPublicationMes = "Are you sure you want to cancel your publication?".localized
    static let txtCancelThePublication =  "Cancel the publication".localized
    static let txtPPNewsFeed = "Politique de confidentialité".localized
    static let txtTCNewsFeed = "Conditions générales d'utilisation".localized
    static let txtPpTcMesNewsFeed = "By pressing Post a message you acknowledge that you have read our".localized
    static let txtPpTcMesNewsFeed1 = "and that you accept our".localized
    static let txtTitleNewsFeed = "New message".localized
    static let txtTitleEditFeed = "Edit message".localized
    static let txtDeletePost = "Are you sure you want to delete the post ?".localized
    static let txtTersOfSales = "Conditions Génerales de vente et d’Utilisation.".localized
    static let txtAppShareSubject = "".localized
    static let txtDissmiss = "Dismiss".localized
    
    // MARK: - Signup VC
    static let txtFeedLogin = "Already have an account?".localized
    static let txtFeedTC = "By Clicking SignUp Button You Agree To All The".localized
    static let txtTAndC = "Terms And Conditions".localized
    static let txtSec5TermService = "Terms of Service".localized
    static let txtSec5PrivacyPolicy = "Privacy policy".localized
    static let txtProfilePictureAlertMes = "Please select your profile picture".localized
    
    //MARK:- FirstNameVc & LastNameVC & EmailVC & PrimiumVC
    static let txtFirstNameAlertMes = "Please enter your first name".localized
    static let txtLastNameAlertMes = "Please enter your last name".localized
    static let txtEmailAlertMes = "Please enter your email address".localized
    static let txtEmailValidAlertMes = "Please enter valid email".localized
}

class CustomActivityItemProvider: UIActivityItemProvider {
    var titleOfBlog: String!
    let message = "".localized
       init(placeholderItem: Any, titleOfBlog: String) {
        super.init(placeholderItem: placeholderItem)
        self.titleOfBlog = titleOfBlog
     }
    
    override var item: Any {
        switch self.activityType! {
        case UIActivity.ActivityType.postToFacebook:
            return ""
        case UIActivity.ActivityType.message:
            return ""
        case UIActivity.ActivityType.mail:
            return ""
        case UIActivity.ActivityType.postToTwitter:
            return ""
        default:
            return ""
        }
    }
}
