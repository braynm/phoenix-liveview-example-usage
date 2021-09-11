// custom event helper to reduce boilerplate on dispatching event in alpinejs
export function dispatchEvent({evtName, payload = {}}, el) {
  const customEvent = new CustomEvent(evtName, { detail: { ...payload, data: true } })
  if (!evtName) {
    throw new Error(`event name is required! supplied with ${evtName}`)
  }

  // dispatch event own or cross-component in alpinejs
  // this can be consume by adding this html attribute:
  //  @event-name="..."
  //  @event-name.window="..."
  //  read more: https://alpinejs.dev/essentials/events
  if (el) {
    el.dispatchEvent(customEvent)
  } else {
    window.dispatchEvent(customEvent)
  }
}
