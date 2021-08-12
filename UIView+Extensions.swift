//
//  Extensions.swift
//  My Black Book
//
//  Created by apple on 25/11/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import WebKit

import CryptoKit
import CommonCrypto

//Extensions For Localization

extension UIButton {
    @IBInspectable var localizedTitle: String {
        get { return "" }
        set {
            self.setTitle(newValue.localized(), for: .normal)
            self.setTitle(newValue.localized(), for: .selected)
        }
    }
}

extension UILabel {
    @IBInspectable var localizedTitle: String{
        get { return "" }
        set {
            self.text = newValue.localized()
        }
    }
}

extension UITextField {
    @IBInspectable var localizedTitle: String {
        get { return "" }
        set {
            self.text = newValue.localized()
        }
    }
    
    @IBInspectable var localizedPlaceHolder: String {
        get { return "" }
        set {
            self.placeholder = newValue.localized()
        }
    }
}

extension UITextView {
    @IBInspectable var localizedTitle: String {
        get { return "" }
        set {
            self.text = newValue.localized()
        }
    }
}

extension Bundle {
    private static var bundle: Bundle!
    
    public static func localizedBundle() -> Bundle! {
        if bundle == nil {
            let appLang = UserDefaults.standard.string(forKey: "app_lang") ?? "en"
            let path = Bundle.main.path(forResource: appLang, ofType: "lproj")
            bundle = Bundle(path: path!)
        }
        
        return bundle;
    }
    public static func setLanguage(lang: String) {
        UserDefaults.standard.set(lang, forKey: "app_lang")
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        bundle = Bundle(path: path!)
    }
}

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.localizedBundle(), value: "", comment: "")
    }

    func localizeWithFormat(arguments: CVarArg...) -> String{
        return String(format: self.localized(), arguments: arguments)
    }
}




// MARK: - Designable Extension

@IBDesignable
extension UIView {
    
    @IBInspectable
    /// Should the corner be as circle
    public var circleCorner: Bool {
        get {
            return min(bounds.size.height, bounds.size.width) / 2 == layer.cornerRadius
        }
        set {
            //            cornerRadius = newValue ? min(bounds.size.height, bounds.size.width) / 2 : cornerRadius
            layer.cornerRadius = newValue ? min(bounds.size.height, bounds.size.width) / 2 : cornerRadius
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}


// MARK: - Properties
public extension UIView {
    
    /// Size of view.
    var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            self.width = newValue.width
            self.height = newValue.height
        }
    }
    
    /// Width of view.
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    
    /// Height of view.
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
}

extension UIView {
    func superview<T>(of type: T.Type) -> T? {
        return superview as? T ?? superview.flatMap { $0.superview(of: T.self) }
    }
}


// MARK: - Methods
public extension UIView {
    
    typealias Configuration = (UIView) -> Swift.Void
    
    func config(configurate: Configuration?) {
        configurate?(self)
    }
    
    /// Set some or all corners radiuses of view.
    ///
    /// - Parameters:
    ///   - corners: array of corners to change (example: [.bottomLeft, .topRight]).
    ///   - radius: radius for selected corners.
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}

extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}


extension Date
{
    func get_FormattedDateString(formatter: String) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = formatter
        return dateFormatterPrint.string(from: self)
    }
    
    func get_CurrentYear(formatter: String) -> String {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        return ("\(year)")
    }
    
    
    func get_date_FromString(formatter: String, stringDate: String) -> Date {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = formatter
        
        return dateFormatterPrint.date(from: stringDate)!
    }
    
    
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        //print(Date().dayOfWeek()!) // Wednesday
        
        return dateFormatter.string(from: self).uppercased()
        // or use capitalized(with: locale) if you want
    }
    
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    
    func futuredaysfromNow(required_days: Int) -> Date {
        return (Calendar.current as NSCalendar).date(byAdding: .day, value: required_days, to: Date(), options: [])!
    }
    
    func futuredaysfromDynamic_date(required_days: Int, dynamicDate: Date) -> Date {
        return (Calendar.current as NSCalendar).date(byAdding: .day, value: required_days, to: dynamicDate, options: [])!
    }
    
    func convertDateToFormattedString(formatter: String) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = formatter
        return dateFormatterPrint.string(from: self)
    }
    
    func get_date_with_time(Input_date: String, formatter1: String) -> Date {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = formatter1
        
        return dateFormatterPrint.date(from: Input_date)!
    }
    
    
    /// Returns the amount of years from another date
    func years(from date: Date, to_date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: to_date).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date, to_date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: to_date).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date, to_date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: to_date).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date, to_date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: to_date).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date, to_date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: to_date).hour ?? 0
    }
    func hours(to_date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: self, to: to_date).hour ?? 0
    }
    
    /// Returns the amount of minutes from another date
    func minutes(from date: Date, to_date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: to_date).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date, to_date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: to_date).second ?? 0
    }
    /// Returns the amount of nanoseconds from another date
    func nanoseconds(from date: Date, to_date: Date) -> Int {
        return Calendar.current.dateComponents([.nanosecond], from: date, to: to_date).nanosecond ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date, to_date: Date) -> String
    {
        var finalStr = ""
        
        if days(from: date, to_date: to_date)    > 0
        {
            finalStr = "\(days(from: date, to_date: to_date))d"
            //return "\(days(from: date, to_date: to_date))d"
        }
        if hours(from: date, to_date: to_date)   > 0
        {
            let hours1 = hours(from: date, to_date: to_date)%24
            finalStr.append(" \(hours1)h")
            //return "\(hours(from: date, to_date: to_date))h"
            
        }
        if minutes(from: date, to_date: to_date) > 0
        {
            let minutes1 = minutes(from: date, to_date: to_date)%60
            
            finalStr.append(" \(minutes1)m")
        }
        return finalStr
    }
    
    func getTotalHours(from date: Date, to_date: Date) -> Double
    {
        var finalHours = 0
        var Fullstr = ""
        var minutes1 = 0
        if hours(from: date, to_date: to_date)   > 0
        {
            let hours1 = hours(from: date, to_date: to_date)
            finalHours = hours1
        }
        
        if minutes(from: date, to_date: to_date) > 0
        {
            minutes1 = minutes(from: date, to_date: to_date)%60
        }
        Fullstr = String(finalHours) + "." + String(minutes1)
        
        return Double(Fullstr)!
    }
    
    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
    func adding(hour: Int) -> Date {
        return Calendar.current.date(byAdding: .hour, value: hour, to: self)!
    }
    func adding(hour: Int, minutes: Int) -> Date {
        let dateAdd = Calendar.current.date(byAdding: .hour, value: hour, to: self)!
        return Calendar.current.date(byAdding: .hour, value: hour, to: dateAdd)!
    }
    
    func adding(days: Int) -> Date {
        var dateComponent = DateComponents()
        dateComponent.day = days
        return Calendar.current.date(byAdding: dateComponent, to: self)!
    }
    
    func isBetween(date date1: Date, andDate date2: Date) -> Bool {
        return date1.compare(self).rawValue * self.compare(date2).rawValue >= 0
    }
    
    //    static var currentTimeStamp: Int64{
    //        return Int64(Date().timeIntervalSince1970 * 1000)
    //    }
    
}


extension UIView {
    
    func searchVisualEffectsSubview() -> UIVisualEffectView? {
        if let visualEffectView = self as? UIVisualEffectView {
            return visualEffectView
        } else {
            for subview in subviews {
                if let found = subview.searchVisualEffectsSubview() {
                    return found
                }
            }
        }
        return nil
    }
    
    /// This is the function to get subViews of a view of a particular type
    /// https://stackoverflow.com/a/45297466/5321670
    func subViews<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        for view in self.subviews {
            if let aView = view as? T{
                all.append(aView)
            }
        }
        return all
    }
    
    
    /// This is a function to get subViews of a particular type from view recursively. It would look recursively in all subviews and return back the subviews of the type T
    /// https://stackoverflow.com/a/45297466/5321670
    func allSubViewsOf<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T{
                all.append(aView)
            }
            guard view.subviews.count>0 else { return }
            view.subviews.forEach{ getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }
}




extension UIImage {
    func resized(toWidth width: CGFloat) -> UIImage? {
        let height = CGFloat(ceil(width / size.width * size.height))
        let canvasSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: CGPoint(x: 20, y: 5), size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}


extension UIView {
    func roundCornersWith(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension UIView{
    func roundCorner(size: CGSize) {
        let path = UIBezierPath(roundedRect:self.bounds, byRoundingCorners:[.topLeft, .topRight], cornerRadii: size)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds;
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer;
    }
}

extension String{
    
    
    func toDate(format:String)->Date{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self) ?? Date()
        return date
    }
    
    
    var md5Value: String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        
        if let d = self.data(using: .utf8) {
            _ = d.withUnsafeBytes { body -> String in
                CC_MD5(body.baseAddress, CC_LONG(d.count), &digest)
                
                return ""
            }
        }
        
        return (0 ..< length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
    
    
    public func isImageType() -> Bool {
        // image formats which you want to check
        let imageFormats = ["jpg", "png", "gif"]
        
        if URL(string: self) != nil  {
            
            let extensi = (self as NSString).pathExtension
            
            return imageFormats.contains(extensi)
        }
        return false
    }
    
    func formatedDate(dateFormate : String,receivingFormate :String) -> String{
        if self == ""{
            return ""
        }
        
        let dateFormator = DateFormatter()
        dateFormator.dateFormat = dateFormate
        dateFormator.timeZone = TimeZone.current
        
        let date = dateFormator.date(from: self)
        if date == nil{
            return ""
        }
        dateFormator.dateFormat = receivingFormate
        dateFormator.timeZone = TimeZone.current
        return dateFormator.string(from: date!)
    }
    
    
    func stripOutHtml() -> String {
        do {
            guard let data = self.data(using: .unicode) else {
                return ""
            }
            let attributed = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            return attributed.string
        } catch {
            return ""
        }
    }
    
    
    func strippingHTMLTags() -> String {
        
        do {
            guard let data = self.data(using: .unicode) else {
                return ""
            }
            let attributed = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            return attributed.string
        } catch {
            return ""
        }
        
        //        var newStr = self.replacingOccurrences(of: "&nbsp;", with: "")
        //        newStr = newStr.replacingOccurrences(of: "ul {list-style-type:none; }", with: "")
        //        return newStr.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    func matchingStrings(regex: String) -> [[String]] {
        guard let regex = try? NSRegularExpression(pattern: regex, options: []) else { return [] }
        let nsString = self as NSString
        let results  = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
        return results.map { result in
            (0..<result.numberOfRanges).map {
                result.range(at: $0).location != NSNotFound
                    ? nsString.substring(with: result.range(at: $0))
                    : ""
            }
        }
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}

extension UITextField{
    func shakeTextfield() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
    func setLeftView(image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 10, y: 10, width: 25, height: 25)) // set your Own size
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 45))
        iconContainerView.addSubview(iconView)
        iconContainerView.isUserInteractionEnabled = false
        leftView = iconContainerView
        leftViewMode = .always
        self.tintColor = .lightGray
    }
    
    func setRightView(image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 0, y: 10, width: 25, height: 25)) // set your Own size
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.height, height: self.frame.height))
        iconContainerView.addSubview(iconView)
        iconContainerView.isUserInteractionEnabled = false
        rightView = iconContainerView
        rightViewMode = .always
        self.tintColor = .lightGray
    }
}

extension UIColor{
    static let AlarmGreenColor: UIColor = UIColor.init(red: 0.067, green: 0.66, blue: 0.21, alpha: 1)
}

extension UIImage{
    func resizeWithPercent(percentage: CGFloat) -> UIImage {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()
        return result
    }
    
    func resizeWithWidth(width: CGFloat) -> UIImage {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()
        return result
    }
}

extension Date {
    func daysFromToday() -> Int {
        return Calendar.current.dateComponents([.day], from: self, to: Date()).day!
    }
}

class NoSelectWebView: WKWebView {
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(paste(_:)) ||
            action == #selector(cut(_:)) ||
            action == #selector(copy(_:)) ||
            action == #selector(select(_:)) ||
            action == #selector(selectAll(_:)) ||
            action == #selector(delete(_:)) ||
            action == #selector(makeTextWritingDirectionLeftToRight(_:)) ||
            action == #selector(makeTextWritingDirectionRightToLeft(_:)) ||
            action == #selector(toggleBoldface(_:)) ||
            action == #selector(toggleItalics(_:)) ||
            action == #selector(toggleUnderline(_:)) {
            return false
        }
        return false//super.canPerformAction(action, withSender: sender)
    }
    
}


//MARK:-=====DATE EXTENSIONS=====

extension Date {
    
    public static let minutesInAWeek = 24 * 60 * 7
    
    /// EZSE: Initializes Date from string and format
    public init?(fromString string: String, format: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if let date = formatter.date(from: string) {
            self = date
        } else {
            return nil
        }
    }
    
    /// EZSE: Initializes Date from string returned from an http response, according to several RFCs / ISO
    public init?(httpDateString: String) {
        if let rfc1123 = Date(fromString: httpDateString, format: "EEE',' dd' 'MMM' 'yyyy HH':'mm':'ss zzz") {
            self = rfc1123
            return
        }
        if let rfc850 = Date(fromString: httpDateString, format: "EEEE',' dd'-'MMM'-'yy HH':'mm':'ss z") {
            self = rfc850
            return
        }
        if let asctime = Date(fromString: httpDateString, format: "EEE MMM d HH':'mm':'ss yyyy") {
            self = asctime
            return
        }
        if let iso8601DateOnly = Date(fromString: httpDateString, format: "yyyy-MM-dd") {
            self = iso8601DateOnly
            return
        }
        if let iso8601DateHrMinOnly = Date(fromString: httpDateString, format: "yyyy-MM-dd'T'HH:mmxxxxx") {
            self = iso8601DateHrMinOnly
            return
        }
        if let iso8601DateHrMinSecOnly = Date(fromString: httpDateString, format: "yyyy-MM-dd'T'HH:mm:ssxxxxx") {
            self = iso8601DateHrMinSecOnly
            return
        }
        if let iso8601DateHrMinSecMs = Date(fromString: httpDateString, format: "yyyy-MM-dd'T'HH:mm:ss.SSSxxxxx") {
            self = iso8601DateHrMinSecMs
            return
        }
        //self.init()
        return nil
    }
    
    /// EZSE: Converts Date to String
    public func toString(dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .medium) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: self)
    }
    
    /// EZSE: Converts Date to String, with format
    public func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
    
    /// EZSE: Calculates how many days passed from now to date
    public func daysInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSince1970 - date.timeIntervalSince1970
        diff = fabs(diff/86400)
        return diff
    }
    
    /// EZSE: Calculates how many hours passed from now to date
    public func hoursInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSince1970 - date.timeIntervalSince1970
        diff = fabs(diff/3600)
        return diff
    }
    
    /// EZSE: Calculates how many minutes passed from now to date
    public func minutesInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSince1970 - date.timeIntervalSince1970
        diff = fabs(diff/60)
        return diff
    }
    
    /// EZSE: Calculates how many seconds passed from now to date
    public func secondsInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSince1970 - date.timeIntervalSince1970
        diff = fabs(diff)
        return diff
    }
    
    /// EZSE: Easy creation of time passed String. Can be Years, Months, days, hours, minutes or seconds
    public func timePassed() -> String {
        let date = Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.year, .month, .day, .hour, .minute, .second], from: self, to: date, options: [])
        var str: String
        
        if components.year! >= 1 {
            components.year == 1 ? (str = "year") : (str = "years")
            return "\(components.year!) \(str) ago"
        } else if components.month! >= 1 {
            components.month == 1 ? (str = "month") : (str = "months")
            return "\(components.month!) \(str) ago"
        } else if components.day! >= 1 {
            components.day == 1 ? (str = "day") : (str = "days")
            return "\(components.day!) \(str) ago"
        } else if components.hour! >= 1 {
            components.hour == 1 ? (str = "hour") : (str = "hours")
            return "\(components.hour!) \(str) ago"
        } else if components.minute! >= 1 {
            components.minute == 1 ? (str = "minute") : (str = "minutes")
            return "\(components.minute!) \(str) ago"
        } else if components.second! >= 1 {
            components.second == 1 ? (str = "second") : (str = "seconds")
            return "\(components.second!) \(str) ago"
        } else {
            return "Just now"
        }
    }
    
    /// EZSE: Check if date is in future.
    public var isFuture: Bool {
        return self > Date()
    }
    
    /// EZSE: Check if date is in past.
    public var isPast: Bool {
        return self < Date()
    }
    
    // EZSE: Check date if it is today
    public var isToday: Bool {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        return format.string(from: self) == format.string(from: Date())
    }
    
    /// EZSE: Check date if it is yesterday
    public var isYesterday: Bool {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let yesterDay = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        return format.string(from: self) == format.string(from: yesterDay!)
    }
    
    /// EZSE: Check date if it is tomorrow
    public var isTomorrow: Bool {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        return format.string(from: self) == format.string(from: tomorrow!)
    }
    
    /// EZSE: Check date if it is within this month.
    public var isThisMonth: Bool {
        let today = Date()
        return self.month == today.month && self.year == today.year
    }
    
    /// EZSE: Check date if it is within this week.
    public var isThisWeek: Bool {
        return self.minutesInBetweenDate(Date()) <= Double(Date.minutesInAWeek)
    }
    
    /// EZSE: Get the era from the date
    public var era: Int {
        return Calendar.current.component(Calendar.Component.era, from: self)
    }
    
    /// EZSE : Get the year from the date
    public var year: Int {
        return Calendar.current.component(Calendar.Component.year, from: self)
    }
    
    /// EZSE : Get the month from the date
    public var month: Int {
        return Calendar.current.component(Calendar.Component.month, from: self)
    }
    
    /// EZSE : Get the weekday from the date
    public var weekday: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    // EZSE : Get the month from the date
    public var monthAsString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
    
    // EZSE : Get the day from the date
    public var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    /// EZSE: Get the hours from date
    public var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    /// EZSE: Get the minute from date
    public var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    /// EZSE: Get the second from the date
    public var second: Int {
        return Calendar.current.component(.second, from: self)
    }
    
    /// EZSE : Gets the nano second from the date
    public var nanosecond: Int {
        return Calendar.current.component(.nanosecond, from: self)
    }
    
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    
    
    var weekEnd : Date{
        
        let calender = Calendar.current
        let todayWeekday = calender.component(.weekday, from: self)
        let addWeekdays = 7 - todayWeekday  // 7: Saturday number
        
        var components = DateComponents()
        components.weekday = addWeekdays
        return calender.date(byAdding: components, to: self)!
        
    }
    
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
    
    #if os(iOS) || os(tvOS)
    
    /// EZSE : Gets the international standard(ISO8601) representation of date
    @available(iOS 10.0, *)
    @available(tvOS 10.0, *)
    public var iso8601: String {
        let formatter = ISO8601DateFormatter()
        return formatter.string(from: self)
    }
    
    #endif
    
    
    func toGlobalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
}




extension UIApplication {
    static var release: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String? ?? "x.x"
    }
    static var build: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String? ?? "x"
    }
    static var version: String {
        return "\(release) (\(build))"
    }
}
