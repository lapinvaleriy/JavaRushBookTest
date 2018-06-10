function updateValidation() {
    var title = $('#title').val();
    var description = $('#description').val();
    var year = $('#year').val();
    var isbn = $('#isbn').val();

    if (title.length == 0 || title.length > 99) {
        alert('Поле "Название книги" не может быть пустым!');
        return false;
    }

    if (description.length == 0 || description.length > 254) {
        alert('Поле "Описание" не может быть пустым!');
        return false;
    }

    if (year > 0) {

    } else {
        alert('Некоректный год написания!');
        return false;
    }

    if (isbn.length == 0 || isbn.length > 24) {
        alert('Некоректный ISBN!');
        return false;
    }

    return true;
};

function addValidation() {
    var title = $('#title').val();
    var author = $('#author').val();
    var description = $('#description').val();
    var year = $('#year').val();
    var isbn = $('#isbn').val();
    var readAlready = $('#readAlready').val().trim();

    if (title.length == 0 || title.length > 99) {
        alert('Поле "Название книги" не может быть пустым!');
        return false;
    }

    if (description.length == 0 || description.length > 254) {
        alert('Поле "Описание" не может быть пустым!');
        return false;
    }

    if (author.length == 0 || author.length > 99) {
        alert('Поле "Автор" не может быть пустым!');
        return false;
    }

    if (year > 0) {

    } else {
        alert('Некоректный год написания!');
        return false;
    }

    if (isbn.length == 0 || isbn.length > 24) {
        alert('Некоректный ISBN!');
        return false;
    }

    if (readAlready.length != 0) {
        if (readAlready.toLowerCase() == "true" || readAlready.toLowerCase() == "false") {
            return true;
        } else {
            alert('Поле "Прочитана" требует "true" или "false"');
            return false;
        }
    }
    else {
        alert('Поле "Прочитана" не может быть пустым');
        return false;
    }

    return true;
};