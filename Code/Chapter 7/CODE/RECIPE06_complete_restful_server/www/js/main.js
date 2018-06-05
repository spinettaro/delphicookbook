// The root URL for the RESTful services
var rootURL = "/books";

var currentBook;

$(document).ready(function(){

  // Retrieve books list when application starts
  findAll();
  
  // Nothing to delete in initial application state
  $('#btnDelete').hide();

  // Register listeners
  $('#btnSearch').click(function() {
      search($('#searchKey').val());
      return false;
  });

  // Trigger search when pressing 'Return' on search key input field
  $('#searchKey').keypress(function(e){
      if(e.which == 13) {
          search($('#searchKey').val());
          e.preventDefault();
          return false;
      }
  });

  $('#btnAdd').click(function() {
      newBook();
      return false;
  });

  $('#btnSave').click(function() {
      if ($('#bookId').val() == '')
			{
          addBook();

			}
      else
          updateBook();
      return false;
  });

  $('#btnDelete').click(function() {
      deleteBook();
      return false;
  });

  $('#booksList a').live('click', function() {
      findById($(this).data('identity'));
  });

  // Replace broken images with generic book folder
  $("img").error(function(){
    $(this).attr("src", "pics/generic.jpg");

  });

});


function search(searchKey) {
	if (searchKey == '')
		findAll();
	else
		findByName(searchKey);
}

function newBook() {
	$('#btnDelete').hide();
	currentBook = {};
	renderDetails(currentBook); // Display empty form
}

function findAll() {
	console.log('findAll');
	$.ajax({
		type: 'GET',
		url: rootURL,
		dataType: "json", // data type of response
		success: renderList
	});
}

function findByName(searchKey) {
	console.log('findByName: ' + searchKey);
	$.ajax({
		type: 'GET',
		url: rootURL + '/search/' + searchKey,
		dataType: "json",
		success: renderList
	});
}

function findById(id) {
	console.log('findById: ' + id);
	$.ajax({
		type: 'GET',
		url: rootURL + '/' + id,
		dataType: "json",
		success: function(data){
			$('#btnDelete').show();
			console.log('findById success: ' + data.name);
			currentBook = data;
			renderDetails(currentBook);
		}
	});
}

function addBook() {
	console.log('addBook');
	$.ajax({
		type: 'POST',
		contentType: 'application/json',
		url: rootURL,
		dataType: "json",
		data: formToJSON(),
		success: function(data, textStatus, jqXHR){
			alert('Book created successfully');
			$('#btnDelete').show();
			$('#bookId').val(data.id);
			findById(data.id);
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert('addBook error: ' + textStatus);
		}
	});
}

function updateBook() {
	console.log('updateBook');
	$.ajax({
		type: 'PUT',
		contentType: 'application/json',
		url: rootURL + '/' + $('#bookId').val(),
		dataType: "json",
		data: formToJSON(),
    processData: false,
		success: function(data, textStatus, jqXHR){
            debugger;
			alert('Book updated successfully');
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert('updateBook error: ' + textStatus);
		}
	});
}

function deleteBook() {
	console.log('deleteBook');
	$.ajax({
		type: 'DELETE',
		url: rootURL + '/' + $('#bookId').val(),
		success: function(data, textStatus, jqXHR){
			alert('Book deleted successfully');
            findAll();
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert('deleteBook error');
		}
	});
}

function renderList(data) {
	// DMVC Server serializes an empty list as null, and a 'collection of one' as an object (not an 'array of one')
	//var list = data == null ? [] : (data.book instanceof Array ? data.book : [data.book]);
    //debugger;
    var list = data;
	$('#booksList li').remove();
	$.each(list, function(index, book) {
		$('#booksList').append('<li><a href="#" data-identity="' + book.id + '">'+book.title+'</a></li>');
	});
}

function renderDetails(book) {
	$('#bookId').val(book.id);
	$('#title').val(book.title);
	$('#author').val(book.author);
	$('#year').val(book.year);
	$('#number_of_pages').val(book.number_of_pages);
	$('#pic').attr('src', 'pics/' + book.picture);
	$('#plot').val(book.plot);
}

// Helper function to serialize all the form fields into a JSON string
function formToJSON() {
	return JSON.stringify({
		"id": parseInt($('#bookId').val()),
		"title": $('#title').val(),
		"author": $('#author').val(),
		"year": parseInt($('#year').val()),
		"number_of_pages": parseInt($('#number_of_pages').val()),
		"picture": currentBook.picture,
		"plot": $('#plot').val()
		});
}
