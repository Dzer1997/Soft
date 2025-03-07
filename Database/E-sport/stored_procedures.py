# stored_procedures.py

from db_connector  import get_db_connection

def join_tournament(tournament_id, player_id):
    try:
        # database connection
        connection = get_db_connection()

        if connection and connection.is_connected():
            cursor = connection.cursor()

            # Call the stored procedure 
            cursor.callproc('joinTournament', [tournament_id, player_id])

            # Commit data from stored procedure
            connection.commit()
            print(f"Player {player_id} joined tournament {tournament_id}")
    except Exception as e:
        raise Exception(f"Error while joining tournament: {e}")
    finally:
        if connection and connection.is_connected():
            cursor.close()
            connection.close()

def submit_match_result(tournament_id, player1_id, player2_id, winner_id, match_date):
    try:
        # database connection
        connection = get_db_connection()

        if connection and connection.is_connected():
            cursor = connection.cursor()

            # Call the stored procedure
            cursor.callproc('submitMatchResult', [tournament_id, player1_id, player2_id, winner_id, match_date])

            # Commit data from stored procedure
            connection.commit()
            print(f"Match result for tournament {tournament_id} submitted successfully!")
    except Exception as e:
        raise Exception(f"Error while submitting match result: {e}")
    finally:
        if connection and connection.is_connected():
            cursor.close()
            connection.close()
