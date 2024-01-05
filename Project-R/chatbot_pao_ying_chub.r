play_game <- function(){
    print("Hi!~ Would do you like to play Pao Ying Chub? [y/n] : ")
    ans <- tolower(readLines("stdin",n=1))
  
    if(ans == "y"){
      choice <- c("rock", "paper", "scissors")
      round <- 1

      bot <- list(win = 0, loss = 0, tie = 0) 
      player <- list(win = 0, loss = 0, tie = 0) 

      while(ans != "n"){

        print(paste("ROUND",round))
        print("Enter rock, paper or scissors")

        bot_choose <- sample(choice, 1)
        print("Pao Ying Chub! : ")
        player_choose <- tolower(readLines("stdin",n=1))

        while(player_choose != "rock" & player_choose != "paper" & player_choose != "scissors"){
          print("Invalid choice!")
          print("Enter rock, paper or scissors")
          print("Pao Ying Chub! : ")
          player_choose <- tolower(readLines("stdin",n=1))
        }

        if(player_choose == bot_choose){
          print(paste("BOT:", bot_choose))
          print(paste("PLAYER:", player_choose))
          print("It's a tie")
          
          bot$tie <- bot$tie + 1
          player$tie <- player$tie + 1


        } else {
          if(player_choose == "rock"){
            if(bot_choose == "paper"){
              print(paste("BOT:", bot_choose))
              print(paste("PLAYER:", player_choose))
              print("Bot Win!")

              bot$win <- bot$win + 1

            } else {
              print(paste("BOT:", bot_choose))
              print(paste("PLAYER:", player_choose))
              print("Player Win!")

              player$win <- player$win + 1
            }

          }

          if(player_choose == "paper"){
            if(bot_choose == "scissors"){
              print(paste("BOT:", bot_choose))
              print(paste("PLAYER:", player_choose))
              print("Bot Win!")


              bot$win <- bot$win + 1

            } else {
              print(paste("BOT:", bot_choose))
              print(paste("PLAYER:", player_choose))
              print("Player Win!")

              player$win <- player$win + 1
            }

          }
          
          if(player_choose == "scissors"){
            if(bot_choose == "rock"){
              print(paste("BOT:", bot_choose))
              print(paste("PLAYER:", player_choose))
              print("Bot Win!")
              
              bot$win <- bot$win + 1

            } else {
              print(paste("BOT:", bot_choose))
              print(paste("PLAYER:", player_choose))
              print("Player Win!")
              
              player$win <- player$win + 1
            }

          }

        }

        round <- round + 1

        if(round > 1){
          print("Do you want to play agian? [y/n] : ")
          ans <- tolower(readLines("stdin",n=1))

          while(ans != "n" & ans != "y"){
            print("Invalid choice!")
            print("Do you want to play agian? [y/n] : ")
            ans <- tolower(readLines("stdin",n=1))
            
          }
          print("--------------------")
          
          if(ans == "n"){
            print( paste( "Total round: ",(round-1) ))
            print("----- Player score -----")
            print( paste( "Win: ",player$win ))
            print( paste( "Loss: ",player$loss ))
            print( paste( "Tie: ",player$tie ))
            
            print("----- Bot score -----")
            print( paste( "Win: ",bot$win ))
            print( paste( "Loss: ",bot$loss ))
            print( paste( "Tie: ",bot$tie ))
            print("Goodbye! Have a nice day!")
          }
        }
      }



    } else {
      print("Goodbye! Have a nice day!")
    }
}

play_game()
