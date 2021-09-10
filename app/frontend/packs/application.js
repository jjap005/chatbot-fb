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

    if (parseInt(answer_user) == 0)
      messages_bot(0)

    if (action == 0)
      messages_bot(parseInt(answer_user))

    if (action == 1)
      messages_bot(parseInt("1" + answer_user))

    if (action == 11)
      add_found(answer_user)

    if (action == 12)
      search_found(answer_user)

    if (action == 3)
      indicators(answer_user)
  }

  function search_found(answer_user) {

    $.ajax({
      method: "post",
      url: "/api/v1/founds/search",
      data: { search: answer_user },
      dataType: "json",
    }).done(function (data) {
      let message = ""
      if (data[0]['error']) {
        message = "<p class='message_bot'>" + data[0]['msg'] + "</p> "
      }
      else {
        message = "<p class='message_bot'>" + data[0]['msg'] + "</p> "

      }
      message += "<p class='message_bot'>Escriba 0 para volver al menu principal o puede seguir consultando saldo </p> "
      $('#messages').append(message)
    });
  }

  function add_found(answer_user) {
    let data = answer_user.split("-")

    $.ajax({
      method: "post",
      url: "/api/v1/founds/add",
      data: { date_receipt: data[0].trim(), amount: data[1].trim(), receipt_number: data[2].trim() },
      dataType: "json",
    }).done(function (data) {
      let message = ""
      if (data[0]['error']) {
        message = "<p class='message_bot'>" + data[0]['msg'] + "</p> "
      }
      else {
        message = "<p class='message_bot'>" + data[0]['msg'] + "</p> "
      }
      message += "<p class='message_bot'>Escriba 0 para volver al menu principal o puede seguir agregando saldo </p> "
      $('#messages').append(message)
    });
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
      message += "<p class='message_bot'>Escriba 0 para volver al menu anterior o puede seguir consultando otros indicadores </p> "
      $('#messages').append(message)
    });

  }

  function messages_bot(action) {

    let message = ""

    if (action == 0) {
      $('#messages').html('')
      message = "<p class='message_bot'>Hola, ¿en que puedo ayudarte? </p> "
      message += "<p class='message_bot'> 1.- Depositos <br/> 2.- Realizar Solicitud Rollos de Papel <br/> 3.- Indicadores Económicos </p>"
      message += "<p class='message_bot'> Escriba su opcion. (1,2 o 3) </p>"
    }

    if (action == 1) {
      message = "<p class='message_bot'> Seleccione una opcion y siga las instrucciones </p> "
      message += "<p class='message_bot'> 1.- Agregar Saldo  <br/> 2.- Consultar Saldo <br/> </p>"
      message += "<p class='message_bot'> Escriba su opcion. (1 ó 2) </p>"
      $('#message').data('action', 1)
    }

    if (action == 11) {
      message = "<p class='message_bot'> Ingrese separado por guion los siguientes datos </p> "
      message += "<p class='message_bot'> Fecha (dd/mm/yyyy) - Saldo a ingresar - numero de deposito </p>"
      $('#message').data('action', 11)
    }

    if (action == 12) {
      message = "<p class='message_bot'> Consulte su deposito, ingrese el numero de deposito </p> "
      message += "<p class='message_bot'> numero de deposito </p>"
      $('#message').data('action', 12)
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
