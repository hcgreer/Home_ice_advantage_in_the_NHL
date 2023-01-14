shinyServer(function(input, output, session){
  
  observe({
    if(input$selectall == 0) return(NULL) 
    else if (input$selectall%%2 == 0)
    {
      updateCheckboxGroupInput(session,"team","Choose NHL team(s):",choices=teams_list)
    }
    else
    {
      updateCheckboxGroupInput(session,"team","Choose NHL team(s):",choices=teams_list,selected=teams_list)
    }
  })
  
  
  seaons_filtered <- reactive({
      if(input$season == 'All') {
        return(years %>% 
                 filter(team %in% input$team))
      }
    return(by_year %>% 
             filter(team %in% input$team, season == input$season))
      })
  
  output$wins <- renderPlot({
    seaons_filtered() %>%
      filter(home_away %in% c('home_win', 'away_win')) %>% 
      ggplot(aes(x = team, y = count/10, fill = home_away)) +
        geom_bar(stat = 'identity', position = 'dodge', width = .4)
  })
  
  output$losses <- renderPlot({
    seaons_filtered() %>%
      filter(home_away %in% c('home_loss', 'away_loss')) %>% 
      ggplot(aes(x = team, y = count/10, fill = home_away)) +
      geom_bar(stat = 'identity', position = 'dodge', width = .4)
  })
  
  output$goals <- renderPlot({
    seaons_filtered() %>%
      filter(home_away %in% c('home_goals', 'away_goals')) %>% 
      ggplot(aes(x = team, y = count/10, fill = home_away)) +
      geom_bar(stat = 'identity', position = 'dodge', width = .4)
  })
  
  output$shots <- renderPlot({
    seaons_filtered() %>%
      filter(home_away %in% c('home_shots', 'away_shots')) %>% 
      ggplot(aes(x = team, y = count/10, fill = home_away)) +
      geom_bar(stat = 'identity', position = 'dodge', width = .4)
  })
})