$(function () {

  $('#lists-column').sortable({
    // connectWith: ".lists-column",
    items: ".list"
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
  // createCard();
});

function increaseWidth(elm, inc) {
  var width = parseInt(elm.style.width)
  elm.style.width = width + inc + 'px';
}

// CREATE LIST

function createList() {
  // $("#new_board").off('submit').on("submit", (function(e) {
  $("#new_list").on("submit", (function(e) {
    e.preventDefault() 
    e.stopPropagation()
    // var board_name = $('#board_name').val()
    var params = $(this).serialize();

    $.post('/lists/', params).done(function(list) {
      $('#new_list input[type=text]').val("")
      
      var listsColumn = document.getElementById("new_list");
      increaseWidth(listsColumn, "300")
      $('#lists-column').append(
        `
        <div class="list">
          <h5>${list.title}</h5>

          <div class="cards sortable">
          </div>

          <form class="new_card" id="new_card" action="/cards" accept-charset="UTF-8" method="post">
            <input name="utf8" type="hidden" value="✓">
            <input value="${list.id}" type="hidden" name="card[list_id]" id="card_list_id">
            <input placeholder="Add a card..." required="required" class="transparent-input card input" type="text" name="card[content]" id="card_content">
          </form>
        </div>
        `
      )
    })

  }));
}


function createBoard() {
  // $("#new_board").off('submit').on("submit", (function(e) {
  $("#new_board").off('submit').on("submit", (function(e) {
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
       alert('lol error');
      }
    });

  }));
}



