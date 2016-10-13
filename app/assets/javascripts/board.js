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
      
      $('#boards').prepend(
      `<a href="/users/${board.user_id}/boards/${board.id}">
        <div class="board-tile four wide column" style="background: ${board.color}">
          <p>${board.name}</p>
        </div>
      </a>`)

    },
    error: function() {
     alert('lol error');
    }
  });

}));

}
 

$(function () {
  createBoard()
});



