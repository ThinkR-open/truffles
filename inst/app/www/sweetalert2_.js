$( document ).ready(function() {

  Shiny.addCustomMessageHandler('modal', function(arg) {

     function fillTemplate(template, args) {
      var filledTemplate = template;
      for (var prop in args) {
        if (args.hasOwnProperty(prop)) {
          filledTemplate = filledTemplate.replace(new RegExp('{{' + prop + '}}', 'g'), args[prop]);
        }
      }
      return filledTemplate;
    };

  var templateidentitycard;

  // Charger le modèle HTML pour la carte d'identité du chêne
  $.get('www/template_identity_card.html', function(data) {
    templateidentitycard = data;
  });


  var templatefindtruffle;

  // Charger le modèle HTML pour la carte d'identité du chêne
  $.get('www/template_find_truffle.html', function(data) {
    templatefindtruffle = data;
  });






Swal.fire({
  title: 'Chêne  ' + arg.id + ' :',
  showDenyButton: true,
  showCancelButton: true,
  confirmButtonText: `Carte d'identité`,
  denyButtonText: `Ajouter une truffe`,
}).then((result) => {

  if (result.isConfirmed) {

      var filledtemplateidentitycard = fillTemplate(templateidentitycard, arg);

      Swal.fire({
        title: 'Carte d identité du chêne',
        html: filledtemplateidentitycard,
        showCancelButton: true
      })

  } else if (result.isDenied) {

      var filledtemplatefindtruffle = fillTemplate(templatefindtruffle, arg);

        Swal.fire({
          title: 'Détails de la truffe trouvée :',
          html: filledtemplatefindtruffle,
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

              // Vérifier si des champs sont vides
              if (date === "" || num === "" || comm === "") {

                // Afficher un message d'erreur à l'utilisateur TODO
                Swal.fire({
                  icon: 'error',
                  title: 'Informations incomplètes',
                  text: 'Veuillez remplir tous les champs.',
                });
              } else {
                // Toutes les informations sont valides
                Shiny.setInputValue('new_truffe', [arg.id, date, num, comm]);
              }

          }
        })

  } else if (result.isCancelled) {
    // TODO
     /* Shiny.setInputValue("chene_click", null);*/
  }
})

  })
});

