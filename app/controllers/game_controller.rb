class GameController < ApplicationController

  # @current_deck
  # @current_card_index
  # @current_card
  def play
      @current_deck = Deck.find(params[:deck_id])
      @current_card_index = params[:card_id].to_i

      # if there are no card in the deck then redirect to page deck#index
      if (@current_card = @current_deck.cards[@current_card_index]).nil?
        respond_to do |format|
          format.html { redirect_to user_root_path, notice: 'Deck does not have any cards'}
          format.json { head :no_content }
        end
      end

  end

  
  # @current_deck
  # @current_card_index
  # @current_card
  # next_card_index
  def check_answer
    @current_deck = Deck.find(params[:deck_id])
    @current_card_index = params[:card_id].to_i
    @current_card = @current_deck.cards[@current_card_index]
    
    @answer = @current_card.answer
    @answer_submitted = params[:reply][:answer]

    respond_to do |format|
     # if answer submitted answer is correct

     if @current_deck.setting_whitespace
        @answer = @answer.gsub(/\s+/,"") 
        @answer_submitted = @answer_submitted.gsub(/\s+/,"")
     end

     if @current_deck.setting_case_sensitive
        @answer = @answer.downcase 
        @answer_submitted = @answer_submitted.downcase
     end
                
      if @answer_submitted.eql?(@answer)

       next_card_index = @current_card_index+1

        # check if we are done with the deck
        if @current_deck.cards.size == next_card_index
          format.html { redirect_to user_root_path, notice: 'Done With Deck'}

        # if not done with the deck then go play the next card
        else
          format.html { redirect_to deck_card_game_play_path(@current_deck.id, next_card_index), notice: "Keep It Up!" }
          format.json { head :no_content }
        end

      # if answer submitted is wrong go back to original question 
      else
        format.html { render :play }
        format.json { head :no_content }
      end
    end
  end

  def history
    @current_deck = Deck.find(params[:deck_id])
    @play_times = @current_deck.plts
  end

end
