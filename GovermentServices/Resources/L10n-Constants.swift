// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum HotWaterShutoff {
    /// корпус
    internal static let corpus = L10n.tr("Localizable", "HotWaterShutoff.Corpus")
    /// Загрузка данных...
    internal static let downloading = L10n.tr("Localizable", "HotWaterShutoff.Downloading")
    /// ГВС сохранено
    internal static let hotWaterNotShutoff = L10n.tr("Localizable", "HotWaterShutoff.HotWaterNotShutoff")
    /// дом
    internal static let house = L10n.tr("Localizable", "HotWaterShutoff.House")
    /// литер
    internal static let litera = L10n.tr("Localizable", "HotWaterShutoff.Litera")
    /// Повторить
    internal static let retry = L10n.tr("Localizable", "HotWaterShutoff.Retry")
    /// График отключения ГВС
    internal static let title = L10n.tr("Localizable", "HotWaterShutoff.Title")
    internal enum Errors {
      /// Не удалось прочитать данные
      internal static let dataError = L10n.tr("Localizable", "HotWaterShutoff.Errors.DataError")
      /// Ошибка соединения
      internal static let networkError = L10n.tr("Localizable", "HotWaterShutoff.Errors.NetworkError")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle = Bundle(for: BundleToken.self)
}
// swiftlint:enable convenience_type
