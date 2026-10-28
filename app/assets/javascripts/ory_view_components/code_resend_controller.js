import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    seconds: { type: Number, default: 60 }
  }

  static targets = ["button", "countdown"]

  connect() {
    this.remaining = this.secondsValue
    this.startCountdown()
  }

  disconnect() {
    this.stopCountdown()
  }

  startCountdown() {
    this.disableButton()
    this.updateDisplay()

    this.timer = setInterval(() => {
      this.remaining -= 1
      this.updateDisplay()

      if (this.remaining <= 0) {
        this.stopCountdown()
        this.enableButton()
      }
    }, 1000)
  }

  stopCountdown() {
    if (this.timer) {
      clearInterval(this.timer)
      this.timer = null
    }
  }

  disableButton() {
    if (this.hasButtonTarget) {
      this.buttonTarget.disabled = true
    }
  }

  enableButton() {
    if (this.hasButtonTarget) {
      this.buttonTarget.disabled = false
    }
  }

  updateDisplay() {
    if (this.hasCountdownTarget) {
      if (this.remaining > 0) {
        this.countdownTarget.textContent = `(${this.remaining}s)`
      } else {
        this.countdownTarget.textContent = ""
      }
    }
  }
}
