#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinyMobile
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    f7Page(
      # title = "My app",
      f7TabLayout(
        navbar = f7Navbar(
          title = "Les ch\u00eanes truffiers",
          hairline = TRUE,
          shadow = TRUE
        ),
        f7Tabs(
          animated = TRUE,
          f7Tab(
            tabName = "Carte",
            icon = f7Icon("map"),
            active = TRUE,
            f7Shadow(
              intensity = 10,
              hover = TRUE,
              f7Card(
                title = NULL,
                mod_carto_leaflet_ui("carto_leaflet_1")
              )
            )
          ),
          f7Tab(
            tabName = "Graphe",
            icon = f7Icon("graph_square"),
            active = FALSE,
            f7Shadow(
              intensity = 10,
              hover = TRUE,
              f7Card(
                title = NULL,
                mod_dataviz_ui("dataviz_1")
              )
            )
          )
        )
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "truffles"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
