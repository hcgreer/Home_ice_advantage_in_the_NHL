shinyUI(
  dashboardPage(
    dashboardHeader(
      title = 'Home Ice Advantage in the NHL'
    ),
    dashboardSidebar(
      sidebarMenu(
        menuItem(
          'Overall Stats',
          tabName = 'overall_stats',
          icon = icon('dashboard')
        ),
        menuItem(
          'Elos',
          tabName = 'elos',
          icon = icon('th')
        )
      ),
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
      actionLink("selectall","Select All")
    ),
    dashboardBody(
      tabItems(tabItem(
        tabName = 'overall_stats',
        h2(
        fluidRow(
        box(
          title = 'Home Win Percentage',
          status = 'primary',
          solidHeader = T,
          plotOutput('wins')
        ),
        box(
          title = 'Away Win Percentage',
          status = 'primary',
          solidHeader = T,
          plotOutput('losses')
        )
      ),
      fluidRow(
        box(
          title = 'Goals',
          status = 'primary',
          solidHeader = T,
          plotOutput('goals')
        ),
        box(
          title = 'Shots',
          status = 'primary',
          solidHeader = T,
          plotOutput('shots')
        )
      )
      )),
      tabItem(
        tabName = 'elos',
        h2(
          fluidRow(
            box(
              title = 'Elo Over Time',
              status = 'primary',
              solidHeader = T,
              plotOutput('elo')
            )
          ),
          fluidRow(
            box(
              title = 'Elo Standings',
              status = 'primary',
              solidHeader = T,
              dataTableOutput('end_elo')
            ), 
            box(
              title = 'Actual Standings',
              status = 'primary',
              solidHeader = T,
              dataTableOutput('standings')
            )
          )
        )
      )
      )
    )
  )
)