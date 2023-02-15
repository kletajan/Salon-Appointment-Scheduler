#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"

MAIN_MENU() {
echo -e "\nWelcome to My Salon, how can I help you?"
ALL_SERVICE=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")
echo "$ALL_SERVICE" | while read SERVICE_ID BAR NAME
    do
      echo "$SERVICE_ID) $NAME"
    done

#echo -e "\n1) cut\n2) color\n3) perm\n4) style\n5) trim"
read SERVICE_ID_SELECTED

case $SERVICE_ID_SELECTED in
  1) ;;
  2) ;;
  3) ;;
  4) ;;
  5) ;;
  *)  MAIN_MENU "Please enter a valid option."
esac

  #}


#SERVICE() {
SELECTED_SERVICE=$($PSQL "SELECT name FROM services WHERE service_id='$SERVICE_ID_SELECTED'")

echo -e "\nWhat's your phone number?"
read CUSTOMER_PHONE

CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
# if customer doesn't exist
if [[ -z $CUSTOMER_NAME ]]
then
  # get new customer name
  echo -e "\nWhat's your name?"
  read CUSTOMER_NAME
  # insert new customer
  INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')") 
fi

CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE name='$CUSTOMER_NAME' AND phone='$CUSTOMER_PHONE'") 

echo -e "\nWhat time would you like your '$SELECTED_SERVICE', '$CUSTOMER_NAME'?"
read SERVICE_TIME

# insert new appointment
ADD_NEW_APO=$($PSQL "INSERT INTO appointment(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SELECTED_SERVICE, '$SERVICE_TIME')")

echo -e "\nI have put you down for a $SELECTED_SERVICE at '$SERVICE_TIME', $CUSTOMER_NAME."

}
MAIN_MENU
#SERVICE




