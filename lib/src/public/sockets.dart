class SocketEvent {
  static const PING = 'ping';
  static const PONG = 'pong';

  static const CHANGE_ORDER_STATUS = 'CHANGE_ORDER_STATUS';
  static const CHANGE_ORDER_STATUS_TO_USER = 'CHANGE_ORDER_STATUS_TO_USER';

  static const JOIN_ROOM_CSS = 'JOIN_ROOM_CSS';
  static const JOIN_ROOM_SSC = 'JOIN_ROOM_SSC';
  static const JOIN_ROOM_NEW_SSC = 'JOIN_ROOM_NEW_SSC';

  static const LEAVE_ROOM_CSS = 'LEAVE_ROOM_CSS';
  static const LEAVE_ROOM_SSC = 'LEAVE_ROOM_SSC';

  static const STATISTICAL_ROOM_SSC = 'STATISTICAL_ROOM_SSC';

  static const START_QUIZ_CSS = 'START_QUIZ_CSS';
  static const START_QUIZ_SSC = 'START_QUIZ_SSC';

  static const ANSWER_THE_QUESTION_CSS = 'ANSWER_THE_QUESTION_CSS';
  static const ANSWER_THE_QUESTION_SSC = 'ANSWER_THE_QUESTION_SSC';

  static const TAKE_THE_QUESTION_CSS = 'TAKE_THE_QUESTION_CSS';
  static const TAKE_THE_QUESTION_SSC = 'TAKE_THE_QUESTION_SSC';

  static const SEND_FCM_TOKEN_CSS = 'SEND_FCM_TOKEN_CSS';

  static const STATISTICAL_ROOM_FINAL_SSC = 'STATISTICAL_ROOM_FINAL_SSC';

  static const SEEN_MESSAGE_CONVERSATION_SSC = 'SEND_MESSAGE_CONVERSATION_SSC';
  static const SEEN_MESSAGE_CONVERSATION_CSS = 'SEND_MESSAGE_CONVERSATION_CSS';
  static const JOIN_CONVERSATION_SSC = 'JOIN_CONVERSATION_SSC';
  static const JOIN_CONVERSATION_CSS = 'JOIN_CONVERSATION_CSS';
  static const LEAVE_CONVERSATION_SSC = 'LEAVE_CONVERSATION_SSC';
  static const LEAVE_CONVERSATION_CSS = 'LEAVE_CONVERSATION_CSS';
}