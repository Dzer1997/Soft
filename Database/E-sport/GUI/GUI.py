import tkinter as tk
from tkinter import messagebox
from db_connector  import get_db_connection
from stored_procedures import joinTournament, submit_match_result 


# Function tournament registration
def on_join_tournament():
    tournament_id = entry_tournament_id.get()
    player_id = entry_player_id.get()
    
    if not tournament_id or not player_id:
        messagebox.showwarning("Please enter both Tournament ID and Player ID.")
        return
    
    try:
        # Call function from file stored_procedures.py
        joinTournament(int(tournament_id), int(player_id))
        messagebox.showinfo("Success", f"Player {player_id} registered for Tournament {tournament_id}.")
    except Exception as e:
        messagebox.showerror("Error", f"An error occurred: {e}")

# Function match result submission
def on_submit_match_result():
    tournament_id = entry_tournament_id_result.get()
    player1_id = entry_player1_id.get()
    player2_id = entry_player2_id.get()
    winner_id = entry_winner_id.get()
    match_date = entry_match_date.get()

    if not tournament_id or not player1_id or not player2_id or not winner_id or not match_date:
        messagebox.showwarning("Please enter all fields (Tournament ID, Player 1 ID, Player 2 ID, Winner ID, Match Date).")
        return

    try:
        # Call function from stored_procedures.py
        submit_match_result(int(tournament_id), int(player1_id), int(player2_id), int(winner_id), match_date)
        messagebox.showinfo("Success", "Match result submitted successfully!")
    except Exception as e:
        messagebox.showerror("Error", f"An error occurred: {e}")

def clear_inputs():
    # Clear all input fields
    entry_tournament_id.delete(0, tk.END)
    entry_player_id.delete(0, tk.END)
    entry_tournament_id_result.delete(0, tk.END)
    entry_player1_id.delete(0, tk.END)
    entry_player2_id.delete(0, tk.END)
    entry_winner_id.delete(0, tk.END)
    entry_match_date.delete(0, tk.END)

# Set up the Tkinter window
root = tk.Tk()
root.title("Tournament & Match Result")

# Tournament ID
label_tournament_id = tk.Label(root, text="Tournament ID:")
label_tournament_id.pack(padx=10, pady=5)
entry_tournament_id = tk.Entry(root)
entry_tournament_id.pack(padx=10, pady=5)

# Player ID
label_player_id = tk.Label(root, text="Player ID:")
label_player_id.pack(padx=10, pady=5)
entry_player_id = tk.Entry(root)
entry_player_id.pack(padx=10, pady=5)

# Join Tournament Button
button_join_tournament = tk.Button(root, text="Join Tournament", command=on_join_tournament)
button_join_tournament.pack(padx=10, pady=10)

# Match Result Submission Section 

# Tournament ID
label_tournament_id_result = tk.Label(root, text="Tournament ID:")
label_tournament_id_result.pack(padx=10, pady=5)
entry_tournament_id_result = tk.Entry(root)
entry_tournament_id_result.pack(padx=10, pady=5)

# Player 1 ID
label_player1_id = tk.Label(root, text="Player 1 ID:")
label_player1_id.pack(padx=10, pady=5)
entry_player1_id = tk.Entry(root)
entry_player1_id.pack(padx=10, pady=5)

# Player 2 ID
label_player2_id = tk.Label(root, text="Player 2 ID:")
label_player2_id.pack(padx=10, pady=5)
entry_player2_id = tk.Entry(root)
entry_player2_id.pack(padx=10, pady=5)

# Winner ID
label_winner_id = tk.Label(root, text="Winner ID:")
label_winner_id.pack(padx=10, pady=5)
entry_winner_id = tk.Entry(root)
entry_winner_id.pack(padx=10, pady=5)

# Match Date (format: YYYY-MM-DD HH:MM:SS)
label_match_date = tk.Label(root, text="Match Date (YYYY-MM-DD HH:MM:SS):")
label_match_date.pack(padx=10, pady=5)
entry_match_date = tk.Entry(root)
entry_match_date.pack(padx=10, pady=5)

# Submit Match Result Button
button_submit_match_result = tk.Button(root, text="Submit Match Result", command=on_submit_match_result)
button_submit_match_result.pack(padx=10, pady=10)

# Clear Button 
button_clear = tk.Button(root, text="Clear", command=clear_inputs)
button_clear.pack(padx=10, pady=5)


root.mainloop()
