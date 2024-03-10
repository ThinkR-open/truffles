$( document ).ready(function() {

  Shiny.addCustomMessageHandler('modal', function(arg) {

Swal.fire({
  title: 'Chêne  ' + arg.id + ' :',
  showDenyButton: true,
  showCancelButton: true,
  confirmButtonText: `Carte d'identité`,
  denyButtonText: `Ajouter une truffe`,
}).then((result) => {
  if (result.isConfirmed) {
      Swal.fire({
        title: 'Carte d identité du chêne',
        html: `<b>Identifiant : <b> `+ arg.id + `
                          <hr> <b>Date de plantation : <b>` + arg.date_p + `
                          <hr> <b>Type : <b> `+ arg.type + `
                          <hr> <b>Dernier Réensemencement : <b>
                          <hr> <b>Dernière truffe : <b> ` + arg.der_truf + `
                          <hr> <b>Poids total trouvé : <b>` + arg.tot_poids + ` g` + `
                          <hr> <b>Commentaires : <b>` + arg.comments ,
        showCancelButton: true
      })
  } else if (result.isDenied) {

        Swal.fire({
          title: 'Détails de la truffe trouvée :',
          html: `<b>Identifiant : <b> `+ arg.id + `<hr>` +
            '<label for="inputDate">Date :</label>' +
            '<input type="date" id="inputDate" class="swal2-input"> <hr>' +
            '<label for="inputNum">Poids (en g):</label>' +
            '<input type="number" id="inputNum" class="swal2-input"> <hr>' +
            '<label for="inputComm">Commentaire :</label>' +
            '<input type="text" id="inputComm" class="swal2-input"> <hr>',
          focusConfirm: false,
          preConfirm: () => {
            var inputDateValue = document.getElementById('inputDate').value;
            var inputNumValue = document.getElementById('inputNum').value;
            var inputCommValue = document.getElementById('inputComm').value;

           return { date: inputDateValue, num: inputNumValue , comm: inputCommValue};
          }
        }).then((result) => {
          if (result.isConfirmed) {
            const { date, num, comm } = result.value;
            Shiny.setInputValue('new_truffe', [ arg.id, date, num, comm]);
            /*const { date, num, comm } = result.value;*/
            // Faites quelque chose avec les valeurs des inputs
            console.log("Date sélectionnée :", date);
            console.log("Poids saisi :", num);
            console.log("Commentaire saisi :", comm);
          }
        })

  }
})

  })
});

