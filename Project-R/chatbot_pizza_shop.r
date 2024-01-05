pizza_shop <- function(){
  print("Hello!~ my dear customer, welcome to my pizza shop")
  print("------------ Menu ------------")
  id <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
  menu <- c("Cheese Pizza", "Pepperoni Pizza", "Hawaiian Pizza", "Veggie Pizza", "Seafood Pizza", "Spaghetti Carbonara", 
            "BBQ Chicken Wings 10 pcs.", "Coca-Cola 1.25 Ltr.", "Sprite 1.25 Ltr.", "Chocolate Ice Cream 1 scoop")
  price <- c(279, 279, 349, 349, 399, 139, 219, 45, 45, 35)

  df <- data.frame(id, menu, price)
  print(df)

  print("------------------------------")

  print("What would you like to order?")

  menu_choose <- c()
  quantity <- c()
  sum_price <- c()
  ans = "y"
  
  while(ans != "n"){
    print("Enter menu id: ")
    menu_id <- as.numeric(readLines("stdin",n=1))
    
    while( (menu_id < 1) | (menu_id > length(df$id)) ){
      print("Invalid choice! Please try again.")
      print("Enter menu id: ")
      menu_id <- as.numeric(readLines("stdin",n=1))
    }

    menu_choose <- append(menu_choose, df$menu[menu_id])

    print("How many do you get?: ")
    quan <- as.numeric(readLines("stdin",n=1))

    while( is.na(quan) ){
      print("It's not numeric! Please try again.")
      print("How many do you get?: ")
      quan <- as.numeric(readLines("stdin",n=1))
    }

    quantity <- append(quantity, quan)
    sum <- df$price[menu_id] * quan
    sum_price <- append(sum_price, sum)

    print("Would you like anything else? [y/n]: ")
    ans <- tolower(readLines("stdin",n=1))

    while(ans != "n" & ans != "y"){
      print("Invalid choice!")
      print("Would you like anything else? [y/n]: ")
      ans <- tolower(readLines("stdin",n=1))

    }

    if(ans == "n"){
      menu_choose
      order <- data.frame(menu_choose, quantity, sum_price)
      
      print("------------ Your Order ------------")
      print(order)
      
      print(paste("Total Price: ", sum(sum_price)))
      print("Thank you for your order")
      
    }
    
  }
  
}

pizza_shop()
