class GameController < ApplicationController

  def play
      @current_deck = Deck.find(params[:deck_id])
      @past_card_id = params[:card_id]

    # if we are just starting the card id will be 0 so we start on the first card
    if (@past_card_id == '7c55f2000000000000000000')
      #TODO @text = 'first card'
      
      # if there are no card in the deck then redirect to page deck#index
      if (@current_card = @current_deck.cards.first).nil?
        respond_to do |format|
          format.html { redirect_to decks_path, notice: 'Deck does not have any cards'}
          format.json { head :no_content }
        end
      end

    else
      #TODO @text = 'next card'
      #making object_id from cards string version of the object id because params only returns s       tings which allows us to compare object ids in mongodb
      @past_object_id = Moped::BSON::ObjectId.from_string(@past_card_id)

      #get the next card based on the next biggest id 
      if (@current_card = @current_deck.cards.where(:id.gt => @past_object_id).first).nil?
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
    @current_card = @current_deck.cards.find(params[:card_id])
    respond_to do |format|
     # if answer submitted answer is correct
      if @current_card.answer == params[:reply][:answer]
        format.html { redirect_to deck_card_game_play_path(@current_deck.id, @current_card.id), notice: "Keep It Up!" }
        format.json { head :no_content }

      # if answer submitted is wrong go back to original question 
      else
        @past_card_id = params[:past_card_id]
        format.html { render :play }
        format.json { head :no_content }
      end
    end
  end

end
