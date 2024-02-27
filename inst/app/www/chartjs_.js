$( document ).ready(function() {
  Shiny.addCustomMessageHandler('byyear', function(arg) {

 const ctx = document.getElementById(arg.id);

  new Chart(ctx, {
    type: 'bar',
    data: {
      labels: arg.labels,
      datasets: [{
        label: arg.label,
        data: arg.data,
        borderWidth: 1
      }]
    },
    options: {
          responsive: true,
    plugins: {
      title: {
        display: true,
        text: arg.title
      }
    },
      scales: {
        y: {
          beginAtZero: true
        }
      }
    }
  });

  })
});
