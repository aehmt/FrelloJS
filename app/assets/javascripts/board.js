function increaseWidth(elm, inc) {
  var width = parseInt(elm.style.width)
  elm.style.width = (width + inc) + 'px';
}

// CREATE CARD


function createCard() {
  // $("#new_board").off('submit').on("submit", (function(e) {
  $('#lists').on("submit", "#new_card", function(e) {
  // $(document).on("submit", "#new_card", function(e) {
  // $(".list.ui-sortable-handle").on("submit", "#new_card", function(e) {
    e.preventDefault(); 
    e.stopPropagation();
    // var board_name = $('#board_name').val()
    var params = $(this).serialize();
    var form = $(this)
    $.post('/cards/', params).done(function(card) {
      form.find('input[type=text]').val("")
      // debugger
      //
      form.parent().find('.cards.sortable.ui-sortable').append($(
        `
          <div class="card ui-sortable-handle"> 
            <p class="card-content">${card.content}</p>

            <div class="collaborators">
            </div>
          </div>
        `
      ))
    })
  });
}
// CREATE LIST


class List {
  constructor(id, title, position, cards) {
    this.title = title
    this.position = position
    this.id = id
    this.cards = cards
  }

  cardsCount() {
    return this.cards.length
  }
}


function createList() {
  // $("#new_board").off('submit').on("submit", (function(e) {
  $("#new_list").on("submit", (function(e) {
    e.preventDefault() 
    e.stopPropagation()
    // var board_name = $('#board_name').val()
    var params = $(this).serialize();


    $.post('/lists/', params).done(function(list) {
      var listObj = new List(list.id, list.title, list.position, list.cards)

      $('#new_list input[type=text]').val("")
      
      var listsColumn = document.getElementById("lists-column");
      
      $('#lists').append($(
        `
        <div class="list ui-sortable-handle">
          <h5>${listObj.title}</h5>
          <div class="cards sortable ui-sortable">
          </div>

          <form class="new_card" id="new_card" action="/cards" accept-charset="UTF-8" method="post">
            <input name="utf8" type="hidden" value="✓">
            <input value="${listObj.id}" type="hidden" name="card[list_id]" id="card_list_id">
            <input placeholder="Add a card..." required="required" class="transparent-input card input" type="text" name="card[content]" id="card_content">
          </form>
        </div>
        `
      ))
      increaseWidth(listsColumn, 228)
    })

  }));
}

// CREATE BOARD

function createBoard() {
  // $("#new_board").off('submit').on("submit", (function(e) {
  $("#new_board").on("submit", (function(e) {
    e.preventDefault() 
    e.stopPropagation()
    // var board_name = $('#board_name').val()
    var params = $(this).serialize();

    $.ajax({
      url: "/boards/create",
      type: "POST",
      data :params,
      success: function(board) {
        $('#board_name').val("")
        $('#boards').prepend($(
        `<a href="/users/${board.user_id}/boards/${board.id}">
          <div class="board-tile four wide column" style="background: ${board.color}">
            <p>${board.name}</p>
          </div>
        </a>`).fadeIn('slow'))

      },
      error: function() {
       alert('error');
      }
    });

  }));
}



class Board {
  constructor(id, name, color, user_id) {
    this.id = id
    this.user_id = user_id
    this.name = name
    this.color = color 
  }

  boardRender() {
    return `
    <a href="/users/${this.user_id}/boards/${this.id}">
      <div class="board-tile four wide column" style="background: ${this.color}">
        <p> ${this.name} </p>
      </div>
    </a>
    `
  }
}


function getBoards() {
  if ($(location).attr('href') === "http://localhost:3000/") {
    
    $.ajax({
      url: "/boards/index", 
      type: 'GET'

    }).done(function(boards){
      var len = boards.length 
      for (var i = 0, len; i < len; i++) {
        var boardObj = new Board(boards[i].id, boards[i].name, boards[i].color, boards[i].user_id)
        $('#boards').prepend($(
          boardObj.boardRender()
        ).fadeIn("slow"))
      } 
    })
  } 
}


// $(document).on('page:fetch', function() { 
$(document).on('turbolinks:load', function() {
// $(function () {
  $('#lists').sortable({
    // connectWith: ".lists-column",
    items: ".list",
    start: function(e, list) {
      list.item.addClass("rotate")
    },
    stop: function(e, list) {
      list.item.removeClass("rotate")
    },
    placeholder: {
      element: function(item) {
          return $(
          `<div class="list" style="width: 225px; height: ${item.css('height')}; background: rgba(0,0,0,0.2)">
          </div>`
          )[0];
      },
      update: function(container, p) {
          return;
      }
    } 
  })

  $(".cards").sortable({
    connectWith: ".sortable",
    // items: ".card"
  })

  $( ".cards" ).disableSelection();

  $('.ui.dropdown').dropdown({action:'nothing'});

  $('.ui.sidebar').sidebar({
    context: $('.pushable'),
    dimPage: false
  }).sidebar('setting', 'transition', 'overlay').sidebar('attach events', '.item.sidebar-toggler');

  // $('.sidebar').sidebar('setting', 'transition', 'overlay').sidebar('toggle');

  createBoard();
  createList();
  createCard();
  getBoards();
});
