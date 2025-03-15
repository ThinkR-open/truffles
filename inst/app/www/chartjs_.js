$( document ).ready(function() {

  let newChart = null;
  let newChart1 = null;
  
  Chart.defaults.color = '#f2eeed';
      // Chart.defaults.backgroundColor = '#f2eeed';
      // Chart.defaults.borderColor = '#f2eeed';

  Shiny.addCustomMessageHandler('byyear', function(arg) {

if (newChart) newChart.destroy();

const ctx = document.getElementById(arg.id);


newChart =  new Chart(ctx, {
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
      aspectRatio: 1.1, 
          responsive: true,
          // indexAxis: 'y',
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

      if (newChart1) newChart1.destroy();

 const ctx = document.getElementById(arg.id);
 
 newChart1 = 
  new Chart(ctx, {
    type: 'bar',
    data: {
      labels: arg.labels,
      datasets: [{
        label: arg.label1,
        data: arg.data1,
        borderColor: '#FF0000',
        backgroundColor: '#FF0000',
        borderWidth: 1
      },
      {
        label: arg.label2,
        data: arg.data2,
        borderColor: '#FFA500',
        backgroundColor:'#FFA500',
        borderWidth: 1
      }]
    },
    options: {
        aspectRatio: 1.1, 
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
