extension APIScope {
    /// https://vk.com/dev/messages
    public enum Messages: APIMethod {
        case addChatUser(Parameters)
        case allowMessagesFromGroup(Parameters)
        case createChat(Parameters)
        case delete(Parameters)
        case deleteChatPhoto(Parameters)
        case deleteDialog(Parameters)
        case denyMessagesFromGroup(Parameters)
        case editChat(Parameters)
        case get(Parameters)
        case getById(Parameters)
        case getChat(Parameters)
        case getChatUsers(Parameters)
        case getDialogs(Parameters)
        case getHistory(Parameters)
        case getHistoryAttachments(Parameters)
        case getLastActivity(Parameters)
        case getLongPollHistory(Parameters)
        case getLongPollServer(Parameters)
        case isMessagesFromGroupAllowed(Parameters)
        case markAsAnsweredDialog(Parameters)
        case markAsImportant(Parameters)
        case markAsImportantDialog(Parameters)
        case markAsRead(Parameters)
        case removeChatUser(Parameters)
        case restore(Parameters)
        case search(Parameters)
        case searchDialogs(Parameters)
        case send(Parameters)
        case setActivity(Parameters)
        case setChatPhoto(Parameters)
    }
}
