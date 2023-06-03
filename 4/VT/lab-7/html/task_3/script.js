$(document).ready(function() {
    $('form').submit(function(e) {
        e.preventDefault();

        var form = $(this);
        var url = form.attr('action');
        var formData = form.serialize();

        $.ajax({
            type: 'POST',
            url: url,
            data: formData,
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    // Form submitted successfully
                    // Show success message in popup
                    showPopup(response.message, 'success');
                    console.log("Success!");
                } else {
                    // Form submission failed
                    // Show error message in popup
                    showPopup(response.message, 'error');
                    console.log(response.message);
                }
            },
            error: function() {
                // An error occurred during form submission
                // Show error message in popup
                showPopup('An error occurred. Please try again later.', 'error');
            }
        });
    });

    // Close the popup when the close button is clicked
    $('.popup .close').click(function() {
        hidePopup();
    });

    // Close the popup when the user clicks outside the popup content
    $(document).click(function(event) {
        if ($(event.target).closest('.popup-content').length === 0) {
            hidePopup();
        }
    });

    // Show the popup with the specified message and style
    function showPopup(message, style) {
        $('#popup-message').text(message);
        $('#popup').addClass(style);
        $('#popup').fadeIn();
    }

    // Hide the popup and reset its style and message
    function hidePopup() {
        $('#popup').fadeOut(function() {
            $('#popup').removeClass('success error');
            $('#popup-message').text('');
        });
    }
});