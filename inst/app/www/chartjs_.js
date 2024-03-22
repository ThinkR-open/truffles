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

    Shiny.addCustomMessageHandler('byyeartype', function(arg) {

 const ctx = document.getElementById(arg.id);

  new Chart(ctx, {
    type: 'bar',
    data: {
      labels: arg.labels,
      datasets: [{
        label: arg.label1,
        data: arg.data1,
        borderColor: '#af4424',
        backgroundColor: '#af4424',
        borderWidth: 1
      },
      {
        label: arg.label2,
        data: arg.data2,
        borderColor: '#556b2f',
        backgroundColor:'#556b2f',
        borderWidth: 1
      }]
    },
    options: {
          responsive: true,
    plugins: {
      legend: {
        position: 'top',
      },
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
