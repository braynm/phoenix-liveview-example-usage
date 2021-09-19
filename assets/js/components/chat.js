import topbar from "topbar"
import { append, either, ifElse, isEmpty, isNil, pick } from "ramda"
export default function chat() {
  return {
    message: "",
    user: "",
    activeChat: "",
    chats: {},
    selectChat(room) {
      this.activeChat = room
      setTimeout(() =>
        document.querySelector('.messages').scrollIntoView({ behavior: 'smooth', block: 'end' })
      , 500)
    },
    receiveMessage(data) {
      const chat = this.chats[data.chat]
      const payload = pick(["message", "user", "chat"], data)

      ifElse(
        either(isNil, isEmpty),
        () => this.chats[data.chat] = [payload],
        (messages) => this.chats[data.chat] = append(payload, messages)
      )(chat)
      setTimeout(() =>
        document.querySelector('.messages').scrollIntoView({ behavior: 'smooth', block: 'end' })
      , 500)
    },
    handleSubmitMessage(data) {
      const value = document.querySelector("input[name='message']").value
      if (value) {
        document.querySelector('.messages').scrollIntoView({ behavior: 'smooth', block: 'end' });
        document.querySelector("input[name='message']").value = ''
        window.ChatHook.sendMessage({ value, chat: this.activeChat })
      }
    }
  }
}
