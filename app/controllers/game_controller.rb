class GameController < ApplicationController

  def play
      @current_deck = Deck.find(params[:deck_id])
      @deck_time = @current_deck.time
      @past_card_time = params[:time_id]

    if (@past_card_time.to_i == @deck_time)
      @text = 'deck_time'

      if (@current_card = @current_deck.cards.first).nil?
        respond_to do |format|
          format.html { redirect_to decks_path, notice: 'Deck does not have any cards'}
          format.json { head :no_content }
        end
      end

    else
      @text = 'card_time'

      #get the next card based on the next biggest card time.
      if (@current_card = @current_deck.cards.where(:time.gt => @past_card_time).first).nil?
        #if there are no more cards redirect to decks indexs and display message
        respond_to do |format|
          format.html { redirect_to decks_path, notice: 'You have completed the deck'}
          format.json { head :no_content }
        end
      end

    end
  end

  def check_answer
    @current_deck = Deck.find(params[:deck_id])
    @current_card = @current_deck.cards.find_by(time: params[:time_id])

  # if answer submitted answer is correct
    if @current_card.answer == params[:answer][:answer]
      respond_to do |format|
        format.html { redirect_to "/decks/#{params[:deck_id]}/play/#{params[:time_id]}" }
        format.json { head :no_content }
      end

  # if answer submitted answer is wrong 
    else
      respond_to do |format|
        format.html { redirect_to "/decks/#{params[:deck_id]}/play/#{params[:time_id_old]}", notice: "Wrong" }
        format.json { head :no_content }
      end
    end
  end

end
