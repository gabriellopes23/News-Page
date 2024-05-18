
import Foundation

extension String {
    func formattedDateFromISO8601() -> String {
        // Criar um ISO8601DateFormatter para converter a string para um objeto Date
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withTimeZone, .withDashSeparatorInDate, .withColonSeparatorInTime]
        
        // Converter a string para Date
        if let date = isoFormatter.date(from: self) {
            // Agora, você pode formatar a data em qualquer outro formato desejado
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            dateFormatter.timeZone = TimeZone.current // Defina o fuso horário, se necessário

            // Converter o objeto Date de volta para uma string formatada
            let formattedDateString = dateFormatter.string(from: date)
            return formattedDateString
        } else {
            return "Formato de data inválido"
        }
    }
}
