jQuery.extend(jQuery.easing,
{
  easeInQuart: function (x, t, b, c, d) {
    return c*(t/=d)*t*t*t + b;
  },
});

$(function () {
  $('#messages .row').on('click', function () {
    $(this).animate(
      {
        height: 0,
        opacity: 0,
      },
      300,
      'easeInQuart',
      function () { $(this).remove(); }
    );
  });
});
