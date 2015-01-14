function addRowHandlers(book) {
    var table = document.getElementById("t01");
    var rows = table.getElementsByTagName("tr");
    for (i = 0; i < rows.length; i++) {
        var currentRow = table.rows[i];
        var createClickHandler = 
            function(row) 
            {
                return function() { 
                       var cell = row.getElementsByTagName("td")[0];
                       var title = cell.innerHTML;
                       alert(books.get(title).description);
                };
            };

        currentRow.onclick = createClickHandler(currentRow);
    }
}

function addToCart(bookTitle) {
	
}
