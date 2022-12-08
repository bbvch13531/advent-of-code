	import Foundation

	func inputPath(day: Int, small: Bool) -> URL {
		let url = small
			? Bundle.module.url(forResource: "day\(day)_input_small", withExtension: "txt")!
			: Bundle.module.url(forResource: "day\(day)_input", withExtension: "txt")!
		return url
	}
