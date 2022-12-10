	import Foundation

	func inputPath(_ day: Int, _ small: Bool) -> URL {
		let url = small
			? Bundle.module.url(forResource: "day\(day)_input_small", withExtension: "txt")!
			: Bundle.module.url(forResource: "day\(day)_input", withExtension: "txt")!
		return url
	}
