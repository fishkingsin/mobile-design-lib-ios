//
// ThemeManager.swift
//
// Copyright © 2022 New Media Group. All rights reserved.
//

import Foundation

protocol ThemeManageable {
    associatedtype ImplementationType
    var currentTheme: NMGThemeable { get }
    func applyTheme(_ theme: NMGThemeable)
}

public enum Theme {
    case ED
    case WW
    case KISS
    case MORE
    case GOTRIP
    case OS
    case NM
    case OH
    case Default(String)

    public init(rawValueString: String) {
        self = rawValueString.theme
    }
}

extension String {
    var theme: Theme {
        switch self {
            case "ED":
                return .ED
            case "WW":
                return .WW
            case "KISS":
                return .KISS
            case "MORE":
                return .MORE
            case "GOTRIP":
                return .GOTRIP
            case "OS":
                return .OS
            case "NM":
                return .NM
            case "OH":
                return .OH
            default:
                return .Default(self)
        }
    }
}

extension Theme {
    var themeableColors: any NMGThemeableColors {
        switch self {
            case .ED:
                return EDColors()
            case .WW:
                return WWColors()
            case .KISS:
                return KISSColors()
            case .MORE:
                return MOREColors()
            case .GOTRIP:
                return GOTRIPColors()
            case .OS:
                return OSColors()
            case .NM:
                return NMColors()
            case .OH:
                return OHColors()
            case .Default(let customTheme):
                return NMGDefaultColors(customTheme)
        }
    }
}

public final class ThemeManager: ThemeManageable {
    public typealias ImplementationType = ThemeManager
    public enum Static {
        public static var instance: ImplementationType?
    }

    public static var shared: ImplementationType {
        guard let instance = Static.instance else {
            Static.instance = ThemeManager()
            return Static.instance!
        }
        return instance
    }

    public var currentTheme: NMGThemeable {
        if _currentTheme == nil {
            _currentTheme = NMGDefaultTheme()
        }
        return _currentTheme
    }
    public func applyTheme(name theme: String) {
        let theme = Theme(rawValueString: theme)
        applyTheme(theme)
    }

    public func applyTheme(_ theme: Theme) {
        _currentTheme = NMGDefaultTheme({
            theme.themeableColors
        }, {
            NMGDefaultFonts()
        }, {
            NMGDefaultIcons()
        })
    }

    public func applyTheme(_ theme: NMGThemeable) {
        _currentTheme = theme
    }

    private var _currentTheme: NMGThemeable!
}
