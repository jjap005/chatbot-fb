// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import '../js/bootstrap_js_files.js'
import $ from "jquery"


Rails.start()
Turbolinks.start()
ActiveStorage.start()


$(document).on('turbolinks:load', function () {


  $("#send_message").on('submit', function (e) {
    e.preventDefault();
    let message = $('#message')
    $('#messages').append(`<p class='message_user'>` + message.val() + '</p>')

    actions_bot(message.data('action'), message.val())
    $('#message').val('')

  });

  function actions_bot(action, answer_user) {
    action = parseInt(action)
    if (!Number.isInteger(action)) {
      $('#messages').html('')
      messages_bot(0)
      return false
    }

    if (action == 0)
      messages_bot(parseInt(answer_user))

    if (action == 3)
      indicators(answer_user)


  }

  function indicators(param) {
    $.ajax({
      method: "get",
      url: "/api/v1/indicator/" + param,
      data: { format: 'json' },
      dataType: "json",
    }).done(function (data) {
      let message = ""
      if (data[0]['error']) {
        message = "<p class='message_bot'>" + data[0]['msg'] + "</p> "
      }
      else {
        message = "<p class='message_bot'>" + data[0]['msg'][0]['name'] + " " + data[0]['msg'][0]['value'] + " " + data[0]['msg'][0]['units'] + "</p> "

      }
      $('#messages').append(message)
    });

  }

  function messages_bot(action) {

    let message = ""

    if (action == 0) {
      $('#messages').html('')
      message = "<p class='message_bot'>Hola, ¿en que puedo ayudarte? </p> "
      message += "<p class='message_bot'> 1.- Consultar Deposito <br/> 2.- Realizar Solicitud Rollos de Papel <br/> 3.- Indicadores Económicos </p>"
      message += "<p class='message_bot'> Escriba su opcion. (1,2 o 3) </p>"
    }

    if (action == 3) {
      message = "<p class='message_bot'>Actualmente puedes consultar los siguientes indicadores: </p> "
      message += "<p class='message_bot'> 1.- Unidad de Fomento (uf) <br/> 2.- Dolar (dolar)  <br/> Unidad Tributaria Mensual (utm) </p>"
      message += "<p class='message_bot'> envie la abreviatura del indicador que desea consultar (uf, dolar, utm) </p>"
      $('#message').data('action', 3)
    }

    $('#messages').append(message)
  }

})
