// SwiftDate
// Manage Date/Time & Timezone in Swift
//
// Created by: Daniele Margutti
// Email: <hello@danielemargutti.com>
// Web: <http://www.danielemargutti.com>
//
// Licensed under MIT License.

import Foundation

// MARK: - CalendarName Shortcut

/// This enum allows you set a valid calendar using swift's type safe support
public enum CalendarName: RawRepresentable {
	public typealias RawValue = String
	
	case current, currentAutoUpdating
	case gregorian, buddhist, chinese, coptic, ethiopicAmeteMihret, ethiopicAmeteAlem, hebrew,
	iso8601, indian, islamic, islamicCivil, japanese, persian, republicOfChina, islamicTabular,
	islamicUmmAlQura
	
	/// Raw value of the calendar
	public var rawValue: RawValue {
		switch self {
		case .currentAutoUpdating:		return "current_autoupdating"
		case .current:					return "current"
		case .gregorian:				return "gregorian"
		case .buddhist:					return "buddhist"
		case .chinese:					return "chinese"
		case .coptic:					return "coptic"
		case .ethiopicAmeteMihret:		return "ethiopicAmeteMihret"
		case .ethiopicAmeteAlem:		return "ethiopicAmeteAlem"
		case .hebrew:					return "hebrew"
		case .iso8601:					return "iso8601"
		case .indian:					return "indian"
		case .islamic:					return "islamic"
		case .islamicCivil:				return "islamicCivil"
		case .japanese:					return "japanese"
		case .persian:					return "persian"
		case .republicOfChina:			return "republicOfChina"
		case .islamicTabular:			return "islamicTabular"
		case .islamicUmmAlQura:			return "islamicUmmAlQura"
		}
	}
	
	// Initialize a new CalendarName from raw string value. If valid calendar can be created `nil` is returned
	public init?(rawValue: RawValue) {
		switch rawValue {
		case CalendarName.currentAutoUpdating.rawValue:			self = .currentAutoUpdating
		case CalendarName.current.rawValue:						self = .current
		case CalendarName.gregorian.rawValue:					self = .gregorian
		case CalendarName.buddhist.rawValue:					self = .buddhist
		case CalendarName.ethiopicAmeteMihret.rawValue:			self = .ethiopicAmeteMihret
		case CalendarName.ethiopicAmeteAlem.rawValue:			self = .ethiopicAmeteAlem
		case CalendarName.hebrew.rawValue:						self = .hebrew
		case CalendarName.iso8601.rawValue:						self = .iso8601
		case CalendarName.indian.rawValue:						self = .indian
		case CalendarName.islamic.rawValue:						self = .islamic
		case CalendarName.islamicCivil.rawValue:				self = .islamicCivil
		case CalendarName.japanese.rawValue:					self = .japanese
		case CalendarName.persian.rawValue:						self = .persian
		case CalendarName.republicOfChina.rawValue:				self = .republicOfChina
		case CalendarName.islamicTabular.rawValue:				self = .islamicTabular
		case CalendarName.islamicUmmAlQura.rawValue:			self = .islamicUmmAlQura
		default: return nil
		}
	}
	
	/// Initialize a new CalendarName from identifier
	///
	/// - Parameter identifier: identifier of the calendar, if `nil` `autoupdatingCurrent` calendar is set
	public init(_ identifier: Calendar.Identifier?) {
		guard let id = identifier else {
			self = CalendarName.currentAutoUpdating
			return
		}
		
		switch id {
		case .gregorian:				self = CalendarName.gregorian
		case .buddhist:					self = CalendarName.buddhist
		case .chinese:					self = CalendarName.chinese
		case .coptic:					self = CalendarName.coptic
		case .ethiopicAmeteMihret:		self = CalendarName.ethiopicAmeteMihret
		case .ethiopicAmeteAlem:		self = CalendarName.ethiopicAmeteAlem
		case .hebrew:					self = CalendarName.hebrew
		case .iso8601:					self = CalendarName.iso8601
		case .indian:					self = CalendarName.indian
		case .islamic:					self = CalendarName.islamic
		case .islamicCivil:				self = CalendarName.islamicCivil
		case .japanese:					self = CalendarName.japanese
		case .persian:					self = CalendarName.persian
		case .republicOfChina:			self = CalendarName.republicOfChina
		case .islamicTabular:			self = CalendarName.islamicTabular
		case .islamicUmmAlQura:			self = CalendarName.islamicUmmAlQura
		}
	}
	
	/// Return a new `Calendar` instance from a given identifier
	public var calendar: Calendar {
		var identifier: Calendar.Identifier
		switch self {
		case .current:				return Calendar.current
		case .currentAutoUpdating:	return Calendar.autoupdatingCurrent
		case .gregorian:			identifier = Calendar.Identifier.gregorian
		case .buddhist:				identifier = Calendar.Identifier.buddhist
		case .chinese:				identifier = Calendar.Identifier.chinese
		case .coptic:				identifier = Calendar.Identifier.coptic
		case .ethiopicAmeteMihret:	identifier = Calendar.Identifier.ethiopicAmeteMihret
		case .ethiopicAmeteAlem:	identifier = Calendar.Identifier.ethiopicAmeteAlem
		case .hebrew:				identifier = Calendar.Identifier.hebrew
		case .iso8601:				identifier = Calendar.Identifier.iso8601
		case .indian:				identifier = Calendar.Identifier.indian
		case .islamic:				identifier = Calendar.Identifier.islamic
		case .islamicCivil:			identifier = Calendar.Identifier.islamicCivil
		case .japanese:				identifier = Calendar.Identifier.japanese
		case .persian:				identifier = Calendar.Identifier.persian
		case .republicOfChina:		identifier = Calendar.Identifier.republicOfChina
		case .islamicTabular:		identifier = Calendar.Identifier.islamicTabular
		case .islamicUmmAlQura:		identifier = Calendar.Identifier.islamicUmmAlQura
		}
		return Calendar(identifier: identifier)
	}
	
	//	Identifier of the calendar
	public var identifier: Calendar.Identifier {
		return self.calendar.identifier
	}
}

//MARK: Calendar.Component Extension

extension Calendar.Component {
	fileprivate var cfValue: CFCalendarUnit {
		return CFCalendarUnit(rawValue: self.rawValue)
	}
}

extension Calendar.Component {
	/// https://github.com/apple/swift-corelibs-foundation/blob/swift-DEVELOPMENT-SNAPSHOT-2016-09-10-a/CoreFoundation/Locale.subproj/CFCalendar.h#L68-L83
	internal var rawValue: UInt {
		switch self {
		case .era:               return 1 << 1
		case .year:              return 1 << 2
		case .month:             return 1 << 3
		case .day:               return 1 << 4
		case .hour:              return 1 << 5
		case .minute:            return 1 << 6
		case .second:            return 1 << 7
		case .weekday:           return 1 << 9
		case .weekdayOrdinal:    return 1 << 10
		case .quarter:           return 1 << 11
		case .weekOfMonth:       return 1 << 12
		case .weekOfYear:        return 1 << 13
		case .yearForWeekOfYear: return 1 << 14
		case .nanosecond:        return 1 << 15
		case .calendar:          return 1 << 16
		case .timeZone:          return 1 << 17
        case .isLeapMonth:       return 1 << 18
        }
	}
	
	internal init?(rawValue: UInt) {
		switch rawValue {
		case Calendar.Component.era.rawValue:               self = .era
		case Calendar.Component.year.rawValue:              self = .year
		case Calendar.Component.month.rawValue:             self = .month
		case Calendar.Component.day.rawValue:               self = .day
		case Calendar.Component.hour.rawValue:              self = .hour
		case Calendar.Component.minute.rawValue:            self = .minute
		case Calendar.Component.second.rawValue:            self = .second
		case Calendar.Component.weekday.rawValue:           self = .weekday
		case Calendar.Component.weekdayOrdinal.rawValue:    self = .weekdayOrdinal
		case Calendar.Component.quarter.rawValue:           self = .quarter
		case Calendar.Component.weekOfMonth.rawValue:       self = .weekOfMonth
		case Calendar.Component.weekOfYear.rawValue:        self = .weekOfYear
		case Calendar.Component.yearForWeekOfYear.rawValue: self = .yearForWeekOfYear
		case Calendar.Component.nanosecond.rawValue:        self = .nanosecond
		case Calendar.Component.calendar.rawValue:          self = .calendar
		case Calendar.Component.timeZone.rawValue:          self = .timeZone
		default:
            if #available(iOSApplicationExtension 17, *), rawValue == Calendar.Component.isLeapMonth.rawValue {
                self = .isLeapMonth
                return
            }
            return nil
		}
	}
}

//MARK: - Calendar Extension

extension Calendar {
	
	// The code below is part of the Swift.org code. It is included as rangeOfUnit is a very useful
	// function for the startOf and endOf functions.
	// As always we would prefer using Foundation code rather than inventing code ourselves.
	typealias CFType = CFCalendar
	
	private var cfObject: CFType {
		return unsafeBitCast(self as NSCalendar, to: CFCalendar.self)
	}
	
	
	/// Revised API for avoiding usage of AutoreleasingUnsafeMutablePointer.
	/// The current exposed API in Foundation on Darwin platforms is:
	/// `public func rangeOfUnit(unit: NSCalendarUnit, startDate datep:
	/// AutoreleasingUnsafeMutablePointer<NSDate?>, interval tip:
	/// UnsafeMutablePointer<NSTimeInterval>, forDate date: NSDate) -> Bool`
	/// which is not implementable on Linux due to the lack of being able to properly implement
	/// AutoreleasingUnsafeMutablePointer.
	///
	/// - parameters:
	///     - component: the unit to determine the range for
	///     - date: the date to wrap the unit around
	/// - returns: the range (date interval) of the unit around the date
	///
	/// - Experiment: This is a draft API currently under consideration for official import into
	///     Foundation as a suitable alternative
	/// - Note: Since this API is under consideration it may be either removed or revised in the
	///     near future
	///
	public func rangex(of component: Calendar.Component, for date: Date) -> DateTimeInterval? {
		var start: CFAbsoluteTime = 0.0
		var ti: CFTimeInterval = 0.0
		let res: Bool = withUnsafeMutablePointer(to: &start) { startp -> Bool in
			return withUnsafeMutablePointer(to: &ti) { tip -> Bool in
				let startPtr: UnsafeMutablePointer<CFAbsoluteTime> =
				startp
				let tiPtr: UnsafeMutablePointer<CFTimeInterval> =
				tip
				return CFCalendarGetTimeRangeOfUnit(cfObject, component.cfValue,
				                                    date.timeIntervalSinceReferenceDate, startPtr, tiPtr)
			}
		}
		
		if res {
			let startDate = Date(timeIntervalSinceReferenceDate: start)
			return DateTimeInterval(start: startDate, duration: ti)
		}
		return nil
	}
	
	/// Create a new NSCalendar instance from CalendarName structure. You can also use
	/// <CalendarName>.calendar to get a new instance of NSCalendar with picked type.
	///
	/// - parameter type: type of the calendar
	///
	/// - returns: instance of the new Calendar
	public static func fromType(_ type: CalendarName) -> Calendar {
		return type.calendar
	}
	
}
