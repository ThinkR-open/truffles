$( document ).ready(function() {
  Shiny.addCustomMessageHandler('modal', function(arg) {

Swal.fire({
  title: 'Que souhaites-tu faire avec ' + arg.id + ' ?',
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
                          <hr> <b>Date de dernier Réensemencement : <b>
                          <hr> <b>Dernière truffe : <b> ` + arg.der_truf + `
                          <hr> <b>Poids total trouvé : <b>` + arg.tot_poids ,
        showCancelButton: true
      })
  } else if (result.isDenied) {

        Swal.fire({
          title: 'Détails de la truffe trouvée :',
          html: `<b>Identifiant : <b> `+ arg.id + `<hr>` +
            '<label for="inputDate">Date :</label>' +
            '<input type="date" id="inputDate" class="swal2-input"> <hr>' +
            '<label for="inputNum">Poids :</label>' +
            '<input type="number" id="inputNum" class="swal2-input"> <hr>' +
            '<label for="inputComm">Commentaire :</label>' +
            '<input type="text" id="inputComm" class="swal2-input"> <hr>',
          focusConfirm: false,
          preConfirm: () => {
            const inputDateValue = document.getElementById('inputDate').value;
            const inputNumValue = document.getElementById('inputNum').value;
            const inputCommValue = document.getElementById('inputComm').value;

            return { date: inputDateValue, num: inputNumValue , comm: inputCommValue};
          }
        }).then((result) => {
          if (result.isConfirmed) {
            Shiny.setInputValue('new_truffe', [date, text, comm])
            const { date, num, comm } = result.value;
            // Faites quelque chose avec les valeurs des inputs
            console.log("Date sélectionnée :", date);
            console.log("Poids saisi :", text);
            console.log("Commentaire saisi :", comm);
          }
        })

  }
})

  })
});
