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
  confirmButtonText: `Carte d'identité`,
  denyButtonText: `Ajouter une truffe`,
  showCancelButton: true
}).then((result) => {

  if (result.isConfirmed) {

      var filledtemplateidentitycard = fillTemplate(templateidentitycard, arg);

      Swal.fire({
        title: 'Carte d identité du chêne',
        html: filledtemplateidentitycard,
        showCancelButton: false,
        confirmButtonText: `Fermer`
      }).then((result) => {
          Shiny.setInputValue("chene_click", null, {priority: "event"});
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
            var inputEstimValue = document.getElementById('inputEstim').checked;
            var inputCommValue = document.getElementById('inputComm').value;

           return { date: inputDateValue, num: inputNumValue ,estim: inputEstimValue, comm: inputCommValue};
          }
        }).then((result) => {
          if (result.isConfirmed) {

            const { date, num, estim, comm } = result.value;

              // Vérifier si des champs sont vides
              if (date === "") {

                // Afficher un message d'erreur à l'utilisateur TODO
                Swal.fire({
                  icon: 'error',
                  title: 'Informations incomplètes',
                  text: 'Veuillez remplir au moins la date.',
                });
              } else {
                // Toutes les informations sont valides
                Shiny.setInputValue('new_truffe', [arg.id, date, num, estim, comm]);
                Shiny.setInputValue("chene_click", null, {priority: "event"});
              }

          }
        })

  } else if (result.isDismissed) {
    console.log("Dismissed chene_click");
    Shiny.setInputValue("chene_click", null, {priority: "event"});
  }
})

  });


  Shiny.addCustomMessageHandler('modal_info_missing', function(arg) {

    Swal.fire({
      title: 'Compléter les infos de la dernière truffe:',
      html:
        '<label for="date">Date :</label>' + 
        '<input type="date" id="date" class="swal2-input" placeholder="Date" value="' + (arg.date_t ? arg.date_t : '') + '"><hr>' +
        '<div style="display: inline-block">' +
          '<label for="weight">weight (en g):</label>' +
          '<input type="number" id="weight" class="swal2-input" placeholder="weight (kg)" value="' + (arg.weight ? arg.weight : '') + '">' +
        '</div>' +
        '<div style="display: inline-block;"> ' +
          '<div style="text-align: center;"> ' +
            '<label for="estim">Estimation</label><br> ' +
              '<div class="toggle-switch"> ' +
                '<input type="checkbox" id="estim" class="swal2-input" placeholder="Estimation"' + (arg.estim ? arg.estim : '') + '">' +
                '<label for="estim"></label> ' +
              '</div>' +
          '</div>' +
        '</div><hr>' +
        '<label for="comment">Commentaire :</label>' +
        '<input type="text" id="comment" class="swal2-input" placeholder="Commentaire"value="' + (arg.comments ? arg.comments : '') + '">' ,
      focusConfirm: false,
      preConfirm: () => {
        return {
          date: document.getElementById('date').value,
          weight: document.getElementById('weight').value,
          estim: document.getElementById('estim').checked,
          comment: document.getElementById('comment').value
        }
      }
    }).then((result) => {
      if (result.isConfirmed) {

        const { date, weight, estim, comment } = result.value;


              // Vérifier si des champs sont vides
              if (date === "") {

                // Afficher un message d'erreur à l'utilisateur TODO
                Swal.fire({
                  icon: 'error',
                  title: 'Informations incomplètes',
                  text: 'Veuillez remplir au moins la date.',
                });
              } else {
                // Toutes les informations sont valides
                Shiny.setInputValue('complete_truffe', [arg.id, arg.idtruffle, date, weight, estim, comment]);
              }
       
      } else if (result.isDismissed) {
        console.log("Dismissed chene_click");
        Shiny.setInputValue("chene_click", null, {priority: "event"});
      }
    });
 })
});

