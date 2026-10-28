import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  trigger(event) {
    event.preventDefault()
    const triggerName = event.currentTarget.dataset.oryTrigger
    if (triggerName) {
      this.callWindowFunction(triggerName)
    }
  }

  callWindowFunction(name, attempt = 0) {
    const maxAttempts = 100
    const fn = window[name]

    if (typeof fn === "function") {
      fn()
    } else if (attempt < maxAttempts) {
      setTimeout(() => this.callWindowFunction(name, attempt + 1), 100)
    } else {
      console.error(`Ory: window function "${name}" not found after ${maxAttempts} attempts`)
    }
  }
}
