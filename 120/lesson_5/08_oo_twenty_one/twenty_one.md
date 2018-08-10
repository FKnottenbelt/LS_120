# Assignment: OO Twenty-One

## Short overview:
Twenty-One is a card game consisting of a dealer and a player, where
the participants try to get as close to 21 as possible without going
over.

- Both participants are initially dealt 2 cards from a 52-card deck.
- The player takes the first turn, and can "hit" or "stay".
- If the player busts, he loses. If he stays, it's the dealer's turn.
- The dealer must hit until his cards add up to at least 17.
- If he busts, the player wins. If both player and dealer stays, then
  the highest total wins.
- If both totals are equal, then it's a tie, and nobody wins.

- `hit` = get another card
- `stay` = end of turn
- `bust` = cards total more than 21

Review procedural Twenty-One game (skip implementation steps)

### Rules of Twenty-One

- You start with a normal 52-card deck consisting of the 4 suits
  (hearts, diamonds, clubs, and spades), and 13 values (2, 3, 4, 5,
  6, 7, 8, 9, 10, jack, queen, king, ace).

- The goal of Twenty-One is to try to get as close to 21 as possible,
  without going over. If you go over 21, it's a "bust" and you lose.

- Setup: the game consists of a "dealer" and a "player". Both
  participants are initially dealt 2 cards. The player can see their
  2 cards, but can only see one of the dealer's cards.

- Card values: all of the card values are pretty straightforward,
  except for the ace. The numbers 2 through 10 are worth their face
  value. The jack, queen, and king are each worth 10, and the ace can
  be worth 1 or 11. The ace's value is determined each time a new card
  is drawn from the deck. For example, if the hand contains a 2, an
  ace, and a 5, then the total value of the hand is 18. In this case,
  the ace is worth 11 because the sum of the hand (2 + 11 + 5) doesn't
  exceed 21. Now, say another card is drawn and it happens to be an
  ace. Your program will have to determine the value of both aces.
  If the sum of the hand (2 + 11 + 5 + 11) exceeds 21 then one of the
  aces must be worth 1, resulting in the hand's total value being 19.
  What happens if another card is drawn and it also happens to be an
  ace? It can get tricky if there are multiple aces in a hand, so your
  program must account for that.
    Card |	Value
       --|--
    2 - 10 	| face value
    jack, queen, king |	10
    ace |	1 or 11

- Player turn: the player goes first, and can decide to either `"hit"`
  or `"stay"`. A hit means the player will ask for another card.
  Remember that if the total exceeds 21, then the player `"busts"` and
  loses. The decision to hit or stay will depend on what the player's
  cards are and what the player thinks the dealer has. For example,
  if the dealer is showing a "10" (the other card is hidden), and the
  player has a "2" and a "4", then the obvious choice is for the
  player to "hit". The player can continue to hit as many times as
  they want. The turn is over when the player either busts or stays.
  If the player busts, the game is over and the dealer won.

- Dealer turn: when the player stays, it's the dealer's turn. The
  dealer must follow a strict rule for determining whether to hit or
  stay: hit until the total is at least 17. If the dealer busts, then
  the player wins.

- Comparing cards: when both the player and the dealer stay, it's
  time to compare the total value of the cards and see who has the
  highest value.

