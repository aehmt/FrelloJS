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
});


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



