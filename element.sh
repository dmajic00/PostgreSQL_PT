PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

case "$1" in
    [0-9]*)
    N=$($PSQL "select atomic_number from elements where atomic_number='"$1"' ")
        ATOMIC_NUMBER=$N
        ELEMENT_NAME=$($PSQL "SELECT name FROM elements where atomic_number='$N' ")
        if [[ -z $ELEMENT_NAME ]]
        then 
        echo "I could not find that element in the database."
        else
        ELEMENT_SYMBOL=$($PSQL "select symbol from elements where atomic_number='$N'")
        WEIGHT=$($PSQL "select atomic_mass from properties where atomic_number='$N'")
        MELTING_POINT=$($PSQL "select melting_point_celsius from properties where atomic_number='$N'")
        BOILING_POINT=$($PSQL "select boiling_point_celsius from properties where atomic_number='$N'")
        TYPE=$($PSQL "select types.type from types inner join properties using(type_id) where atomic_number='$N'")
        echo "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $TYPE, with a mass of $WEIGHT amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius." | sed 's/ \+/ /g'  | sed 's/(\s*\([^)]*\))/(\1)/'
        fi
    ;;
    [A-Za-z]*)
    N=$($PSQL "select name from elements where name='"$1"' ")
        ELEMENT_NAME=$N
        ATOMIC_NUMBER=$($PSQL "select atomic_number from elements where name='$1'")
          if [[ -z $N ]]
          then 
          S=$($PSQL "select symbol from elements where symbol = '"$1"'")
          ELEMENT_SYMBOL=$S
          ATOMIC_NUMBER=$($PSQL "select atomic_number from elements where symbol='$1'")
            if [[ -z $S ]]
            then 
            echo "I could not find that element in the database."
            else
            ELEMENT_NAME=$($PSQL "select name from elements where symbol='$1'")
            WEIGHT=$($PSQL "select atomic_mass from properties where atomic_number='$ATOMIC_NUMBER'")
        MELTING_POINT=$($PSQL "select melting_point_celsius from properties where atomic_number='$ATOMIC_NUMBER'")
        BOILING_POINT=$($PSQL "select boiling_point_celsius from properties where atomic_number='$ATOMIC_NUMBER'")
        TYPE=$($PSQL "select types.type from types inner join properties using(type_id) where atomic_number='$ATOMIC_NUMBER'")
        echo "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $TYPE, with a mass of $WEIGHT amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius." | sed 's/ \+/ /g'  | sed 's/(\s*\([^)]*\))/(\1)/'
        fi
        else
        ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements where name='$1' ")
        WEIGHT=$($PSQL "select atomic_mass from properties where atomic_number='$ATOMIC_NUMBER'")
        MELTING_POINT=$($PSQL "select melting_point_celsius from properties where atomic_number='$ATOMIC_NUMBER'")
        BOILING_POINT=$($PSQL "select boiling_point_celsius from properties where atomic_number='$ATOMIC_NUMBER'")
        TYPE=$($PSQL "select types.type from types inner join properties using(type_id) where atomic_number='$ATOMIC_NUMBER'")
        echo "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $TYPE, with a mass of $WEIGHT amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius." | sed 's/ \+/ /g'  | sed 's/(\s*\([^)]*\))/(\1)/'
        fi
    ;;
    "")
    echo "Please provide an element as an argument."
    ;;
esac