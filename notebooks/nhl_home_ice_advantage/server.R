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
  
  elos_filtered <- reactive({
    if(input$season == 'All') {
      return(yearly_elo %>% 
               filter(team %in% input$team))
    }
    return(elos %>% 
             filter(team %in% input$team, season == input$season))
  })
  
  output$wins <- renderPlot({
    seaons_filtered() %>%
      filter(home_away %in% c('home_win', 'home_loss')) %>% 
      ggplot(aes(x = team, y = count, fill = home_away)) +
        geom_bar(stat = 'identity', position = 'fill', width = .4) +
        scale_fill_manual(
          values = c('steelblue1', 'steelblue3'), 
          labels = c('Loss', 'Win'), 
          guide = guide_legend(reverse=TRUE)
          ) +
        xlab('Team(s)') +
        ylab('Home Win Percentage') +
        geom_hline(yintercept = .5)
  })
  
  output$losses <- renderPlot({
    seaons_filtered() %>%
      filter(home_away %in% c('away_win', 'away_loss')) %>% 
      ggplot(aes(x = team, y = count, fill = home_away)) +
      geom_bar(stat = 'identity', position = 'fill', width = .4) +
      scale_fill_manual(
        values = c('steelblue1', 'steelblue3'), 
        labels = c('Loss', 'Win'), 
        guide = guide_legend(reverse=TRUE)
      ) +
      xlab('Team(s)') +
      ylab('Away Win Percentage') +
      geom_hline(yintercept = .5)
  })
  output$goals <- renderPlot({
    seaons_filtered() %>%
      filter(home_away %in% c('home_goals', 'away_goals')) %>% 
      ggplot(aes(x = team, y = count, fill = home_away)) +
      geom_bar(stat = 'identity', position = 'dodge', width = .4) + 
      scale_fill_manual(
        values = c('steelblue1', 'steelblue3'), 
        labels = c('Away', 'Home'), 
        guide = guide_legend(reverse=TRUE)
      ) +
      xlab('Team(s)') +
      ylab('Number of Goals')
  })
  
  output$shots <- renderPlot({
    seaons_filtered() %>%
      filter(home_away %in% c('home_shots', 'away_shots')) %>% 
      ggplot(aes(x = team, y = count, fill = home_away)) +
      geom_bar(stat = 'identity', position = 'dodge', width = .4) + 
      scale_fill_manual(
        values = c('steelblue1', 'steelblue3'), 
        labels = c('Away', 'Home'), 
        guide = guide_legend(reverse=TRUE)
      ) +
      xlab('Team(s)') +
      ylab('Number of Shots')
  })
  
  output$elo <- renderPlot({
    if (input$season == 'All'){
      return( elos_filtered() %>% 
        ggplot(aes(x = season, y = elos, group = team)) + 
          geom_line(aes(color = team)) + 
          theme(axis.text.x = element_blank()))
    }
    return(elos_filtered() %>% 
      ggplot(aes(x = date, y = elo, group = team)) +
        geom_line(aes(color = team)))
  })
  
  output$end_elo <- renderDataTable({
    if (input$season == 'All'){
      return(end_elos %>% 
               arrange(desc(elos)))
    }
    return(end_elos %>% 
             filter(season == input$season) %>% 
             select(team, elos) %>% 
             arrange(desc(elos)))
  })
  
  output$standings <- renderDataTable({
    if (input$season == 'All'){
      return(standings %>% 
               arrange(desc(points)))
    }
    return(standings %>% 
             filter(season == input$season) %>% 
             select(team, points) %>% 
             arrange(desc(points)))
  })
  })