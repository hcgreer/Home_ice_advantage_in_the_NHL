library(shiny)
library(tidyverse)
library(shinydashboard)
library(shinyWidgets)

by_year <- readRDS(file = 'data/by_year.rds')

years <- readRDS(file = 'data/years.rds')

elos <- readRDS(file = 'data/elos.rds')

yearly_elo <- readRDS('data/updated_elos_longer.rds')

end_elos<- readRDS(file = 'data/end_elos.rds')

standings <- readRDS(file = 'data/standings.rds')

teams_list <- c(by_year %>% pull(team) %>% unique() %>% sort())
seasons_list <- c(by_year %>% pull(season) %>% unique() %>% sort())


collapsibleCheckboxGroupInput <- 
  function(inputId, label, i, choices = NULL, selected = NULL, width = NULL, 
           choiceNames = NULL, choiceValues = NULL){
    input <- checkboxGroupInput(inputId, label, choices = choices, 
                                selected = selected, width = width,
                                choiceNames = choiceNames, 
                                choiceValues = choiceValues)
    checkboxes <- input[[3]][[2]][[3]][[1]]
    id_btn <- paste0(inputId, "_btn")
    id_div <- paste0(inputId, "_collapsible")
    btn <- actionButton(id_btn, "More...", 
                        icon = icon("collapse-up", lib = "glyphicon"), 
                        class = "btn-primary btn-sm", 
                        `data-toggle`="collapse", 
                        `data-target` = paste0("#", id_div))
    collapsible <- div(id = id_div, class = "collapse")
    collapsible$children <- checkboxes[(i+1):length(checkboxes)]
    children <- c(checkboxes[1:i], list(btn), list(collapsible))
    input[[3]][[2]][[3]][[1]] <- children
    script <- sprintf('$(document).ready(function(){
      $("#%s_collapsible").on("hide.bs.collapse", function(){
        $("#%s_btn").html("<span class=\\\"glyphicon glyphicon-collapse-down\\\"></span> More...");
      });
      $("#%s_collapsible").on("show.bs.collapse", function(){
        $("#%s_btn").html("<span class=\\\"glyphicon glyphicon-collapse-up\\\"></span> Less...");
      });
    });', inputId, inputId, inputId, inputId)
    tagList(input, tags$script(HTML(script)))
  }

collapsibleradioButtonsInput <- 
  function(inputId, label, i, choices = NULL, selected = NULL, width = NULL, 
           choiceNames = NULL, choiceValues = NULL){
    input <- radioButtons(inputId, label, choices = choices, 
                                selected = selected, width = width,
                                choiceNames = choiceNames, 
                                choiceValues = choiceValues)
    checkboxes <- input[[3]][[2]][[3]][[1]]
    id_btn <- paste0(inputId, "_btn")
    id_div <- paste0(inputId, "_collapsible")
    btn <- actionButton(id_btn, "More...", 
                        icon = icon("collapse-up", lib = "glyphicon"), 
                        class = "btn-primary btn-sm", 
                        `data-toggle`="collapse", 
                        `data-target` = paste0("#", id_div))
    collapsible <- div(id = id_div, class = "collapse")
    collapsible$children <- checkboxes[(i+1):length(checkboxes)]
    children <- c(checkboxes[1:i], list(btn), list(collapsible))
    input[[3]][[2]][[3]][[1]] <- children
    script <- sprintf('$(document).ready(function(){
      $("#%s_collapsible").on("hide.bs.collapse", function(){
        $("#%s_btn").html("<span class=\\\"glyphicon glyphicon-collapse-down\\\"></span> More...");
      });
      $("#%s_collapsible").on("show.bs.collapse", function(){
        $("#%s_btn").html("<span class=\\\"glyphicon glyphicon-collapse-up\\\"></span> Less...");
      });
    });', inputId, inputId, inputId, inputId)
    tagList(input, tags$script(HTML(script)))
  }