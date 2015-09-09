#= require jquery
# require jquery_ujs
#= require turbolinks
#= require_tree ./shared
#= require_tree .
#= require websocket_rails/main
# ↑ WebSocketを利用するための初期設定ファイル

# --------------------------------------------------------------------------------------------------------------------
class @ChatClass
  constructor: (url, useWebsocket) -> # ソケットをつなぐ重要なもの
    @dispatcher = new WebSocketRails(url, useWebsocket) # WebSocketRailsのインスタンスを生成するには上のrequireが必要
    @events() # イベントを監視
    
  events: () =>
    $('#send').on 'click', @sendMessage # ボタンが押されたらメッセージを送信
    @dispatcher.bind 'new_message', @receiveMessage #サーバーからsend_messageを受け取ったらreceiveMessageを実行
  
  sendMessage: (event) => # サーバー側にsend_messageのイベントを送信
    user_name = $('#username').val()
    msg_body = $('#msgbody').val()
    @dispatcher.trigger 'new_message', { name: user_name , body: msg_body }
    $('#msgbody').val('')
    
  receiveMessage: (message) =>
    $('#chat').append "#{message.name} : #{message.body}"
    
# --------------------------------------------------------------------------------------------------------------------
  
$ ->
  window.chatClass = new ChatClass($('#chat').data('uri'), true)


