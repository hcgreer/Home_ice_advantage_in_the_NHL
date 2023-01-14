shinyUI(
  dashboardPage(
    dashboardHeader(
      title = 'Home Ice Advantage in the NHL'
    ),
    dashboardSidebar(
      collapsibleradioButtonsInput(
        "season",
        "Select a NHL season",
        i = 3,
        choices = c('All', seasons_list),
        selected = 'All'
      ),
      collapsibleCheckboxGroupInput(
        "team",
        "Select a NHL team(s)",
        i = 3,
        teams_list,
        selected = 'Predators'
        ),
      actionLink("selectall","Select All"),
      radioButtons(
        "stat",
        "Select a NHL stat",
        choices = c('Wins', 'Losses', 'Goals', 'Shots')
      )
    ),
    dashboardBody(
      box(fluidRow(
        plotOutput('wins'))
      ),
      box(fluidRow(
        plotOutput('losses'))
      ),
      box(fluidRow(
        plotOutput('goals'))
      ),
      box(fluidRow(
        plotOutput('shots'))
      ),
    )
  )
)