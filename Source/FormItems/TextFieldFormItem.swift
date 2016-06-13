// MIT license. Copyright (c) 2015 SwiftyFORM. All rights reserved.
import Foundation

public class TextFieldFormItem: FormItem {
	override func accept(_ visitor: FormItemVisitor) {
		visitor.visitTextField(self)
	}
	
	public var keyboardType: UIKeyboardType = .default
	public func keyboardType(_ keyboardType: UIKeyboardType) -> Self {
		self.keyboardType = keyboardType
		return self
	}
	
	
	public var autocorrectionType: UITextAutocorrectionType = .no
	public var autocapitalizationType: UITextAutocapitalizationType = .none
	public var spellCheckingType: UITextSpellCheckingType = .no
	public var secureTextEntry = false
	
	public var returnKeyType: UIReturnKeyType = .default
	public func returnKeyType(_ returnKeyType: UIReturnKeyType) -> Self {
		self.returnKeyType = returnKeyType
		return self
	}
	
	
	public typealias SyncBlock = (value: String) -> Void
	public var syncCellWithValue: SyncBlock = { (string: String) in
		SwiftyFormLog("sync is not overridden")
	}
	
	internal var innerValue: String = ""
	public var value: String {
		get {
			return self.innerValue
		}
		set {
			self.assignValueAndSync(newValue)
		}
	}
	
	public typealias TextDidChangeBlock = (value: String) -> Void
	public var textDidChangeBlock: TextDidChangeBlock = { (value: String) in
		SwiftyFormLog("not overridden")
	}
	
	public func textDidChange(_ value: String) {
		innerValue = value
		textDidChangeBlock(value: value)
	}

	public func assignValueAndSync(_ value: String) {
		innerValue = value
		syncCellWithValue(value: value)
	}
	
	public var reloadPersistentValidationState: (Void) -> Void = {}
	
	
	public var obtainTitleWidth: (Void) -> CGFloat = {
		return 0
	}
	
	public var assignTitleWidth: (CGFloat) -> Void = { (width: CGFloat) in
		// do nothing
	}
	
	
	public var placeholder: String = ""
	public func placeholder(_ placeholder: String) -> Self {
		self.placeholder = placeholder
		return self
	}
	
	public var title: String = ""
	public func title(_ title: String) -> Self {
		self.title = title
		return self
	}
	
	public func password() -> Self {
		self.secureTextEntry = true
		return self
	}
	
	public let validatorBuilder = ValidatorBuilder()
	
	public func validate(_ specification: Specification, message: String) -> Self {
		validatorBuilder.hardValidate(specification, message: message)
		return self
	}
	
	public func softValidate(_ specification: Specification, message: String) -> Self {
		validatorBuilder.softValidate(specification, message: message)
		return self
	}
	
	public func submitValidate(_ specification: Specification, message: String) -> Self {
		validatorBuilder.submitValidate(specification, message: message)
		return self
	}
	
	public func required(_ message: String) -> Self {
		submitValidate(CountSpecification.min(1), message: message)
		return self
	}
	
	public func liveValidateValueText() -> ValidateResult {
		return  validatorBuilder.build().liveValidate(self.value)
	}
	
	public func liveValidateText(_ text: String) -> ValidateResult {
		return validatorBuilder.build().validate(text, checkHardRule: true, checkSoftRule: true, checkSubmitRule: false)
	}
	
	public func submitValidateValueText() -> ValidateResult {
		return validatorBuilder.build().submitValidate(self.value)
	}
	
	public func submitValidateText(_ text: String) -> ValidateResult {
		return validatorBuilder.build().validate(text, checkHardRule: true, checkSoftRule: true, checkSubmitRule: true)
	}
	
	public func validateText(_ text: String, checkHardRule: Bool, checkSoftRule: Bool, checkSubmitRule: Bool) -> ValidateResult {
		return validatorBuilder.build().validate(text, checkHardRule: checkHardRule, checkSoftRule: checkSoftRule, checkSubmitRule: checkSubmitRule)
	}
}
