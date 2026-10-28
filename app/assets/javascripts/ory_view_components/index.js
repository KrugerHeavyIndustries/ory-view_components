import WebauthnController from "./webauthn_controller"
import PasskeyController from "./passkey_controller"
import CodeResendController from "./code_resend_controller"

export { WebauthnController, PasskeyController, CodeResendController }

export function registerOryControllers(application) {
  application.register("ory-webauthn", WebauthnController)
  application.register("ory-passkey", PasskeyController)
  application.register("ory-code-resend", CodeResendController)
}
